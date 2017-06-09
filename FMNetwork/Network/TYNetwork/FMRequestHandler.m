//
//  FMRequestHandler.m
//  FMNetwok
//
//  Created by chengdonghai on 16/5/11.
//  Copyright © 2016年 天翼文化. All rights reserved.
//

#import "FMRequestHandler.h"
#import "FMRequestDefine.h"
#import "FMNetworkConfig.h"

NSString *const FMNetworkRequestParametersKey = @"FMNetworkRequestParametersKey__";
NSString *const FMNetworkRequestHeadersKey = @"FMNetworkRequestHeadersKey__";
#define FM_NETWORK_NO_NETWORK_MESSAGE @"当前没有网络"

@interface FMRequestHandler()

@property(nonatomic,strong) NSMutableDictionary<NSString *,AFHTTPSessionManager *> *sessionManagerPool;
@end
@implementation FMRequestHandler

+ (instancetype)sharedInstance
{
    static dispatch_once_t one;
    static FMRequestHandler *handler;
    dispatch_once(&one, ^{
        handler = [self new];
    });
    return handler;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sessionManagerPool = [NSMutableDictionary dictionary];//用来存放sessionmanager
        
        
    }
    return self;
}

-(void)addRequest:(FMRequest *)req
{
    if (![FMUtil networkExist]) {
        [self handleNoNetwrokWithRequest:req];//处理没网的情况
        return;
    }
    FMRequestMethod method = [req requestMethod];
    FMRequesttype reqtype = [req requesttype];
    id requestParameters = [req requestParameters];
    NSString *url = [self buildRequestUrl: [req requestUrl]];
    NSDictionary *requestHeaders = [req requestHeaders];
    void(^constructingBlock)(id<AFMultipartFormData>) = [[req requestConstructingBlock] copy];
    
    AFHTTPSessionManager *sessionManager = [self getSessionManagerFromPoolWithRequest:req];
    
    //参数转化前
    if ([req respondsToSelector:@selector(requestParameterBeforeConverted:)]) {
        requestParameters = [req requestParameterBeforeConverted:requestParameters];
    }
    
    
    // 参数转化
    if (method == FMRequestMethodPOST) {
        if (req.requestConverter) {
            requestParameters = [req.requestConverter requestParametersForParameters:requestParameters];
        }
    }
    
    // 参数转化后
    if ([req respondsToSelector:@selector(requestParameterAfterConverted:)]) {
        requestParameters = [req requestParameterAfterConverted:requestParameters];
    }
    
    NSMutableDictionary *parametersAndHeaders = [NSMutableDictionary dictionary];
    if (requestParameters) {
        [parametersAndHeaders setObject:requestParameters forKey:FMNetworkRequestParametersKey];
    }
    if (requestHeaders) {
        [parametersAndHeaders setObject:requestHeaders forKey:FMNetworkRequestHeadersKey];
    }
    
    NSURLSessionDataTask *returnedTask = nil;

    if (method == FMRequestMethodGET) {
       returnedTask = [sessionManager GET:url parameters:parametersAndHeaders progress:^(NSProgress * _Nonnull downloadProgress) {
           [self handleInProgressBlock:downloadProgress req:req];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //6.0_lis,网络请求
            [self handleSuccessResponseBlock:task req:req responseObj:responseObject];
            //FMLog(@"Success_Res,URL:%@\nResponse: %@",url,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleFailureResponseBlock:task req:req error:error];
            //FMLog(@"Fail_Res,URL:%@\n%@",url,error);
        }];
        
    } else if (method == FMRequestMethodPOST) {
        if (reqtype == FMRequesttypeNormal) {
            returnedTask = [sessionManager POST:url parameters:parametersAndHeaders progress:^(NSProgress * _Nonnull uploadProgress) {
                [self handleInProgressBlock:uploadProgress req:req];
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleSuccessResponseBlock:task req:req responseObj:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleFailureResponseBlock:task req:req error:error];
            }];
        } else if(reqtype == FMRequesttypeUpload){
            [sessionManager POST:url parameters:parametersAndHeaders constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                if (constructingBlock) {
                    constructingBlock(formData);
                }
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                [self handleInProgressBlock:uploadProgress req:req];
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleSuccessResponseBlock:task req:req responseObj:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleFailureResponseBlock:task req:req error:error];
            }];
        }
        
     
        
    } else if (method == FMRequestMethodHEAD) {
        returnedTask = [sessionManager HEAD:url parameters:parametersAndHeaders success:^(NSURLSessionDataTask * _Nonnull task) {
            [self handleSuccessResponseBlock:task req:req responseObj:nil];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleFailureResponseBlock:task req:req error:error];

        }];
    }
    req.task = returnedTask;
}



-(void)removeRequest:(FMRequest *)req
{
    [req.task cancel];
}

// progress回调
-(void)handleInProgressBlock:(NSProgress *)progress req:(FMRequest *)req
{
    req.progress = progress;
    if (req.inRequest) {
        req.inRequest(req);
    }
    
}
// 成功回调
-(void)handleSuccessResponseBlock:(NSURLSessionDataTask *)task req:(FMRequest *)req responseObj:(id)respObj
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSDictionary *responseHeaders = response.allHeaderFields;
    req.responseHeaders = responseHeaders;//响应头
    req.responseSerializeredObject = respObj;
    
    if ([req respondsToSelector:@selector(responseDataBeforeConverted:)]) {
        respObj = [req responseDataBeforeConverted:respObj];
    }

    if (req.responseConverter) {
        respObj = [req.responseConverter responseDataForResponseObject:respObj];
    }
    
    if ([req respondsToSelector:@selector(responseDataAfterConverted:)]) {
        respObj = [req responseDataAfterConverted:respObj];
    }
    
    req.responseObject = respObj;//响应体

    FMError *error = [req checkSuccessedResponseObj:respObj andResponseHeaders:responseHeaders];
    
    if (error) {
        error.errortype = FMErrortypeBusinessLogic;
        [self handleFilureBlock:req error:error];
    } else {
        if (req.sucess) {
            req.sucess(req);
        }
        [req clearBlock];
        
    }
    
}

// 失败回调
-(void)handleFailureResponseBlock:(NSURLSessionDataTask *)task req:(FMRequest *)req error:(NSError *)error
{
    FMError *FMeror = [req responseDidFailedWithError:error];
    if (FMeror) {
        FMeror.errortype = FMErrortypeHTTP;
        FMeror.httpErrortype = FMHTTPErrortypeOther;
        [self handleFilureBlock:req error:FMeror];
    } else {
        FMError *eor = [[FMError alloc]initWithDomain:error.domain code:error.code userInfo:error.userInfo];
        eor.errorCode = [NSString stringWithFormat:@"%li",(long)error.code];
        if([FMNetworkConfig sharedInstance].networkRequestFailMessage) {
            eor.errorMessage = [FMNetworkConfig sharedInstance].networkRequestFailMessage;
        } else {
            eor.errorMessage = [error localizedDescription];
        }
        eor.errortype = FMErrortypeHTTP;
        eor.httpErrortype = FMHTTPErrortypeOther;

        [self handleFilureBlock:req error:eor];
    }
    
}

//处理没有网络的情况
-(void)handleNoNetwrokWithRequest:(FMRequest *)req
{
    
    NSString *errorMessage = [FMNetworkConfig sharedInstance].noNetworkMessage?:FM_NETWORK_NO_NETWORK_MESSAGE;
    
    FMError *eor = [[FMError alloc]initWithDomain:NSURLErrorDomain code:NSURLErrorNotConnectedToInternet userInfo:@{NSLocalizedDescriptionKey:errorMessage}];
    
    eor.errorCode = [NSString stringWithFormat:@"%li",(long)NSURLErrorNotConnectedToInternet];
    eor.errorMessage = errorMessage;
    FMError *FMeror = [req responseDidFailedWithError:eor];
    if (FMeror) {
        FMeror.errortype = FMErrortypeHTTP;
        FMeror.httpErrortype = FMHTTPErrortypeNoNetwork;
        [self handleFilureBlock:req error:FMeror];
    } else {
        eor.errortype = FMErrortypeHTTP;
        eor.httpErrortype = FMHTTPErrortypeNoNetwork;
        [self handleFilureBlock:req error:eor];
    }
    
}

-(void)handleFilureBlock:(FMRequest *)req error:(FMError *)error
{
    req.error = error;
    if (req.failure) {
        req.failure(req);
    }
    [req clearBlock];
}

//获取sessionmanager，
-(AFHTTPSessionManager *)getSessionManagerFromPoolWithRequest:(FMRequest *)req
{
    
    AFHTTPRequestSerializer * requestSerializer = [req requestSerializer];
    AFHTTPResponseSerializer * responseSerializer = [req responseSerializer];
    NSString *sessionManagerKey =[NSString stringWithFormat:@"%@_%@_%@_%@",NSStringFromClass([requestSerializer class]),NSStringFromClass([responseSerializer class]),NSStringFromClass([req.completionQueue class]),NSStringFromClass([req.completionGroup class])];//这个作为key
    
    AFHTTPSessionManager *sessionManager = self.sessionManagerPool[sessionManagerKey];
    if (sessionManager == nil) {
        sessionManager = [self newSessionManager];
        sessionManager.requestSerializer = requestSerializer;
        sessionManager.responseSerializer = responseSerializer;
        sessionManager.completionQueue = req.completionQueue;
        sessionManager.completionGroup = req.completionGroup;
        self.sessionManagerPool[sessionManagerKey] = sessionManager;
        
    }
    
    
    return sessionManager;
}

-(NSString *)buildRequestUrl:(NSString *)url
{
    NSString *lowerUrl = [url lowercaseString];
    if ([lowerUrl hasPrefix:@"http"]) {
        return [url stringByURLEncoding];
    } else {
        NSString *baseUrl = [FMNetworkConfig sharedInstance].baseUrl;
        if (baseUrl && baseUrl.length > 0) {
            return [[NSString stringWithFormat:@"%@/%@",baseUrl,url] stringByURLEncoding];
        } else {
            return [url stringByURLEncoding];
        }
    }
}
-(AFHTTPSessionManager *)newSessionManager
{
    return [AFHTTPSessionManager manager];
}
@end
