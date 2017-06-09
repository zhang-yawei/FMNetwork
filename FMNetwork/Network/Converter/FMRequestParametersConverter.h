//
//  FMRequestParametersConverter.h
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/29.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMRequestParameterConverterDelegate.h"
extern NSString *const kFMSecondRequestNodeEndingStr;
extern NSString *const kFMRootRequestNodeName;

@interface FMRequestParametersConverter : NSObject<FMRequestParameterConverterDelegate>

@property(nonatomic,copy) NSString *actionName;

- (instancetype)initWithActionName:(NSString *)action;

+(instancetype)converterWithActionName:(NSString *)actionName;

+(NSString *)getSecondLevlRequestNodeName:(NSString *)actionName;


@end
