//
//  ConnectNet.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/13.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <Foundation/Foundation.h>

//NSString *baseURL = @"http://openapi.gewara.com";

typedef NS_ENUM(NSInteger, HttpMethod) {
    GET = 0,
    POST = 1,
    PUT = 2
};

@protocol  ConnectNetDelegate <NSObject>

-(void)responseData:(NSDictionary *)data;

@end

@interface ConnectNet : NSMutableURLRequest

@property (nonatomic,weak) id<ConnectNetDelegate> delegate;

-(instancetype)initWithURLHttpMethodHttpBody:(NSString *)url HttpMethod:(HttpMethod)httpMethod HttpBody:(NSMutableDictionary *)httpBody;
-(void)requestData;

@end
