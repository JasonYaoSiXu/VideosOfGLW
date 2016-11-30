//
//  MaskLayerAnimation.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/1.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "MaskLayerAnimation.h"

@implementation MaskLayerAnimation {
    UIView *destView;
    CFTimeInterval durtionTime;
    CGPoint locationPoint;
    BOOL isShow;
}

-(instancetype)initShapeLayer:(UIView *)targetView durtionTime:(CFTimeInterval)time locationPoint:(CGPoint)point isShow:(BOOL)show {
    destView = targetView;
    durtionTime = time;
    locationPoint = point;
    isShow = show;
    if (self == [super init] ) {
        return self;
    }
    return self;
}

-(void)startAnimation {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat radio = sqrt(width * width + height * height);
    
    CGRect minOriginFrame = CGRectMake(locationPoint.x, locationPoint.y, 1, 1);
//    CGRect maxOriginFrame = CGRectMake(locationPoint.x, locationPoint.y, radio, radio);

    CGPathRef minOriginPath = [UIBezierPath bezierPathWithOvalInRect:minOriginFrame].CGPath;
    CGPathRef minDestPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(minOriginFrame, -radio, -radio)].CGPath;
    
//    CGPathRef maxOriginPath = [UIBezierPath bezierPathWithOvalInRect:maxOriginFrame].CGPath;
//    CGPathRef maxDestPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(maxOriginFrame, radio, radio)].CGPath;
    
    if (isShow == NO) {
        self.path = minDestPath;
    } else {
        self.path = minOriginPath;
    }
    
    destView.layer.mask = self;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    if (isShow == NO) {
        animation.fromValue = (__bridge id _Nullable)(minOriginPath);
        animation.toValue = (__bridge id _Nullable)(minDestPath);
    } else {
        animation.fromValue = (__bridge id _Nullable)(minDestPath);
        animation.toValue = (__bridge id _Nullable)(minOriginPath);
    }
    animation.duration = durtionTime;
    animation.delegate = self;
    
    [self addAnimation:animation forKey:@"path"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _finishAnimation();
}

@end
