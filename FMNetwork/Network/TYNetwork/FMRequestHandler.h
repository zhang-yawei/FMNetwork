//
//  FMRequestHandler.h
//  FMNetwok
//
//  Created by chengdonghai on 16/5/11.
//  Copyright © 2016年 天翼文化. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "FMRequest.h"

extern NSString *const FMNetworkRequestParametersKey;
extern NSString *const FMNetworkRequestHeadersKey;


@interface FMRequestHandler : NSObject

/**
 *  @brief singleton
 *
 *  @return instance
 */
+ (instancetype)sharedInstance;

/**
 *  @brief add HTTP request
 *
 *  @param req request object
 */
-(void)addRequest:(FMRequest *)req;

/**
 *  @brief remove request
 *
 *  @param req request object
 */
-(void)removeRequest:(FMRequest *)req;

@end
