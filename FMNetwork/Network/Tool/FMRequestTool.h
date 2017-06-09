//
//  FMRequestTool.h
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/25.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import <Foundation/Foundation.h>
#define FM_REQ_APP_ID @"FMydios"
#define FM_REQ_SECRET @"#Ae~3*f5BluV8m!0x4"

@interface FMRequestTool : NSObject

/**
 *  @brief 请求头
 *
 *  @param action 请求action
 *
 *  @return 
 */
+(NSDictionary *)headersWithAction:(NSString *)action;

//获取签名token
/**
 * @param secret 密钥
 * @param paraArray 参数列表
 */
+(NSString *)getTokenStr:(NSString*)secret array:(NSArray*)paraArray;

//获取签名token
/**
 * @param paraArray 参数列表
 */
+(NSString *)getTokenStr:(NSArray*)paraArray;

//当前时间毫秒数
+(NSNumber *)currentTimeStamp;
 

@end
