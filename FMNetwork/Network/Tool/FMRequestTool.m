//
//  FMRequestTool.m
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/25.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import "FMRequestTool.h"
#import "FMServerAddressConfig.h"
#import "FMUtil.h"

#import "NSString+NSString_MD5.h"


@implementation FMRequestTool

+(NSDictionary *)headersWithAction:(NSString *)action
{
    
    //FMServerAddressConfig *config = [FMServerAddressConfig sharedInstance];



    NSMutableDictionary *header = [NSMutableDictionary dictionary];
   
    [header setObject:[FMUtil getClientImei]?:@"" forKey:@"client-imei"];

    return header;
    
}

//参数列表拼接成字符串外加密钥
+(NSString *)getTokenStr:(NSString*)secret array:(NSArray*)paraArray{
    
    NSMutableArray *muArr = [paraArray mutableCopy];
    [muArr addObject:secret];
    NSMutableString *str=[[NSMutableString alloc]init];
    for (id param in muArr) {
        [str appendFormat:@"%@",param?:@""];
    }
    return  [str md5HexDigest];
}

+(NSString *)getTokenStr:(NSArray*)paraArray{
    return [self getTokenStr:FM_REQ_SECRET array:paraArray];
}

+(NSNumber *)currentTimeStamp
{
    return [NSNumber numberWithUnsignedLongLong:([[NSDate date] timeIntervalSince1970] * 1000)];
}


@end
