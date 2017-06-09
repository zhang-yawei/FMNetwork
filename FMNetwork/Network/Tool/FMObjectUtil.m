//
//  NSObject+TYString.m
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/25.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import "FMObjectUtil.h"

@implementation FMObjectUtil

+(BOOL)isEmpty:(id)obj
{
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)obj;
        
        NSString *trimStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([trimStr isEqualToString:@""] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"]) {
            return YES;
        }
    } else if ([obj respondsToSelector:@selector(length)]
               && [(NSData *)obj length] == 0) {
        return YES;
    } else if ([obj respondsToSelector:@selector(count)]
               && [(NSArray *)obj count] == 0) {
        return YES;
    }
    return NO;
    
}

+(NSString *)trim:(id)obj
{
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    if (![obj isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%@",obj];
    }
    
    NSString *str = (NSString *)obj;
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
