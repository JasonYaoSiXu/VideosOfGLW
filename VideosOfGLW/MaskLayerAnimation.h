//
//  MaskLayerAnimation.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/1.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaskLayerAnimation : CAShapeLayer

///初始化  destView 所要蒙板动画的view  durtionTime 动画持续时间  locationPoint 从那个点开始  isShow NO为从小到大显示destView  YES为从大到小隐藏destView destView
-(instancetype)initShapeLayer:(UIView *)destView durtionTime:(CFTimeInterval)time locationPoint:(CGPoint)point isShow:(BOOL)show;
///开始动画
-(void)startAnimation;
///动画结束后所要执行的动作
@property (nonatomic,copy) void(^finishAnimation)(void);

@end
