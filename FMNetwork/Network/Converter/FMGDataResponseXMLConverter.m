//
//  FMGDataResponseXMLConverter.m
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/9/8.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import "FMGDataResponseXMLConverter.h"
#import "FMResponseDataConverter.h"

@implementation FMGDataResponseXMLConverter

+(instancetype)converter
{
    FMGDataResponseXMLConverter *converter = [[FMGDataResponseXMLConverter alloc] init];
    return converter;
}

-(id)responseDataForResponseObject:(id)responseObject
{
    
    if(responseObject == nil || ([responseObject isKindOfClass:[NSString class]] && [responseObject isEqualToString:@""])) {
        return nil;
    }
  
    return responseObject;
}

@end
