//
//  CircleView.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/1.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

-(instancetype)initWithFrameItemArray:(CGRect)frame itemArray:(NSMutableArray *)item;
-(void)initAddSubviews;

@end
