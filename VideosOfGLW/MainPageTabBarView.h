//
//  MainPageTabBarView.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/8/31.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapButtonBlock)(void);

@interface MainPageTabBarView : UIView

-(instancetype)initWithFrameAndButtonCount:(CGRect)frame buttonActions:(NSMutableArray*)action;
-(void)addItem;
/////最后一个按钮是不是和其它的按钮不在一边,默认为NO
//-(void)ifLastButtonAtOtherBorder:(BOOL)isAtOtherBorder;
//
//-(void)addButtons;

@end
