//
//  FMError.m
//  FMNetwork
//
//  Created by chengdonghai on 16/5/13.
//  Copyright © 2016年 天翼文化. All rights reserved.
//

#import "FMError.h"

@implementation FMError

- (instancetype)initWithErrorCode:(NSString *)code errorMessage:(NSString *)errorMessage
{
    self = [super init];
    if (self) {
        _errorCode = code;
        _errorMessage = errorMessage;
    }
    return self;
}

-(NSInteger)errorCodeForInt
{
    return [self.errorCode integerValue];
}

@end
