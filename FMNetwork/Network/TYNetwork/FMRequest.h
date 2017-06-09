//
//  FMRequest.h
//  FMNetwok
//
//  Created by chengdonghai on 16/5/11.
//  Copyright © 2016年 天翼文化. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "FMRequestDefine.h"
#import <AFNetworking.h>
#import "FMError.h"
#import "FMRequestParameterConverterDelegate.h"
#import "FMResponseDataConverterDelegate.h"

//Request task finished block


@class FMRequest;

typedef void(^FMConstructingBlock)(id<AFMultipartFormData> formData);

typedef void(^FMRequestBlock)(FMRequest *req);

@protocol FMRequestDelegate <NSObject>

@required

//request url
-(NSString *)requestUrl;

//request headers
-(NSDictionary *)requestHeaders;

//request parameters
-(id)requestParameters;

//request method @FMRequestMethod
-(FMRequestMethod)requestMethod;

-(FMRequesttype)requesttype;

@optional

-(FMConstructingBlock)requestConstructingBlock;

-(AFHTTPRequestSerializer *)requestSerializer;

// 参数转化前
-(id)requestParameterBeforeConverted:(id)requestParameter;

// 参数转化后
-(id)requestParameterAfterConverted:(id)requestParameter;

@end

@protocol FMResponseDelegate <NSObject>

@required

-(FMError *)checkSuccessedResponseObj:(id)responseObj andResponseHeaders:(NSDictionary *)headers;

-(FMError *)responseDidFailedWithError:(NSError *)error;

@optional
-(id)responseDataBeforeConverted:(id)responseObj;

-(id)responseDataAfterConverted:(id)responseObj;

-(AFHTTPResponseSerializer *)responseSerializer;

@end



@interface FMRequest : NSObject <FMRequestDelegate,FMResponseDelegate>

@property (nonatomic, copy) FMRequestBlock sucess;
@property (nonatomic, copy) FMRequestBlock failure;
@property (nonatomic, copy) FMRequestBlock inRequest;
@property (nonatomic, strong) id<FMRequestParameterConverterDelegate> requestConverter; //统一转化参数
@property (nonatomic, strong) id<FMResponseDataConverterDelegate> responseConverter;

/**
 *  @brief request task object
 */
@property (nonatomic, strong) NSURLSessionDataTask *task;
/**
 *  @brief response object
 */
@property (nonatomic, strong) id responseObject;
@property (nonatomic, strong) id responseSerializeredObject;
/**
 *  @brief response headers
 */
@property (nonatomic, strong) NSDictionary* responseHeaders;

/**
 The dispatch group for `completionBlock`. If `NULL` (default), a private dispatch group is used.
 */
@property (nonatomic, strong) dispatch_group_t completionGroup;

/**
 The dispatch queue for `completionBlock`. If `NULL` (default), the main queue is used.
 */
@property (nonatomic, strong) dispatch_queue_t completionQueue;

/**
 *  @brief request error.
 */
@property (nonatomic, strong) FMError *error;

/**
 *  @brief request progress.
 */
@property (nonatomic, strong) NSProgress *progress;

/**
 *  @brief start request
 */
-(void) start;
-(void) startWithSuccess:(FMRequestBlock)success;
-(void) startWithSuccess:(FMRequestBlock)success andFailure:(FMRequestBlock)failure;
-(void) startWithSuccess:(FMRequestBlock)success inRequest:(FMRequestBlock)inRequest;
-(void) startWithSuccess:(FMRequestBlock)success inRequest:(FMRequestBlock)inRequest andFailure:(FMRequestBlock)failure;

/**
 *  @brief cancel request
 */
-(void) cancel;

/**
 *  @brief clear request
 */
-(void) clear;

/**
 *  @brief clear block
 */
-(void) clearBlock;

@end
