//
//  FMResponseDataConverter.h
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/29.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResponseDataConverterDelegate.h"

extern NSString *const kFMRootResponseNodeName;
extern NSString *const kFMSecondResponseNodeEndingStr;

@interface FMResponseDataConverter : NSObject<FMResponseDataConverterDelegate>

@property(nonatomic) BOOL respClassNeedArray;
@property(nonatomic) Class respModelClass;

- (instancetype)initWithRespClassNeedArray:(BOOL)respClassNeedArray;
+(instancetype)converterWithRespClassNeedArray:(BOOL)respClassNeedArray modelClass:(Class)modelClass;
+(NSString *)getSecondLevlResponseNodeName:(NSString *)actionName;

@end
