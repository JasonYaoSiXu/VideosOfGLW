//
//  HeadScroll.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "HeadScroll.h"

@interface HeadScroll ()

@property(nonatomic,strong)UIImageView* midImageView;
@property(nonatomic,strong)UIImageView* leftImageView;
@property(nonatomic,strong)UIImageView* rightImageView;

@property(nonatomic,assign)CGFloat protion;
@property(nonatomic,assign)CGFloat lastMoveX;
@property(nonatomic,assign)NSInteger currentIndex;

@end

@implementation HeadScroll {
    NSMutableArray *sourceArray;
}

-(instancetype)initWithFrame:(CGRect)frame picturesArray:(NSMutableArray *)array  atIndex:(NSInteger)index {
    
    if (self == [super initWithFrame:frame]) {
        sourceArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < array.count; i++) {
            [sourceArray addObject:array[i]];
        }
        _currentIndex = index;
        _protion = 0.6f;
        [self initSeting];
        [self addSubviews];
    }
    
    return self;
}

//设置该scrollView
-(void)initSeting {
    self.contentSize = CGSizeMake(self.bounds.size.width * 3, 0);
    self.contentOffset = CGPointMake(self.bounds.size.width, 0);
    self.pagingEnabled = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;
    self.layer.masksToBounds = YES;
    self.delegate = self;
}

//为该scrollView添加子视图
-(void)addSubviews {
    self.midImageView.image = [UIImage imageNamed:self->sourceArray[self.currentIndex]];
    self.midImageView.tag = self.currentIndex;
    self.midImageView.frame = _midContainter.bounds;
    
    NSInteger leftIndex = _currentIndex - 1;
    if (leftIndex < 0 ) {
        leftIndex = self->sourceArray.count - 1;
    }
    self.leftImageView.image = [UIImage imageNamed:self->sourceArray[leftIndex]];
    self.leftImageView.tag = leftIndex;
    self.leftImageView.frame = CGRectMake(self.bounds.size.width * (1 - _protion), 0, self.bounds.size.width, self.bounds.size.height);
    
    NSInteger rightIndex = _currentIndex + 1;
    if (rightIndex >= self->sourceArray.count) {
        rightIndex = 0;
    }
    
    self.rightImageView.image = [UIImage imageNamed:self->sourceArray[rightIndex]];
    self.rightImageView.tag = rightIndex;
    self.rightImageView.frame = CGRectMake(self.bounds.size.width * (1 + _protion), 0, self.bounds.size.width, self.bounds.size.height);
    
    [self bringSubviewToFront:_midContainter];
    [self sendSubviewToBack:_leftImageView];
    [self sendSubviewToBack:_rightImageView];
    [self setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];

}


//初始化并添加midContainter
-(UIView *)midContainter {
    
    if (!_midContainter) {
        _midContainter = [UIView new];
        _midContainter.frame = CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
        _midContainter.clipsToBounds = YES;
        [self addSubview:self.midContainter];
    }
    
    return _midContainter;
}

//初始化当前要显示的imageView
-(UIImageView *)midImageView {
    
    if (!_midImageView) {
        _midImageView = [UIImageView new];
        _midImageView.frame = _midContainter.bounds;
        _midImageView.clipsToBounds = YES;
        [self.midContainter addSubview:self.midImageView];
    }
    
    return _midImageView;
}

//初始化当前显示的imageView左侧的imageView
-(UIImageView*)leftImageView {
    
    if (!_leftImageView) {
        _leftImageView = [UIImageView new];
        _leftImageView.frame = CGRectMake(self.bounds.size.width * (1 - _protion), 0, self.bounds.size.width, self.bounds.size.height);
        [self insertSubview:self.leftImageView belowSubview:self.midContainter];
    }
    
    return _leftImageView;
}

//初始化当前显示的imageView右侧的imageView
-(UIImageView*)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [UIImageView new];
        _rightImageView.frame = CGRectMake(self.bounds.size.width * (1 + _protion), 0, self.bounds.size.width, self.bounds.size.height);
        [self insertSubview:self.rightImageView belowSubview:self.midContainter];
    }
    
    return _rightImageView;
}

#pragma UIScrollViewDelegate
//开始滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    /*
        根据moveX可以推断出当前显示的是那个imageView，因为当前scrollView的contentSize的宽度为该scrollView的宽度的3倍，
        每次滑动完成后，scrollView的便宜量为0, self.bounds.size.width, 2*self.bounds.size.width
     */
    CGFloat moveX = scrollView.contentOffset.x - self.bounds.size.width;
    if (fabs(_lastMoveX) >= self.bounds.size.width) {
        [self addSubviews];
        self.lastMoveX = 0;
        return;
    }
    
    [self adjustSubViews:moveX];
    if (fabs(moveX) >= self.bounds.size.width) {
        [self completedHandler];
    }
    
    self.lastMoveX = moveX;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (self.pagingEnabled)return;
    CGFloat moveX = scrollView.contentOffset.x - self.bounds.size.width;
    CGFloat targetX = [self targetOffsetForMoveX:moveX velocity:velocity.x];
    if (targetX == self.bounds.size.width) {//cancel
        targetContentOffset->x = scrollView.contentOffset.x;
        [self setContentOffset:CGPointMake(targetX, targetContentOffset->y) animated:YES];
    } else {//complete
        targetContentOffset->x = targetX;
    }
}

-(void)adjustSubViews:(CGFloat)moveX {
    [self move:_midImageView from:0 ByX: moveX * (1 - _protion)];
    [self move:_leftImageView from:self.bounds.size.width * (1 - _protion) ByX: moveX * (1 - _protion)];
    [self move:_rightImageView from:self.bounds.size.width * (1 + _protion) ByX: moveX * (1 - _protion)];
}

//移动imageView
-(void)move:(UIView *)view from:(CGFloat)start ByX:(CGFloat)x {
    CGRect frame = view.frame;
    frame.origin.x = start + x;
    view.frame = frame;
}

//
-(void)completedHandler {
    CGFloat moveX = self.contentOffset.x - self.bounds.size.width;
    if (fabs(moveX) >= self.bounds.size.width) {
        if (moveX > 0 && self.currentIndex + 1 < self->sourceArray.count) {
            self.currentIndex++;
        }else if (moveX >0 && self.currentIndex +1 == self->sourceArray.count) {
            self.currentIndex = 0;
        }
        else if (self.currentIndex >= 1) {
            self.currentIndex--;
        }else if (self.currentIndex == 0 && moveX < 0) {
            self.currentIndex = self->sourceArray.count - 1;
        }
        [_indexDelegate headScrollDelegateIndex:_currentIndex];
        [self addSubviews];
    }
}

- (CGFloat)targetOffsetForMoveX:(CGFloat)moveX velocity:(CGFloat)velocity{
    BOOL complete = fabs(moveX) >= self.bounds.size.width * 0.3 ||
    (fabs(velocity) > 0 && fabs(moveX) >= self.bounds.size.width * 0.1 )? YES : NO;
    BOOL leftDirection = moveX > 0 ? YES : NO;
    if (complete) {
        if (leftDirection) {
            return self.bounds.size.width * 2;
        }
        return 0; //right Direction
    }else {
        return self.bounds.size.width;//cancel
    }
}

@end
