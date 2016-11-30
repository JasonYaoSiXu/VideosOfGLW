//
//  SlidePopAnimation.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/2.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "SlidePopAnimation.h"

@implementation SlidePopAnimation 

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 2;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UISwipeGestureRecognizer *tapFromView = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFromView:)];
    
    [fromView.view addGestureRecognizer:tapFromView];
}

-(void)swipeFromView:(UISwipeGestureRecognizer *)swipeGestrue {
    NSLog(@"%s",__FUNCTION__);
}


@end
