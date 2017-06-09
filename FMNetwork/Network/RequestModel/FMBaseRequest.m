//
//  FMBaseRequest.m
//  SurfingReader_V4.0
//
//  Created by chengdonghai on 16/8/25.
//  Copyright © 2016年 天翼阅读. All rights reserved.
//

#import "FMBaseRequest.h"
#import "FMRequestSerializer.h"
#import "FMResponseSerializer.h"
#import "FMRequestParametersConverter.h"
#import "FMResponseDataConverter.h"


@implementation FMBaseRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _reqMethod = FMRequestMethodGET;
        self.requestConverter = [FMRequestParametersConverter converterWithActionName:nil];
        self.responseConverter = [FMResponseDataConverter converterWithRespClassNeedArray:self.resptypeNeedArray modelClass:nil];
    }
    return self;
}
- (instancetype)initWithAction:(NSString *)action andParameter:(NSDictionary *)param
{
    self = [super init];
    if (self) {
        _action = action;
        _param = param;
        _reqMethod = FMRequestMethodGET;
        self.requestConverter = [FMRequestParametersConverter converterWithActionName:action];
        self.responseConverter = [FMResponseDataConverter converterWithRespClassNeedArray:self.resptypeNeedArray modelClass:nil];
    }
    return self;
}

+(instancetype)requestWithAction:(NSString *)action andParamter:(NSDictionary *)param
{
    return [[self alloc]initWithAction:action andParameter:param];
}

-(void)setAction:(NSString *)action
{
    //6.0_lis,网络请求
    _action = action;
    FMLog(@"Action: %@",action);
    ((FMRequestParametersConverter *)self.requestConverter).actionName = action;
}

-(void)setRespModelClass:(Class)respModelClass
{
    _respModelClass = respModelClass;
    ((FMResponseDataConverter*)self.responseConverter).respModelClass = respModelClass;
}

-(void)setResptypeNeedArray:(BOOL)resptypeNeedArray
{
    _resptypeNeedArray = resptypeNeedArray;
    ((FMResponseDataConverter*)self.responseConverter).respClassNeedArray = resptypeNeedArray;
}

-(NSString *)requestUrl
{
    return @"portalapi/portalapi";
}

-(NSDictionary *)requestHeaders
{
    return [FMRequestTool headersWithAction:self.action];
}

-(id)requestParameters
{
    return self.param;
}

-(FMRequestMethod)requestMethod
{
    return self.reqMethod;
}

-(FMError *)checkSuccessedResponseObj:(id)responseObj andResponseHeaders:(NSDictionary *)headers
{
    NSString *resultCode = headers[@"result-code"];
    //6.0_lis,网络请求
    if (resultCode!= nil && [resultCode isEqualToString:@"0"]) {//响应成功
        //FMLog(@"Success_Action: %@, responseObj: %@",self.action, responseObj);
        return nil;
    } else {
        FMError *eor = [[FMError alloc]initWithErrorCode:resultCode errorMessage:[self convertErrorCode:resultCode]];
        //FMLog(@"Fail_Action: %@, responseObj: %@",self.action, eor);
        return eor;
    }
    
}

/**
 *  @brief 响应状态码转换
 *
 *  @param resultCode 状态码
 *
 *  @return 描述
 */
- (NSString *)convertErrorCode:(NSString *)resultCode
{
    if ([resultCode isEqualToString:@"1"]) return @"正在下载";
    if ([resultCode isEqualToString:@"-100"]) return @"网络连接失败或服务器繁忙，请稍后再试";
    if ([resultCode isEqualToString:@"-101"]) return @"您未购买此书，不能下载";
    if ([resultCode isEqualToString:@"-102"]) return @"连载书籍不能加入下载";
    if ([resultCode isEqualToString:@"0"]) return @"成功";
    if ([resultCode isEqualToString:@"2001"]) return @"协议版本不支持";
    if ([resultCode isEqualToString:@"2002"]) return @"非法的用户标识";
    if ([resultCode isEqualToString:@"2003"]) return @"非法的客户端";
    if ([resultCode isEqualToString:@"2004"]) return @"非法的请求接口";
    if ([resultCode isEqualToString:@"2005"]) return @"请求参数缺失";
    if ([resultCode isEqualToString:@"2006"]) return @"无效的参数";
    if ([resultCode isEqualToString:@"2007"]) return @"不支持的操作";
    if ([resultCode isEqualToString:@"2008"]) return @"会话超时";
    if ([resultCode isEqualToString:@"2009"]) return @"不支持的用户信息参数";
    if ([resultCode isEqualToString:@"2010"]) return @"无效的手机号码";
    if ([resultCode isEqualToString:@"2012"]) return @"无效的频道分栏标识";
    if ([resultCode isEqualToString:@"2013"]) return @"无效的内容标识";
    if ([resultCode isEqualToString:@"2014"]) return @"无效的排行榜类型";
    if ([resultCode isEqualToString:@"2015"]) return @"无效的时间格式";
    if ([resultCode isEqualToString:@"2016"]) return @"用户未订购";
    if ([resultCode isEqualToString:@"2017"]) return @"重复的记录";
    if ([resultCode isEqualToString:@"2018"]) return @"书签已存在";
    if ([resultCode isEqualToString:@"2019"]) return @"内容已被收藏";
    if ([resultCode isEqualToString:@"2020"]) return @"更新通知已预定";
    if ([resultCode isEqualToString:@"2021"]) return @"更新通知未预定";
    if ([resultCode isEqualToString:@"2022"]) return @"非法的用户状态";
    if ([resultCode isEqualToString:@"2023"]) return @"业务订购失败";
    if ([resultCode isEqualToString:@"2024"]) return @"业务取消订购失败";
    if ([resultCode isEqualToString:@"2025"]) return @"没有内容的访问权限";
    if ([resultCode isEqualToString:@"2026"]) return @"验证码错误或者验证码已过期";
    if ([resultCode isEqualToString:@"2027"]) return @"用户操作已达到每日次数限制";
    if ([resultCode isEqualToString:@"2028"]) return @"用户操作已达到上限（收藏/书签/评论）";
    if ([resultCode isEqualToString:@"2029"]) return @"用户已定购";
    if ([resultCode isEqualToString:@"2030"]) return @"用户已投票";
    if ([resultCode isEqualToString:@"2031"]) return @"系统书签不存在";
    if ([resultCode isEqualToString:@"2032"]) return @"用户已被禁言";
    if ([resultCode isEqualToString:@"2033"]) return @"内容禁止评论";
    if ([resultCode isEqualToString:@"2034"]) return @"已经是最新版本了"; //客户端版本号不存在
    if ([resultCode isEqualToString:@"2035"]) return @"必要的报头信息不存在";
    if ([resultCode isEqualToString:@"2036"]) return @"必要的报文信息不存在";
    if ([resultCode isEqualToString:@"2037"]) return @"已达到内容的全局评论数";
    if ([resultCode isEqualToString:@"2038"]) return @"用户名或者密码错误";
    if ([resultCode isEqualToString:@"2039"]) return @"请输入正确的手机号码或邮箱地址";
    if ([resultCode isEqualToString:@"2040"]) return @"验证码错误";
    if ([resultCode isEqualToString:@"2041"]) return @"根据imsi无法从udb获取mdn手机号码";
    if ([resultCode isEqualToString:@"2042"]) return @"余额不足，请充值后重新购买";
    if ([resultCode isEqualToString:@"2043"]) return @"账号密码输入错误次数达到平台设置上限";
    if ([resultCode isEqualToString:@"2999"]) return @"其他客户端请求错误";
    if ([resultCode isEqualToString:@"3001"]) return @"请求超时";
    if ([resultCode isEqualToString:@"3002"]) return @"服务器忙";
    if ([resultCode isEqualToString:@"3003"]) return @"服务器维护中";
    if ([resultCode isEqualToString:@"3004"]) return @"服务器数据库异常";
    if ([resultCode isEqualToString:@"3010"]) return @"服务器暂时不支持此功能";
    if ([resultCode isEqualToString:@"3999"]) return @"其他服务器错误";//@"其他服务器错误";
    if ([resultCode isEqualToString:@"2044"]) return @"用户邮箱已存在";
    if ([resultCode isEqualToString:@"2045"]) return @"用户名已存在";
    if ([resultCode isEqualToString:@"2046"]) return @"用户或者密码为空";
    if ([resultCode isEqualToString:@"2050"]) return @"账号不存在";
    if ([resultCode isEqualToString:@"2051"]) return @"输入渠道错误";
    if ([resultCode isEqualToString:@"2052"]) return @"阅点券卡号与密码错误";
    if ([resultCode isEqualToString:@"2053"]) return @"此阅点券已经被充值";
    if ([resultCode isEqualToString:@"2054"]) return @"此阅点券已经超过充值截止日期";
    if ([resultCode isEqualToString:@"2055"]) return @"充值失败";
    if ([resultCode isEqualToString:@"2101"]) return @"兑换数量超出单次上限";
    if ([resultCode isEqualToString:@"2102"]) return @"用户积分不足";
    if ([resultCode isEqualToString:@"2103"]) return @"用户id不存在";
    if ([resultCode isEqualToString:@"2104"]) return @"积分兑换规则不存在";
    if ([resultCode isEqualToString:@"2107"]) return @"兑换数量大于剩余可兑换数量";
    if ([resultCode isEqualToString:@"2108"]) return @"获取阅点卷失败";
    if ([resultCode isEqualToString:@"2109"]) return @"兑换数量超出上限";
    if ([resultCode isEqualToString:@"2110"]) return @"查询剩余阅点卷数量失败";
    if ([resultCode isEqualToString:@"2111"]) return @"剩余阅点卷可兑换数量小于需要兑换的数量";
    if ([resultCode isEqualToString:@"2112"]) return @"产品接口出现异常";
    if ([resultCode isEqualToString:@"2113"]) return @"剩余可兑换数量为0";
    if ([resultCode isEqualToString:@"2114"]) return @"此积分规则已结束兑换";
    if ([resultCode isEqualToString:@"2115"]) return @"积分兑换规则还没开始";
    if ([resultCode isEqualToString:@"2116"]) return @"该书已赠送";
    if ([resultCode isEqualToString:@"2117"]) return @"有声token鉴权不通过";
    if ([resultCode isEqualToString:@"2118"]) return @"赠送账号非阅读用户";
    if ([resultCode isEqualToString:@"2119"]) return @"您已签到";   //@"您已签到";
    if ([resultCode isEqualToString:@"2220"]) return @"该IMSI未注册";
    if ([resultCode isEqualToString:@"2221"]) return @"该书籍无版权 ";
    if ([resultCode isEqualToString:@"2222"]) return @"该分栏下无此类型书籍";
    if ([resultCode isEqualToString:@"2223"]) return @"当前内容无下一期（集）";
    if ([resultCode isEqualToString:@"2228"]) return @"已领取";
    if ([resultCode isEqualToString:@"2248"]) return @"亲，小阅检测到您所发布的内容涉及敏感内容，请重新编辑后提交，谢谢！";
    if ([resultCode isEqualToString:@"2054"]) return @"已过期";
    if ([resultCode isEqualToString:@"2224"]) return @"无启动界面图片信息";
    if ([resultCode isEqualToString:@"2232"]) return @"获取书籍tags失败";   //获取书籍tags失败
    if ([resultCode isEqualToString:@"2233"]) return @"MD5校验失败";
    
    return [NSString stringWithFormat:@"网络请求失败"];
}

-(AFHTTPRequestSerializer *)requestSerializer
{
    return [FMRequestSerializer serializer];
}

-(AFHTTPResponseSerializer *)responseSerializer
{
    return [FMResponseSerializer serializer];
}

//获取第二级节点下的数据
-(id)responseDataBeforeConverted:(id)responseObj
{
    if (self.convertNodePath.length > 0) {
        responseObj = [responseObj valueForKeyPath:self.convertNodePath];
    } else {
        NSString *secondLevelNodeName = [FMResponseDataConverter getSecondLevlResponseNodeName:self.action];
        if ([responseObj isKindOfClass:[NSDictionary class]] && secondLevelNodeName) {
            responseObj = [responseObj objectForKey:secondLevelNodeName];
        }
    }
    return responseObj;
}

-(void)startWithAction:(NSString *)action
{
    [self startWithAction:action andSuccess:nil];
}

-(void)startWithAction:(NSString *)action andSuccess:(FMRequestBlock)success
{
    [self startWithAction:action andSuccess:success inRequest:nil];
}

-(void)startWithAction:(NSString *)action andSuccess:(FMRequestBlock)success inRequest:(FMRequestBlock)inRequest
{
    [self startWithAction:action andSuccess:success inRequest:inRequest andFailure:nil];
}

-(void)startWithAction:(NSString *)action andSuccess:(FMRequestBlock)success andFailure:(FMRequestBlock)failure
{
    [self startWithAction:action andSuccess:success inRequest:nil andFailure:failure];
}

-(void)startWithAction:(NSString *)action andSuccess:(FMRequestBlock)success inRequest:(FMRequestBlock)inRequest andFailure:(FMRequestBlock)failure
{
    self.action = action;
    [super startWithSuccess:success inRequest:inRequest andFailure:failure];
}

- (void)dealloc
{
    
}
@end
