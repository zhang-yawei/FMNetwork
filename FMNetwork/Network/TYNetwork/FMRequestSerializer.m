//
//  FMRequestSerializer.m
//  FMNetwork
//
//  Created by chengdonghai on 16/5/12.
//  Copyright © 2016年 天翼文化. All rights reserved.
//

#import "FMRequestSerializer.h"

#import "FMRequestHandler.h"

@implementation FMRequestSerializer

#pragma mark - AFURLRequestSerialization

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(request);
    id reqParameters = [parameters objectForKey:FMNetworkRequestParametersKey];
    id reqHeaders = [parameters objectForKey:FMNetworkRequestHeadersKey];

    if ([self.HTTPMethodsEncodingParametersInURI containsObject:[[request HTTPMethod] uppercaseString]]) {
        
        NSURLRequest *req = [super requestBySerializingRequest:request withParameters:reqParameters error:error];
        NSMutableURLRequest *mutableRequest = [req mutableCopy];

        [self addCustomHeadersInReq:mutableRequest request:req headers:reqHeaders];
        return mutableRequest;
    }else{
        
    // post 的情况
     NSURLRequest *req = [super requestBySerializingRequest:request withParameters:reqParameters error:error];
    
     NSMutableURLRequest *mutableRequest = [req mutableCopy];
    
    [self addCustomHeadersInReq:mutableRequest request:request headers:reqHeaders];

    return mutableRequest;
    }
}

-(NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method URLString:(NSString *)URLString parameters:(NSDictionary<NSString *,id> *)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block error:(NSError *__autoreleasing  _Nullable *)error
{
    id reqParameters = [parameters objectForKey:FMNetworkRequestParametersKey];
    id reqHeaders = [parameters objectForKey:FMNetworkRequestHeadersKey];
    NSMutableURLRequest *mutableRequest = [super multipartFormRequestWithMethod:method URLString:URLString parameters:reqParameters constructingBodyWithBlock:block error:error];
    NSURLRequest *request = [mutableRequest copy];
    [self addCustomHeadersInReq:mutableRequest request:request headers:reqHeaders];
    return mutableRequest;
}

-(void)addCustomHeadersInReq:(NSMutableURLRequest *)mutableRequest request:(NSURLRequest *)request headers:(id)headers
{
    [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull field, id  _Nonnull value, BOOL * _Nonnull stop) {
        if (![request valueForHTTPHeaderField:field]) {
            [mutableRequest setValue:value forHTTPHeaderField:field];
        }
    }];
}
@end
