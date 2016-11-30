//
//  TodayRecommendCollectionViewCell.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "TodayRecommendCollectionViewCell.h"

@implementation TodayRecommendCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSubviews];
    // Initialization code
}

-(void)initSubviews {
//    _avartImageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAvartImageViewAction)];
//    [_avartImageView addGestureRecognizer:tapAction];
    
    _titleLabel.text = @"小格带你去看七月与安生的首映";
    
    _classifyLabel.backgroundColor = [UIColor blueColor];
//    _classifyLabel.text = @"1234567890";
    
    CAShapeLayer *shapLayer = [[CAShapeLayer alloc] init];
    shapLayer.frame = _classifyLabel.bounds;
    shapLayer.path = [UIBezierPath bezierPathWithRoundedRect:_classifyLabel.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadii:CGSizeMake(_classifyLabel.bounds.size.height / 2, _classifyLabel.bounds.size.height / 2)].CGPath;
    _classifyLabel.layer.mask = shapLayer;
    
    _messageLabel.backgroundColor = [UIColor blueColor];
    _messageLabel.text = @"   评审员招募ING   ";
    _messageLabel.layer.cornerRadius = 4;
    _messageLabel.layer.masksToBounds = YES;
}

-(void)tapAvartImageViewAction {
    if (_myBlock) {
        _myBlock();
    }
}

@end
