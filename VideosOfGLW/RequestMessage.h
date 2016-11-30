//
//  RequestMessage.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/14.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>
//判断网络制式
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//添加获取客户端运营商支持
#import <CoreTelephony/CTCarrier.h>

@interface RequestMessage : NSObject

-(NSDictionary *)requestMessage:(NSString *)lat lngOfLocation:(NSString *)lng cityCodeOfLocation:(NSString *)cityCode cityNameOfLocation:(NSString *)cityName;

@end
