//
//  RequestMessage.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/14.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "RequestMessage.h"

/*
    adverType=index&appSource=AS02&appVersion=7.1.0&appkey=iphoneV64&apptype=cinema&citycode=610100&cityname=%E8%A5%BF%E5%AE%89&deviceid=14a6dcb0c0f1d6056a03a869960d1a20ed842272&format=json&idfa=E50971FB-A083-45EC-BD1C-77154CB53DE0&method=com.gewara.mobile.phoneAdver.advertListV7&mnet=wifi&mobileType=iPhone&osType=IPHONE&osVersion=9.3.5&pointx=108.897506&pointy=34.227380&securityCode=Bmjt7XJvtBsHe24&sign=D521D085869B9E744E377CF3D9162A81&signmethod=MD5&timestamp=2016-09-14%2015%3A17%3A43&v=1.0
 */

@implementation RequestMessage

-(NSDictionary *)requestMessage:(NSString *)lat lngOfLocation:(NSString *)lng cityCodeOfLocation:(NSString *)cityCode cityNameOfLocation:(NSString *)cityName {
    
    NSMutableDictionary *message = [[NSMutableDictionary alloc] init];
    
    message[@"adverType"] = @"index";
    message[@"appSource"] = @"AS02";
    message[@"appVersion"] = @"7.1.0";
    message[@"apptype"] = @"cinema";
    message[@"format"] = @"json";
    message[@"securityCode"] = @"Bmjt7XJvtBsHe24";
    message[@"signmethod"] = @"MD5";
    message[@"v"] = @"1.0";
    message[@"sign"] = @"D521D085869B9E744E377CF3D9162A81";
    message[@"appkey"] = @"iphoneV64";
    message[@"method"] = @"com.gewara.mobile.phoneAdver.advertListV7";
    
//    message[@"citycode"] = cityCode;
//    message[@"cityname"] = cityName;
//    message[@"pointx"] = lng;
//    message[@"pointy"] = lat;
    message[@"citycode"] = @"610100";
    message[@"cityname"] = @"西安";
    message[@"pointx"] = @"108.897506";
    message[@"pointy"] = @"34.227380";
    message[@"mnet"] = [self judgeNetWorkType];
    message[@"timestamp"] = [self currentTimeString];
//    message[@"timestamp"] = @"2016-09-14 15:17:43";
    
    //获取设备唯一标识符 B32CEB03-E05A-42C7-A597-9786D8F6751E
//    message[@"idfa"] = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    message[@"idfa"] = @"E50971FB-A083-45EC-BD1C-77154CB53DE0";
    //推送
    message[@"deviceid"] = @"14a6dcb0c0f1d6056a03a869960d1a20ed842272";
    //获取设备类型
    message[@"mobileType"] = [[UIDevice currentDevice] model];
    //获取系统名称 IPHONE
//    message[@"osType"] = [[UIDevice currentDevice] systemName];
    message[@"osType"] = @"IPHONE";
    //获取系统版本号
    message[@"osVersion"] = [[UIDevice currentDevice] systemVersion];
    
    return (NSDictionary *)message;
}

-(NSString *)currentTimeString {
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [format stringFromDate:date];
}

-(NSString *)judgeNetWorkType {
    
    CTTelephonyNetworkInfo *netWorkInto = [[CTTelephonyNetworkInfo alloc] init];
    
    if (netWorkInto.currentRadioAccessTechnology == NULL) {
        return @"没有接入网络";
    } else {
        if (netWorkInto.currentRadioAccessTechnology == CTRadioAccessTechnologyGPRS) {
            return @"GPRS";
        } else if (netWorkInto.currentRadioAccessTechnology == CTRadioAccessTechnologyEdge) {
            return @"Edge";
        } else if (netWorkInto.currentRadioAccessTechnology == CTRadioAccessTechnologyWCDMA) {
            return @"WCDMA";
        } else if (netWorkInto.currentRadioAccessTechnology == CTRadioAccessTechnologyHSDPA) {
            return @"HSDPA";
        } else if (netWorkInto.currentRadioAccessTechnology == CTRadioAccessTechnologyHSUPA) {
            return @"HSUPA";
        } else if (netWorkInto.currentRadioAccessTechnology == CTRadioAccessTechnologyCDMA1x ) {
            return @"CDMA1x";
        } else if (netWorkInto.currentRadioAccessTechnology == CTRadioAccessTechnologyCDMAEVDORev0) {
            return @"CDMAEVDORev0";
        } else if (netWorkInto.currentRadioAccessTechnology == CTRadioAccessTechnologyCDMAEVDORevA) {
            return @"CDMAEVDORevA";
        } else if (netWorkInto.currentRadioAccessTechnology == CTRadioAccessTechnologyCDMAEVDORevB) {
            return @"CDMAEVDORevB";
        } else if (netWorkInto.currentRadioAccessTechnology == CTRadioAccessTechnologyeHRPD) {
            return @"HRPD";
        } else if (netWorkInto.currentRadioAccessTechnology == CTRadioAccessTechnologyLTE) {
            return @"wifi";
        }
    }
    return @"";
}

@end