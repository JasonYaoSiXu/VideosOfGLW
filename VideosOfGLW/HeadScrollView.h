//
//  HeadScrollView.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/2.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadScrollView : UIView<UIScrollViewDelegate>

- (instancetype)initWithFrameItemArray:(CGRect)frame itemArray:(NSMutableArray*)array;

@end
