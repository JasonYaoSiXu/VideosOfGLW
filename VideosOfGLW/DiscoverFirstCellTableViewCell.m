//
//  DiscoverFirstCellTableViewCell.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "DiscoverFirstCellTableViewCell.h"

@implementation DiscoverFirstCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self initSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initSubviews {
    
    UITapGestureRecognizer *tapFirstAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewAction:)];
    _firstImageView.layer.cornerRadius = _firstImageView.bounds.size.height / 2;
    _firstImageView.layer.masksToBounds = YES;
    _firstImageView.clipsToBounds = YES;
    _firstImageView.contentMode = UIViewContentModeScaleAspectFill;
//    _firstImageView.image = [UIImage imageNamed:@"1"];
    _firstImageView.tag = 0;
    _firstImageView.userInteractionEnabled = YES;
    [_firstImageView addGestureRecognizer:tapFirstAction];
    
    UITapGestureRecognizer *tapSecondAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewAction:)];
    _secondImageView.layer.cornerRadius = _secondImageView.bounds.size.height / 2;
    _secondImageView.layer.masksToBounds = YES;
    _secondImageView.clipsToBounds = YES;
    _secondImageView.contentMode = UIViewContentModeScaleAspectFill;
//    _secondImageView.image = [UIImage imageNamed:@"2"];
    _secondImageView.tag = 1;
    _secondImageView.userInteractionEnabled = YES;
    [_secondImageView addGestureRecognizer:tapSecondAction];

    UITapGestureRecognizer *tapThirdAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewAction:)];
    _thirdImageView.layer.cornerRadius = _thirdImageView.bounds.size.height / 2;
    _thirdImageView.layer.masksToBounds = YES;
    _thirdImageView.clipsToBounds = YES;
    _thirdImageView.contentMode = UIViewContentModeScaleAspectFill;
//    _thirdImageView.image = [UIImage imageNamed:@"3"];
    _thirdImageView.tag = 2;
    _thirdImageView.userInteractionEnabled = YES;
    [_thirdImageView addGestureRecognizer:tapThirdAction];
    
    _firstLabel.textColor = [UIColor colorWithRed:0.3922 green:0.7725 blue:0.9686 alpha:1.0];
    _secondLabel.textColor = [UIColor colorWithRed:0.3922 green:0.7725 blue:0.9686 alpha:1.0];
    _thirdLabel.textColor = [UIColor colorWithRed:0.3922 green:0.7725 blue:0.9686 alpha:1.0];
}

-(void)tapImageViewAction:(UITapGestureRecognizer *)tapGesture {
    NSLog(@"%ld",tapGesture.view.tag);
    if (_actionArray != NULL) {
        void (^myBlock)() = _actionArray[tapGesture.view.tag];
        myBlock();
    }
}


@end
