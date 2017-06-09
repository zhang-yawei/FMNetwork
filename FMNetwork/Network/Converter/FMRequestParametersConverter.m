//
//  FMRequestParametersConverter.m
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/29.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import "FMRequestParametersConverter.h"


NSString *const kFMSecondRequestNodeEndingStr = @"Req";
NSString *const kFMRootRequestNodeName = @"Request";

@implementation FMRequestParametersConverter

- (instancetype)initWithActionName:(NSString *)action
{
    self = [super init];
    if (self) {
        self.actionName = action;
    }
    return self;
}

+(instancetype)converterWithActionName:(NSString *)actionName
{
    FMRequestParametersConverter *converter = [[FMRequestParametersConverter alloc] initWithActionName:actionName];
    return converter;
}


-(id)requestParametersForParameters:(id)parameters
{
    if (parameters) {
        NSMutableDictionary *newParamters = [NSMutableDictionary dictionary];
        
        return newParamters;
    }
    return parameters;
}



@end
