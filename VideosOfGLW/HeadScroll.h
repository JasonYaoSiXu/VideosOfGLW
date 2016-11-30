//
//  HeadScroll.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadScrollDelegate <NSObject>
-(void)headScrollDelegateIndex:(NSInteger)index;
@end

@interface HeadScroll : UIScrollView<UIScrollViewDelegate>

-(instancetype)initWithFrame:(CGRect)frame picturesArray:(NSMutableArray *)array  atIndex:(NSInteger)index;
@property (nonatomic, weak)   id <HeadScrollDelegate>  indexDelegate;
@property(nonatomic,strong)UIView* midContainter;

@end
