//
//  NSString+NSString_MD5.h
//  SurfingReader
//
//  Created by 任玺 on 14-2-18.
//  Copyright (c) 2014年 任玺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

-(NSString *) md5HexDigest;
+ (NSString *)md5HexDigest:(NSString*)input;

@end
