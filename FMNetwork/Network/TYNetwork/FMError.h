//
//  FMError.h
//  FMNetwork
//
//  Created by chengdonghai on 16/5/13.
//  Copyright © 2016年 天翼文化. All rights reserved.
//

#import <Foundation/Foundation.h>
//错误类型
typedef enum : NSUInteger {
    FMErrortypeHTTP = 1,
    FMErrortypeBusinessLogic,
    FMErrortypeOther
} FMErrortype;
//http 错误类型
typedef enum : NSUInteger {
    FMHTTPErrortypeNoNetwork = 1,
    FMHTTPErrortypeOther
} FMHTTPErrortype;

@interface FMError : NSError

- (instancetype)initWithErrorCode:(NSString *)code errorMessage:(NSString *)errorMessage;

@property(nonatomic,copy) NSString *errorCode;
@property(nonatomic,copy) NSString *errorMessage;
@property(nonatomic) FMErrortype errortype;
@property(nonatomic) FMHTTPErrortype httpErrortype;

@property(nonatomic,assign,readonly) NSInteger errorCodeForInt;

@end
