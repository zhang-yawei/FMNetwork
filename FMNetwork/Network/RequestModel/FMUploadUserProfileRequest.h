//
//  FMUploadUserProfileRequest.h
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/28.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import "FMBaseRequest.h"

@interface FMUploadUserProfileRequest : FMBaseRequest

@property(nonatomic,strong) UIImage *profileimage;
- (instancetype)initWithImage:(UIImage *)profileimage;

@end
