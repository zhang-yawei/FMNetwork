//
//  FMGetUserInfoRequest.h
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/26.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import "FMBaseRequest.h"
#import "UserInfo.h"

/**
 *  @brief 获取用户信息（getUserInfo）
 */
@interface FMGetUserInfoRequest : FMBaseRequest


+(void)getUserInfoWithCompletion:(void (^)(void))completion;
@end
