//
//  HeadScrollView.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/2.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "HeadScrollView.h"

@implementation HeadScrollView {
    UIScrollView *_scrollView;
    NSMutableArray *itemArray;
    NSArray<__kindof UIView *> *scrollViewSubViews;
    CAShapeLayer *maskLayer;
    UIImageView *hiddenedImageView;
    UIImageView *scrollToRightFontImageView;
    CGRect fromCGRect;
    CGFloat beforeContentOffSet;
//    CGFloat currentContentOffSet;
    BOOL isLayerZoom;
    BOOL isCircle;
    BOOL isScrollToRight;
    int scrollIndex;
}

- (instancetype)initWithFrameItemArray:(CGRect)frame itemArray:(NSMutableArray*)array
{
    itemArray = array;
//    NSString *first = array.firstObject; // 1
//    NSString *last = array.lastObject; // 4
//    [itemArray insertObject:first atIndex:itemArray.count];
//    [itemArray insertObject:last atIndex:0];
    self = [super initWithFrame:frame];
    isLayerZoom = YES;
    isCircle = NO;
    isScrollToRight = NO;
//    currentContentOffSet = 0;
    [self addScrollView];
    return self;
}

-(void)addScrollView{
    CGFloat width = self.bounds.size.width / 3; //- (itemArray.count - 1) * width
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width * 2 / 3, self.bounds.size.height)];
   _scrollView.contentSize = CGSizeMake(itemArray.count * self.bounds.size.width - (itemArray.count - 1) * width, self.bounds.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _scrollView.backgroundColor = [UIColor cyanColor];
    [self addSubview:_scrollView];
    [self addImageView];
}

-(void)addImageView{
    
    for (NSInteger i = 0; i < itemArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scrollView.bounds.size.width, 0,
                                                                               self.bounds.size.width, self.bounds.size.height)];
        
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:itemArray[i]];
        [_scrollView addSubview:imageView];
        [_scrollView sendSubviewToBack:imageView];
    }
    scrollViewSubViews = _scrollView.subviews;
//    isCircle = YES;
//    beforeContentOffSet = _scrollView.bounds.size.width;
//    _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitTestView = [super hitTest:point withEvent:event];
    if (hitTestView) {
        hitTestView = _scrollView;
    }
    return hitTestView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (isCircle) {
//        isCircle = NO;
//        return;
//    }
    
//    if (currentContentOffSet <= scrollView.contentOffset.x) {
    if (beforeContentOffSet < scrollView.contentOffset.x) {
        [self scroToLeft:scrollView];
    } else if (beforeContentOffSet > scrollView.contentOffset.x) {
        [self scroToRight:scrollView];
    }
//    beforeContentOffSet = scrollView.contentOffset.x;
}

//向左👈滑动
-(void)scroToLeft:(UIScrollView *)scrollView {
    if (isLayerZoom) {
        isScrollToRight = NO;
//        currentContentOffSet = scrollView.contentOffset.x;
        int _index = (int)(scrollView.contentOffset.x / _scrollView.bounds.size.width);
        hiddenedImageView = scrollViewSubViews[itemArray.count -1- _index];
        fromCGRect = self.bounds;
        maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.path = [UIBezierPath bezierPathWithRect: fromCGRect].CGPath;
        hiddenedImageView.layer.mask = maskLayer;
        scrollIndex = _index;
        isLayerZoom = NO;
    }
    
    // 375 250
    CGFloat zooms = (scrollView.contentOffset.x - scrollIndex * _scrollView.bounds.size.width) / _scrollView.bounds.size.width * self.bounds.size.width / 3;
    maskLayer.path = [UIBezierPath bezierPathWithRect:CGRectInset(self.bounds, zooms, 0)].CGPath;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)[UIBezierPath bezierPathWithRect:fromCGRect].CGPath;
    animation.toValue = (__bridge id _Nullable)[UIBezierPath bezierPathWithRect:CGRectInset(self.bounds, zooms,0)].CGPath;
    animation.duration = 0;
    animation.delegate = self;
    fromCGRect = CGRectInset(self.bounds, zooms,0);
    [maskLayer addAnimation:animation forKey:@"path"];
}

//向右👉滑动
-(void)scroToRight:(UIScrollView *)scrollView {
    if (isLayerZoom) {
        isScrollToRight = YES;
//        currentContentOffSet = scrollView.contentOffset.x;
        int _index = (int)scrollView.contentOffset.x / (int)_scrollView.bounds.size.width;
        hiddenedImageView = scrollViewSubViews[itemArray.count - 2 - _index];
        maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.path = [UIBezierPath bezierPathWithRect: fromCGRect].CGPath;
        hiddenedImageView.layer.mask = maskLayer;
        scrollToRightFontImageView = scrollViewSubViews[itemArray.count - 1 - _index];
        scrollToRightFontImageView.hidden = YES;
        [_scrollView bringSubviewToFront: scrollToRightFontImageView];
        [_scrollView bringSubviewToFront: hiddenedImageView];
        scrollToRightFontImageView.hidden = NO;
        
        fromCGRect = CGRectMake(self.bounds.size.width / 3, 0, self.bounds.size.width / 3, self.bounds.size.height);
        scrollIndex = _index;
        isLayerZoom = NO;
    }
    
    // 375 250
    CGFloat zooms = (_scrollView.bounds.size.width / 2) - (scrollView.contentOffset.x - scrollIndex * _scrollView.bounds.size.width) / _scrollView.bounds.size.width * self.bounds.size.width / 3;
    maskLayer.path = [UIBezierPath bezierPathWithRect:CGRectInset(self.bounds, zooms, 0)].CGPath;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)[UIBezierPath bezierPathWithRect:fromCGRect].CGPath;
    animation.toValue = (__bridge id _Nullable)[UIBezierPath bezierPathWithRect:CGRectInset(self.bounds, zooms,0)].CGPath;
    animation.duration = 0;
    animation.delegate = self;
    fromCGRect = CGRectInset(self.bounds, zooms,0);
    [maskLayer addAnimation:animation forKey:@"path"];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%s.%d,scroll end,scrollIndex",__FUNCTION__,scrollIndex);
    isLayerZoom = YES;
    [maskLayer removeAllAnimations];
    maskLayer = nil;
    
    if (scrollIndex == itemArray.count - 2) {
        isCircle = YES;
    }
    
    if (beforeContentOffSet < scrollView.contentOffset.x || beforeContentOffSet - scrollView.contentOffset.x == _scrollView.bounds.size.width) {
        maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.path = [UIBezierPath bezierPathWithRect: self.bounds].CGPath;
        hiddenedImageView.layer.mask = maskLayer;
        if (isScrollToRight == NO) {
            [_scrollView sendSubviewToBack:hiddenedImageView];
        } else {
            [_scrollView bringSubviewToFront:hiddenedImageView];
            [_scrollView bringSubviewToFront:scrollToRightFontImageView];
        }
    } else {
        maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.path = [UIBezierPath bezierPathWithRect: self.bounds].CGPath;
        hiddenedImageView.layer.mask = maskLayer;
    }
    
    isScrollToRight = NO;
    beforeContentOffSet = scrollView.contentOffset.x;
//    currentContentOffSet = beforeContentOffSet;
}

@end