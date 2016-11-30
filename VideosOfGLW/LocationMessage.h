//
//  LocationMessage.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/14.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationMessageDelegate <NSObject>

-(void)latOfLocation:(NSString *)lat;
-(void)logOfLocation:(NSString *)log;
-(void)cityNameOfLocation:(NSString *)cityName;
-(void)cityCodeOfLocation:(NSString *)cityCode;

@end

@interface LocationMessage : NSObject<CLLocationManagerDelegate>

-(instancetype)init;
-(void)applyLoaciton;
@property (nonatomic,weak) id <LocationMessageDelegate> locationDelegate;
@property (nonatomic,strong)CLLocationManager *locationManager;

@end
