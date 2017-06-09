//
//  FMUtil.h
//  O2BookStore
//
//  Created by 卢双 on 13-9-12.
//  Copyright (c) 2013年 卢双. All rights reserved.
//
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


#import <Foundation/Foundation.h>

@class TYLabel;
@class CommentInfo;

@interface FMUtil : NSObject

+ (id)jasonObjectFromContent:(NSString *)jasonString;

+ (id)jasonObjectFromUrlString:(NSString *)urlStr;

+ (TYLabel *)labelWithFrame:(CGRect)frame text:(NSString *)text;

+ (UIView *)generateComment:(CommentInfo *)commentInfo startY:(NSInteger)startY;

+ (void)viewAppearWithAnimation:(UIView *)view;

+ (void)viewDisappearWithAnimation:(UIView *)view animationDelegate:(id)delegate selector:(SEL)selector;

+ (NSInteger)getHeadIndex;

+ (NSString *)faceImageNameOfHeadIndex:(NSInteger)headIndex;

+ (UIColor *)readBgColorAtIndex:(NSInteger)bgIndex;

+ (UIColor *)readFontColorAtIndex:(NSInteger)bgIndex;


+ (BOOL) IsEnableWIFI;

+ (BOOL) IsEnableWWAN;
//屏幕像素
+(NSString *)screenSizeStr;
/**
 *  判断是否有连接
 *
 */
+ (BOOL) hasNetwork;

+ (BOOL)networkExist;

+ (NSInteger)networkType;

+ (BOOL)isPureNumber:(NSString*)string;

+(BOOL)progressNetRefresh:(CGFloat)progress;
/**
 *  @brief  是不是一个合法的手机号码
 *
 *  @param mobileNum 手机号码字符串
 *
 *  @return 是否合法
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 @brief 判断是不是电信手机号

 @param mobileNum 手机号字符串

 @return 是否合法
 */
+(BOOL)isChinaTelecomMobileNumber:(NSString*)mobileNum;
/**
 *  @brief  验证邮箱合法性
 *
 *  @param email 邮箱
 *
 *  @return 合法或不合法
 */
+(BOOL)isValidateEmail:(NSString *)email;

/**
 *  @brief  获取当前连接的wifi名字
 *
 *  @return 返回wifi的名字
 */
+ (NSString *)getWifiName;

// 返回wifi mac地址
+ (NSString *)getWifiMacAddress;


+ (NSArray *)getAllCityAndProvince;

/**
 *  @brief  获取VersionCode(版本号去掉.号形成的字符)
 *
 *  @return 返回VersionCode
 */
+(NSString *)getVersionCode;

+(BOOL)isCurrentSystemBigOrSameThan:(NSString *)sysVersion;
/**
 *  @brief  获取广告符标识
 *
 *  @return 返回广告标识
 */
+(NSString*)getAdid;
/**
 *  @brief  获取设备ID
 *
 *  @return 返回设备ID标识
 */
+(NSString*)getClientImei;
/**
 *  @brief  获取蜂窝网络
 *
 *  @return 返回网络类型2G/3G/4G/LTE/Wifi
 */
+(NSString*)getCurrentNetWorkType;
+(NSInteger)getCurrentNetWorkTypeForInt;
/**
 *  @brief  判断当前设备是否越狱
 *
 *  @return 返回yes或no
 */
+(BOOL)isJailBrokeDevice;
/**
 *  @brief  获取网络运营商
 *
 *  @return 返回运营商
 */
+(NSString*)getNetWorkOperators;
+(NSInteger)getNetWorkOperatorsForInt;
/**
 *  @brief  对url进行转码
 *
 *  @param originalString 原始url
 *  @param stringEncoding 编码规则
 *
 *  @return 转码后的url
 */
+ (NSString*)URLEncode:(NSString *)originalString
        stringEncoding:(NSStringEncoding)stringEncoding;

//获取当前设备的型号
+(NSString *) platformString;
@end
