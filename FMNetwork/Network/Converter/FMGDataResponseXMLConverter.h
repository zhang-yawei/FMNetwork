//
//  FMGDataResponseXMLConverter.h
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/9/8.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMResponseDataConverterDelegate.h"
@interface FMGDataResponseXMLConverter : NSObject<FMResponseDataConverterDelegate>
+(instancetype)converter;

@end
