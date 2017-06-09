//
//  NSString+NSString_MD5.m
//  SurfingReader
//
//  Created by 任玺 on 14-2-18.
//  Copyright (c) 2014年 任玺. All rights reserved.
//

#import "NSString+NSString_MD5.h"
#import <CommonCrypto/CommonDigest.h>

@interface NSString (md5)
-(NSString *) md5HexDigest;
@end

@implementation NSString (md5)
-(NSString *) md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
    
}

+ (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<16; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }

    return ret;
}
@end



