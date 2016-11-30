//
//  PopAnimationViewController.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/1.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "PopAnimationViewController.h"
#import "DiscoverViewController.h"
#import "DetailViewController.h"
#import "MaskLayerAnimation.h"

@implementation PopAnimationViewController {
    UIImageView *myImageView;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    if ( [fromVC isKindOfClass: [DetailViewController class]] && [toVC isKindOfClass: [DiscoverViewController class]] ) {
        [self fromDiscoverViewControllerToDetailViewController:transitionContext];
    }
}


-(void)fromDiscoverViewControllerToDetailViewController:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"%s",__FUNCTION__);
    DetailViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DiscoverViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    myImageView = fromVC.imageViews;
    [[transitionContext containerView] insertSubview:toVC.view aboveSubview:fromVC.view];
    toVC.view.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:myImageView];
    MaskLayerAnimation *maskLayer = [[MaskLayerAnimation alloc] initShapeLayer:fromVC.view durtionTime:1.5
                                                                 locationPoint:CGPointMake(myImageView.center.x, myImageView.center.y)
                                                                 isShow:YES];
    [maskLayer startAnimation];
    
    maskLayer.finishAnimation = ^(void){
        [UIView animateWithDuration:1.5 animations:^{
            myImageView.frame = toVC.destRect;
        }completion:^(BOOL finish){
            [myImageView removeFromSuperview];
            toVC.view.hidden = NO;
            toVC.tabBarController.tabBar.hidden = NO;
            [transitionContext completeTransition:YES];
        }];
    };
    
}

@end
