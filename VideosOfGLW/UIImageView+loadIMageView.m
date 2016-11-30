//
//  UIImageView+loadIMageView.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/13.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "UIImageView+loadIMageView.h"

typedef void(^callBack)(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info);

@implementation UIImageView(loadImageView)

-(void)loadImageWithURLString:(NSString *)url {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *imageUrl = [[NSURL alloc] initWithString:url];
    __weak typeof(UIImageView *) Self = self;
    
    // MARK - need optimize
        NSURLSessionDownloadTask *dataTask = [session downloadTaskWithURL:imageUrl completionHandler: ^(NSURL *location, NSURLResponse *response, NSError *error) {
            if (error == NULL) {
                if ((location = imageUrl)) {
                    NSData *data = [[NSData alloc] initWithContentsOfURL:location];
                    UIImage *image = [[UIImage alloc] initWithData:data];
//                    Self.image = image;
                    [Self setImageViewWithImageInRunLoop:image];
                }
            }
        }];
        [dataTask resume];
}

-(void)setImageViewWithImageInRunLoop:(UIImage *)image {
    CFRunLoopObserverRef  observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopBeforeWaiting:
                [self setImageWithLoadImage:image];
                NSLog(@"即将进入睡眠");
                break;
            case kCFRunLoopExit:
                [self setImageWithLoadImage:image];
                break;
            default:
                NSLog(@"不执行");
                break;
        }
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
}

-(void)setImageWithLoadImage:(UIImage *)image {
    self.image = image;
}

@end
