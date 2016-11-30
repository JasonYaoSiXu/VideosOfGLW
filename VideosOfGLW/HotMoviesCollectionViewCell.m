//
//  HotMoviesCollectionViewCell.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "HotMoviesCollectionViewCell.h"

@implementation HotMoviesCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _avtarOfMovies.clipsToBounds = YES;
    _avtarOfMovies.clipsToBounds = UIViewContentModeScaleAspectFit;
//    [self initWithSubviews];
}

-(void)initWithSubviews {
    _avtarOfMovies.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAvartAction)];
    [_avtarOfMovies addGestureRecognizer:tapAction];
}

-(void)tapAvartAction{
    if (_myBlock != NULL) {
        _myBlock();
    }
}

@end
