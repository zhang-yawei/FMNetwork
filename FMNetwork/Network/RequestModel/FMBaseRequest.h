//
//  FMBaseRequest.h
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/25.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import "FMRequest.h"
#import "FMObjectUtil.h"
#import "FMRequestTool.h"

@interface FMBaseRequest : FMRequest

- (instancetype)initWithAction:(NSString *)action andParameter:(NSDictionary *)param;
+ (instancetype)requestWithAction:(NSString *)action andParamter:(NSDictionary *)param;

@property(nonatomic,copy) NSString *action;
@property(nonatomic,copy) NSDictionary *param;
@property(nonatomic) FMRequestMethod reqMethod;
@property(nonatomic) Class respModelClass;
@property(nonatomic) BOOL resptypeNeedArray;//响应报文是否需要是数组
@property(nonatomic,copy) NSString *convertNodePath;
//start With Header Action
-(void)startWithAction:(NSString *)action;

-(void)startWithAction:(NSString *)action andSuccess:(FMRequestBlock)success;

-(void)startWithAction:(NSString *)action andSuccess:(FMRequestBlock)success andFailure:(FMRequestBlock)failure;

-(void)startWithAction:(NSString *)action andSuccess:(FMRequestBlock)success inRequest:(FMRequestBlock)inRequest;

-(void)startWithAction:(NSString *)action andSuccess:(FMRequestBlock)success inRequest:(FMRequestBlock)inRequest andFailure:(FMRequestBlock)failure;



@end
