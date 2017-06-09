//
//  UserInfo.h
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/26.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 7.2.1获取用户个性化信息接口（getUserInfo）
@interface UserInfo : NSObject

@property (nonatomic, copy) NSString *nickName;                     // 用户昵称
@property (nonatomic, copy) NSString *headId;                       // 头像ID
@property (nonatomic, copy) NSString *mobile;                       // 手机号码
@property (nonatomic) NSInteger sex;                                // 1代表男性 2代表女性 -1代表保密
@property (nonatomic) NSInteger age;                                // 年龄
@property (nonatomic, copy) NSString *province;                     // 省份
@property (nonatomic, copy) NSString *ciFM;                         // 城市
@property (nonatomic, copy) NSString *descriptions;                  // 个人介绍
@property (nonatomic, copy) NSString *deviceId;                     // 所绑定的手持终端的ID，-1代表该手机没有绑定手持终端
@property (nonatomic, copy) NSString *email;                        // 用户E-Mail
@property (nonatomic, copy) NSString *intrest;                      // 爱好
@property (nonatomic) NSInteger experienceValue;                    // 用户经验值
@property (nonatomic, copy) NSString *level;                        // 当前级别_经验值区间  如：童生LV1_0_100
@property(nonatomic) NSInteger memberRightLevel;                 //用户财富等级
@property(nonatomic,copy) NSString *memberPackageLevel;                 //用户包月等级
@property(nonatomic,copy) NSString *memberPackageLevelName;                 //用户包月等级名称

@property (nonatomic) NSInteger vipLevel;                      //1：一般用户 2：普通会员 3：vip会员
@property   (nonatomic) NSInteger overdueReadPoint;              //即将过期的阅点
@property (nonatomic, copy) NSString *nextLevel;                    // 下个级别_经验值区间  如：童生LV2_101_200
@property (nonatomic, copy) NSString *title;                        // 头衔
@property (nonatomic, copy) NSString *professional;                 // 职业
@property (nonatomic) NSInteger score;                              // 积分
@property (nonatomic) NSInteger readPoint;                          // 阅点
@property (nonatomic, copy) NSString *userCode;                     // 登录账号
@property (nonatomic) NSInteger canConvert;                         // 是否开放积分兑换阅点 1.开放2.未开放
@property (nonatomic, retain) NSDate *birthday;                     // 生日
@property (nonatomic, copy) NSString *FaceUrl;                      //上传头像图片的url
@property (nonatomic,copy)NSString *buyReadPoint;
@property (nonatomic, strong) NSString  *catalogtypeId;             //6.0_xiaoyu_用户类型
@property (nonatomic, copy) NSString  *downloadablePackage;             //downloadablePackage，返回该用户能够下载的包月包id
@property (nonatomic) BOOL noAd;//根据用户会员等级权限设置，返回是否允许显示广告，为true时不允许显示广告


+ (NSDictionary *)modelCustomProperFMMapper;

@end
