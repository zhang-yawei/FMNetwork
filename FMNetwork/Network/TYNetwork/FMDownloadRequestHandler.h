//
//  FMDownloadRequestHandler.h
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/28.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDownloadRequest;

@interface FMDownloadRequestHandler : NSObject
@property(nonatomic,strong) AFHTTPSessionManager *sessionManager;

+ (instancetype)sharedInstance;

-(void)addDownloadRequest:(FMDownloadRequest *)downloadReq;
-(void)removeDownloadRequest:(FMDownloadRequest *)downloadReq;

@end
