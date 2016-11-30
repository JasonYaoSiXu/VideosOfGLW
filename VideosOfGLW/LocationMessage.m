//
//  LocationMessage.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/14.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "LocationMessage.h"

@implementation LocationMessage

-(instancetype)init {
    self = [super init];
    _locationManager = [[CLLocationManager alloc] init];
    return self;
}

-(void)applyLoaciton{
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = 10.0;
    if (!([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {
        [_locationManager requestAlwaysAuthorization];
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSString *lat = [NSString stringWithFormat:@"%.6f",[locations lastObject].coordinate.latitude];
    NSString *log = [NSString stringWithFormat:@"%.6f",[locations lastObject].coordinate.longitude];
    [_locationDelegate latOfLocation:lat];  //y
    [_locationDelegate logOfLocation:log]; //x
    
    [self cityMessage:[locations lastObject]];
    [_locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@",error);
}

-(void)cityMessage:(CLLocation *)location {
    
    CLGeocoder *geCoder = [[CLGeocoder alloc] init];
    
    [geCoder reverseGeocodeLocation:location completionHandler: ^(NSArray *placemarks, NSError * error){
        CLPlacemark *clPlacemark = placemarks[0];
        NSLog(@"%@",placemarks);
        [_locationDelegate cityCodeOfLocation:@""];
        [_locationDelegate cityNameOfLocation:clPlacemark.locality];
    }];
    
}

@end
