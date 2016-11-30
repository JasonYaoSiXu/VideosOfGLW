//
//  BarItemView.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/7.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarItemView : UIView

@property(nonatomic,strong) UIImageView *imageName;
@property(nonatomic,strong) UILabel *itemName;
@property(nonatomic,strong) void(^tapAction)(void);
@property BOOL isSelect;
-(void)addTapViewAction;
-(void)addSubViews;

@end
