//
//  NSString+UrlEncode.m
//  FMNetwork
//
//  Created by zhang on 2017/6/8.
//  Copyright © 2017年 zhangdawei. All rights reserved.
//

#import "NSString+UrlEncode.h"

@implementation NSString (UrlEncode)

-(NSString *)stringByURLEncoding
{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end
