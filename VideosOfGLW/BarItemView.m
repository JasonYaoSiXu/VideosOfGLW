//
//  BarItemView.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/7.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "BarItemView.h"

@implementation BarItemView {
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addTapViewAction];
        return self;
    }
    return self;
}

-(void)addSubViews {
    self.backgroundColor = [UIColor whiteColor];
    _imageName = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.bounds.size.height - 30) / 2 , 30, 30) ];
    _itemName = [[UILabel alloc] initWithFrame:CGRectMake(30, (self.bounds.size.height - 20) / 2,50, 20)];
    _imageName.backgroundColor = self.backgroundColor;
    _itemName.backgroundColor = self.backgroundColor;
    [self addSubview:_imageName];
    
    _itemName.textColor = [UIColor redColor];
    [self addSubview:_itemName];
}

-(void)addTapViewAction {
    UITapGestureRecognizer *tapSelf = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewAction)];
    [self addGestureRecognizer:tapSelf];
}

-(void)tapViewAction{
    NSLog(@"%s",__FUNCTION__);
    _tapAction();
}

@end
