//
//  FMResponseDataConverter.m
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/29.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import "FMResponseDataConverter.h"

@implementation FMResponseDataConverter
NSString *const kFMRootResponseNodeName = @"Response";
NSString *const kFMSecondResponseNodeEndingStr = @"Rsp";

- (instancetype)initWithRespClassNeedArray:(BOOL)needArray
{
    self = [super init];
    if (self) {
        self.respClassNeedArray = needArray;
    }
    return self;
}
+(instancetype)converterWithRespClassNeedArray:(BOOL)needArray modelClass:(Class)modelClass
{
    FMResponseDataConverter *converter = [[FMResponseDataConverter alloc] initWithRespClassNeedArray:needArray];
    converter.respModelClass = modelClass;
    return converter;
}


-(id)responseDataForResponseObject:(id)responseObject
{
    if (responseObject) {
        
        id returnedRepObj = nil;
        
        if (self.respModelClass == nil) {
            returnedRepObj = responseObject;
        } else if ([responseObject isKindOfClass:[NSArray class]]) {
            returnedRepObj = [NSArray yy_modelArrayWithClass:self.respModelClass json:responseObject];
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            returnedRepObj = [self.respModelClass yy_modelWithDictionary:responseObject];
        } else  {
            returnedRepObj = responseObject;
        }
        
        if (self.respClassNeedArray && ![returnedRepObj isKindOfClass:[NSArray class]]) {
            returnedRepObj = @[returnedRepObj];
        }
        return returnedRepObj;
    }
    
    return responseObject;
}

//首字母大写，＋Rsp
+(NSString *)getSecondLevlResponseNodeName:(NSString *)actionName
{
    if (actionName == nil || actionName.length <= 0) {
        return @"";
    }
    NSString *firstCharStr = [actionName substringToIndex:1];
    NSString *otherStr = [actionName substringFromIndex:1];
    
    NSString *rootResponseNodeName = [[[firstCharStr uppercaseString] stringByAppendingString:otherStr] stringByAppendingString:kFMSecondResponseNodeEndingStr];
    return rootResponseNodeName;
}

@end
