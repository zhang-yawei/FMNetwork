//
//  FMGetUserInfoRequest.m
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/26.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import "FMGetUserInfoRequest.h"

@implementation FMGetUserInfoRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.action = @"getUserInfo";
    }
    return self;
}

-(id)responseDataAfterConverted:(id)responseObj
{
    NSArray *array = [responseObj valueForKeyPath:@"UserInfo.ParameterList.Parameter"];
    UserInfo *uinfo = [UserInfo new];
    NSDictionary *mapperDict =[UserInfo modelCustomProperFMMapper];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *item = obj;
        NSString *paramName = item[@"name"];
        id paramValue = item[@"value"];
        
        if ([paramName isEqualToString:@"Birthday"]) {
            NSDateFormatter *formater = [[NSDateFormatter alloc] init];
            [formater setDateFormat:@"yyyy-MM-dd"];
            
            uinfo.birthday = [formater dateFromString:paramValue];
        } else {
            if (mapperDict[paramName] && paramValue) {
                if ([paramValue isKindOfClass:[NSString class]]) {
                    NSString *temp = [FMTrim(paramValue) lowercaseString];
                    if ([temp isEqualToString:@"false"] || [temp isEqualToString:@"no"] ) {
                        paramValue = @(NO);
                    } else if ([temp isEqualToString:@"true"] || [temp isEqualToString:@"yes"]) {
                        paramValue = @(YES);
                    }
                }
                [uinfo setValue:paramValue forKey:mapperDict[paramName]];
            }
        }
        
        
    }];
    return uinfo;
}


@end
