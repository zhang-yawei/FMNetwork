//
//  FMUtil.m
//  O2BookStore
//
//  Created by 卢双 on 13-9-12.
//  Copyright (c) 2013年 卢双. All rights reserved.
//

#import "FMUtil.h"

/* 分享平台 .h*/

#import "Reachability.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>


#define isIOS7              ([FMUtil isCurrentSystemBigOrSameThan:@"7.0"])

static const char* jailbreak_apps[] =
{
    "/Applications/Cydia.app",
    "/Applications/blackra1n.app",
    "/Applications/blacksn0w.app",
    "/Applications/greenpois0n.app",
    "/Applications/limera1n.app",
    "/Applications/redsn0w.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt",
    NULL,
};

@implementation FMUtil

+ (id)jasonObjectFromContent:(NSString *)jasonString
{
    NSRange startRange = [jasonString rangeOfString:@"<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />"];
    if (startRange.location != NSNotFound) {
        jasonString = [jasonString substringFromIndex:NSMaxRange(startRange)];
        
        startRange = [jasonString rangeOfString:@"["];
        if (startRange.location != NSNotFound) {
            jasonString = [jasonString substringFromIndex:startRange.location];
        }
    }
    
    return [NSJSONSerialization JSONObjectWithData:[jasonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
}

+ (id)jasonObjectFromUrlString:(NSString *)urlStr
{
    NSString *jasonString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlStr] encoding:NSUTF8StringEncoding error:nil];
    if (!jasonString) {
        return nil;
    }
    
    return [self jasonObjectFromContent:jasonString];
}

+ (void)viewAppearWithAnimation:(UIView *)view
{
    CGRect rect = view.frame;
    rect.origin.x += CGRectGetWidth(rect);
    [view setFrame:rect];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    rect.origin.x -= CGRectGetWidth(rect);
    [view setFrame:rect];
    
    [UIView commitAnimations];
}

+ (void)viewDisappearWithAnimation:(UIView *)view animationDelegate:(id)delegate selector:(SEL)selector
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:delegate];
    [UIView setAnimationDidStopSelector:selector];
    
    CGRect rect = view.frame;
    rect.origin.x += CGRectGetWidth(rect);
    [view setFrame:rect];
    
    [UIView commitAnimations];
}

+ (NSInteger)getHeadIndex
{
    srandom((int)time(NULL));
    return random()%11;
}



+(NSArray *)getAllCityAndProvince
{
    NSString *dataFile=[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities" ofType:@"plist"];
    //读取所有内容
    return [NSArray arrayWithContentsOfFile:dataFile];
}

+ (UIColor *)readBgColorAtIndex:(NSInteger)bgIndex
{
    NSArray *bgColorAry = [NSArray arrayWithObjects:
                           [UIColor colorWithRed:42/255.f green:42/255.f blue:42/255.f alpha:1],
                           [UIColor colorWithRed:239/255.f green:239/255.f blue:239/255.f alpha:1],
                           [UIColor colorWithRed:9/255.f green:41/255.f blue:62/255.f alpha:1],
                           [UIColor colorWithRed:210/255.f green:224/255.f blue:211/255.f alpha:1],
                           [UIColor colorWithRed:226/255.f green:200/255.f blue:161/255.f alpha:1],
                           [UIColor colorWithRed:240/255.f green:221/255.f blue:221/255.f alpha:1],
                           [UIColor colorWithRed:42/255.f green:75/255.f blue:72/255.f alpha:1],
                           [UIColor colorWithRed:239/255.f green:239/255.f blue:239/255.f alpha:1],
                           [UIColor colorWithRed:239/255.f green:239/255.f blue:239/255.f alpha:1],
                           [UIColor colorWithRed:239/255.f green:239/255.f blue:239/255.f alpha:1], nil];
    
    return [bgColorAry objectAtIndex:bgIndex];
}

+ (UIColor *)readFontColorAtIndex:(NSInteger)bgIndex
{
    NSArray *textColorAry = [NSArray arrayWithObjects:
                             [UIColor colorWithRed:207/255.f green:207/255.f blue:207/255.f alpha:1],
                             [UIColor colorWithRed:72/255.f green:72/255.f blue:72/255.f alpha:1],
                             [UIColor colorWithRed:205/255.f green:204/255.f blue:204/255.f alpha:1],
                             [UIColor colorWithRed:71/255.f green:69/255.f blue:69/255.f alpha:1],
                             [UIColor colorWithRed:71/255.f green:69/255.f blue:69/255.f alpha:1],
                             [UIColor colorWithRed:61/255.f green:59/255.f blue:59/255.f alpha:1],
                             [UIColor colorWithRed:218/255.f green:215/255.f blue:215/255.f alpha:1],
                             [UIColor colorWithRed:68/255.f green:68/255.f blue:68/255.f alpha:1],
                             [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1],
                             [UIColor colorWithRed:71/255.f green:69/255.f blue:69/255.f alpha:1], nil];
    
    return [textColorAry objectAtIndex:bgIndex];
}

+(BOOL)progressNetRefresh:(CGFloat)progress
{
    if (progress == 0.0
        || (progress >= 0.1 && progress<=0.15)
        || (progress >= 0.2 && progress<=0.25)
        || (progress >= 0.3 && progress<=0.35)
        || (progress >= 0.4 && progress<=0.45)
        || (progress >= 0.5 && progress<=0.55)
        || (progress >= 0.6 && progress<=0.65)
        || (progress >= 0.7 && progress<=0.75)
        || (progress >= 0.8 && progress<=0.85)
        || (progress >= 0.9 && progress<=0.95)
        || progress == 1) {
        return YES;
    }
    return NO;
}
// 是否wifi
+ (BOOL) IsEnableWIFI {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWiFi);
}

// 是否数据
+ (BOOL) IsEnableWWAN {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWWAN);
}

+ (BOOL) hasNetwork {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

+ (BOOL)networkExist
{
    return [self hasNetwork];
    
    /*
	Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    if (!r || [r currentReachabilityStatus] == NotReachable) {
        return NO;
    }
    
    return YES;
     */
}

+ (NSInteger)networkType
{
	Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    return [r currentReachabilityStatus];
}

+ (BOOL)isPureNumber:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[02-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|47|78|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|45|76|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1(33|53|7[0-7]|8[019])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(BOOL)isChinaTelecomMobileNumber:(NSString*)mobileNum{
    
    NSString * CT = @"^1(33|53|7[037]|8[019])\\d{8}$";
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if ([regextestct evaluateWithObject:mobileNum] == YES) {
        return YES;
    } else {
        return NO;
    }
}
+(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}
+ (NSString *)getWifiName
{
    NSString *wifiName = @"";
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return @"";
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            FMLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}

+(NSString *)getWifiMacAddress
{
    
    NSString *macAddress = @"";
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return @"";
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            FMLog(@"network info -> %@", networkInfo);
            macAddress = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeyBSSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    
    return macAddress;
    
}
+(BOOL)isCurrentSystemBigOrSameThan:(NSString *)sysVersion
{
    NSString *currentVersionCode = [[UIDevice currentDevice] systemVersion];
    NSComparisonResult result =[currentVersionCode compare:sysVersion options:NSNumericSearch];
    return ( result == NSOrderedDescending || result == NSOrderedSame);
}



+(NSString*)getAdid
{
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    
    return @"058AF2E2-0A59-4F65-812E-0399D5B1A460";
}
//获取设备ID
+(NSString*)getClientImei{
    
     NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
     return identifierForVendor;
}



//获取当前网络类型
+(NSString*)getCurrentNetWorkType{
    
    NSString *netWorkStatus = @"WiFi";
    @try {
        NetworkStatus networkStatus  = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
        
        if (networkStatus == ReachableViaWWAN) {
            if (isIOS7) {
                CTTelephonyNetworkInfo *info=[[CTTelephonyNetworkInfo alloc]init];
                NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;
                
                if (currentRadioAccessTechnology)
                {
                    if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE])
                    {
                        netWorkStatus =  @"4G";
                    }
                    else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS])
                    {
                        netWorkStatus =  @"2G";
                    }
                    else
                    {
                        netWorkStatus =  @"3G";
                    }
                } else {
                    netWorkStatus = @"UnkownWWAN";
                }
            } else {
                netWorkStatus = @"WWAN";
            }
            
        } else if(networkStatus == NotReachable) {
            netWorkStatus = @"";
        }
      
    } @catch (NSException *exception) {
        FMLog(@"exception error:%@",exception);
        netWorkStatus = @"";
    } @finally {
        
    }

    return netWorkStatus;
}


+(NSInteger)getCurrentNetWorkTypeForInt
{
    NSInteger type = 0;
    NSString *net = [self getCurrentNetWorkType];
    if ([net isEqualToString:@"WiFi"]) {
        type = 6;
    } else if ([net isEqualToString:@"4G"]) {
        type = 4;
    } else if ([net isEqualToString:@"3G"]) {
        type = 3;
    } else if ([net isEqualToString:@"2G"]) {
        type = 2;
    } else if ([net isEqualToString:@"UnkownWWAN"]) {
        type = 1;
    } else {
        type = 0;
    }
    return type;
}
//判断当前设备是否越狱
+(BOOL)isJailBrokeDevice
{
    // Check whether the jailbreak apps are installed
    for (int i = 0; jailbreak_apps[i] != NULL; ++i)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_apps[i]]])
        {

            return YES;
        }
    }
    
    return NO;
}

//获取网络运营商
+(NSString*)getNetWorkOperators{

    NSString *netWorkOperator=@"";
    
    CTTelephonyNetworkInfo *info=[[CTTelephonyNetworkInfo alloc]init];
    CTCarrier *carrier=[info subscriberCellularProvider];
    if (carrier==nil) {
        return netWorkOperator;
    }
    NSString *code=[carrier mobileNetworkCode];
    if (code==nil) {
        return netWorkOperator;
    }
    if ([code isEqualToString:@"00"]||[code isEqualToString:@"02"]||[code isEqualToString:@"07"]) {
        return netWorkOperator=@"China Mobile";
    }
    else if ([code isEqualToString:@"01"]||[code isEqualToString:@"06"]){
    
    return netWorkOperator=@"China Unicom";
    }
    else if ([code isEqualToString:@"03"]||[code isEqualToString:@"05"]){
        return netWorkOperator=@"China Telecom";
    }

    return netWorkOperator;
}

+(NSInteger)getNetWorkOperatorsForInt{
    NSInteger type = 0;

    NSString *operator = [self getNetWorkOperators];
    if ([operator isEqualToString:@"China Mobile"]) {
        type = 1;
    } else if ([operator isEqualToString:@"China Unicom"]) {
        type = 2;
    } else if ([operator isEqualToString:@"China Telecom"]) {
        type = 3;
    }
    return type;
}
/**
 *  @brief  对url进行转码
 *
 *  @param originalString 原始url
 *  @param stringEncoding 编码规则
 *
 *  @return 转码后的url
 */
+ (NSString*)URLEncode:(NSString *)originalString
        stringEncoding:(NSStringEncoding)stringEncoding {
    //!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
    //%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,    @"$" , @"," ,
                            @"!", @"'", @"(", @")", @"*", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F", @"%3F" , @"%3A" ,
                             @"%40" , @"%26" , @"%3D" , @"%2B" , @"%24" , @"%2C" ,
                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
    
    NSInteger len = [escapeChars count];
    
    NSMutableString *temp = [[originalString
                              stringByAddingPercentEscapesUsingEncoding:stringEncoding]
                             mutableCopy];
    
    NSInteger i;
    for (i = 0; i < len; i++) {
        
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *outStr = [NSString stringWithString: temp];
    
    return outStr;
}
#pragma mark--currentDeviceModel--
+ (NSString *) getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
 
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}
+(NSString *) platformString{

    
   NSString *platform=[self getSysInfoByName:"hw.machine"];
    
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"]||[platform isEqualToString:@"x86_64"]) {
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 768;
        return smallerScreen ? @"iPhone Simulator" : @"iPad Simulator";
    }
    return @"UnknownDevice";

}
@end
