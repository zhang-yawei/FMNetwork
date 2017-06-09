//
//  NSObject+FMString.h
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/25.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FMTrim(obj) [FMObjectUtil trim:obj]
#define FMIsEmpFM(obj) [FMObjectUtil isEmpFM:obj]

@interface FMObjectUtil : NSObject

/**
 *  @brief 是否是空
 *
 *
 *  @return 是或不是
 */
+(BOOL)isEmpty:(id)obj;

/**
 *  @brief trim，如果不是NString类型返回空字符串，否则trim它。
 *
 *
 *  @return 返回trim之后的字符串
 */
+(NSString *)trim:(id)obj;

@end
