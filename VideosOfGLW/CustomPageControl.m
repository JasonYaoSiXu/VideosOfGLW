//
//  CustomPageControl.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/1.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "CustomPageControl.h"

@implementation CustomPageControl {
    CGSize dotSize;
}

-(instancetype)initWithFrameDotSize:(CGRect)frame dotSize:(CGSize)size {
    
    dotSize = size;
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    return self;
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    for (NSInteger i = 0; i < [self.subviews count]; i++) {
        self.subviews[i].frame = CGRectMake(i * dotSize.width, 0, dotSize.width - 5, dotSize.height);
        self.subviews[i].layer.cornerRadius = 0;
    }
}

-(void)setCurrentPage:(NSInteger)currentPage {
//    self.currentPage = currentPage;
    [super setCurrentPage:currentPage];
    [self setNeedsDisplay];
}

@end
