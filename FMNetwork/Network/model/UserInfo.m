//
//  UserInfo.m
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/26.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import "UserInfo.h"
#import <YYModel.h>

#pragma mark - 7.2.1获取用户个性化信息接口（getUserInfo）
@implementation UserInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nickName = @"";
        self.headId = @"";
        self.mobile = @"";
        self.sex = 0;
        self.age = 0;
        self.province = @"";
        self.ciFM = @"";
        self.descriptions = @"";
        self.deviceId = @"";
        self.email = @"";
        self.intrest = @"";
        self.experienceValue = 0;
        self.level = @"";
        self.nextLevel = @"";
        self.title = @"";
        self.overdueReadPoint = 0;
        self.professional = @"";
        self.score = 0;
        self.readPoint = 0;
        self.userCode = @"";
        self.canConvert = 0;
        self.birthday = nil;
        self.FaceUrl = @"";
        self.buyReadPoint=@"";
        self.vipLevel = 0;
        self.memberRightLevel = 0;
        self.memberPackageLevel = @"";
        self.catalogtypeId = @""; //6.0_xiaoyu
    }
    return self;
}

+ (NSDictionary *)modelCustomProperFMMapper
{
    return @{@"NickName":@"nickName",
             @"HeadID":@"headId",
             @"Mobile":@"mobile",
             @"Sex":@"sex",
             @"Age":@"age",
             @"Province":@"province",
             @"CiFM":@"ciFM",
             @"Description":@"descriptions",
             @"DeviceID":@"deviceId",
             @"E-Mail":@"email",
             @"Interest":@"intrest",
             @"Experience":@"experienceValue",
             @"Level":@"level",
             @"memberRightLevel":@"memberRightLevel",
             @"memberPackageLevel":@"memberPackageLevel",
             @"memberPackageLevelName":@"memberPackageLevelName",
             @"vipLevel":@"vipLevel",
             @"NextLevel":@"nextLevel",
             @"Title":@"title",
             @"Professional":@"professional",
             @"score":@"score",
             @"readPoint":@"readPoint",
             @"overdueReadPoint":@"overdueReadPoint",
             @"userCode":@"userCode",
             @"canConvert":@"canConvert",
             @"Birthday":@"birthday",
             @"FaceUrl":@"FaceUrl",
             @"buyReadPoint":@"buyReadPoint",
             @"downloadablePackage":@"downloadablePackage",//getUserInfo新增返回字段downloadablePackage，返回该用户能够下载的包月包id，多个包月包id用“,”逗号隔开，如果没有则不返回该字段。
             @"noAd":@"noAd"};//新增返回boolean字段noAd，根据用户会员等级权限设置，返回是否允许显示广告，为true时不允许显示广告。
}
@end
