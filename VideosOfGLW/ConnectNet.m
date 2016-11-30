//
//  ConnectNet.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/13.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "ConnectNet.h"

@implementation ConnectNet {
    NSURL *_url;
    HttpMethod _httpMethod;
    NSMutableDictionary* _httpBody;
}

-(instancetype)initWithURLHttpMethodHttpBody:(NSString *)url HttpMethod:(HttpMethod)httpMethod HttpBody:(NSMutableDictionary *)httpBody {
//    _url = [self configHttpUrl:url];
    NSURL *urls = [[NSURL alloc] initWithString:@"http://t.yinyueapp.com/app/V2_0/musicianController/searchMusician"];
    _url = urls;
    _httpMethod = httpMethod;
    _httpBody = httpBody;
    //zh-Hans-CN;q=1, en-CN;q=0.9, zh-HK;q=0.8
    if (self =  [super initWithURL:_url]) {
//        self.HTTPBody = [self configHttpBody];
//        self.HTTPMethod = @"POST";
//        [self setValue:@"zh-Hans-CN;q=1, en-CN;q=0.9, zh-HK;q=0.8" forHTTPHeaderField:@"Accept-Language"];
        return self;
    }
    return self;
}

-(NSURL *)configHttpUrl: (NSString *)url {
    NSURL* completeUrl = [[NSURL alloc] initWithString:@"http://openapi.gewara.com/router/rest?"];
    return completeUrl;
}



-(NSData *)configHttpBody {
    NSMutableString *bodyString = [[NSMutableString alloc] init];
    NSArray *keyArray = [_httpBody.allKeys sortedArrayUsingSelector:@selector(compare:)];
    NSInteger httpBodyCount = _httpBody.count;
    
    for (NSInteger i = 0; i < httpBodyCount; i++) {
        [bodyString appendString: keyArray[i]];
        [bodyString appendString:@"="];
        [bodyString appendString:_httpBody[keyArray[i]]];
        
        if (i < httpBodyCount - 1) {
            [bodyString appendString:@"&"];
        }
    }
    
    NSString *body = [bodyString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString: @"abcdefghijklmnopqrstuvwxyz0123456789=&QWERTYUIOPLKJHGFDSAZXCVBNM-.%"]];
    return [body dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSArray *)sortKeyArray:(NSArray *)array {
    NSMutableArray *muArray = (NSMutableArray *)array;
    for (NSInteger i = 0; i < muArray.count; i++) {
        for (NSInteger j = i + 1; j < muArray.count - i - 1; j++) {
            NSString *temp = [[NSString alloc] init];
            if (muArray[i] > muArray[j]) {
                temp = muArray[i];
                muArray[i] = muArray[j];
                muArray[j] = temp;
            }
        }
    }
    return array;
}


// NSURLSession
-(void)requestData {
    NSURLSession *session = [NSURLSession sharedSession];
//    __block NSURLSessionDataTask *dataTask;
    __block typeof(ConnectNet *)Self = self;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
      NSURLSessionDataTask *  dataTask = [session dataTaskWithRequest:self completionHandler:^(NSData* data, NSURLResponse *response, NSError *error){
            if (error) {
                NSLog(@"error = %@",error);
            } else {
                NSLog(@"success = %@",response);
                NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
                if (httpResponse.statusCode == 200) {
                    [Self.delegate responseData:[Self parseJSON:data]];
                } else {
                    NSLog(@"%lu",httpResponse.statusCode);
                }
            }
        }];
//    });
    [dataTask resume];
}

-(NSDictionary *)parseJSON:(NSData*)data {
    return (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options: 0 error:NULL];
}

@end
