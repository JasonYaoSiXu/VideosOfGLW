//
//  DisCoveTitleTableViewCell.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/8/31.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "DisCoveTitleTableViewCell.h"

@implementation DisCoveTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)tapJumpButton:(UIButton *)sender {
    _tapAction();
}

-(void)setSubViews {
    
    _titleView.layer.cornerRadius = _titleView.bounds.size.width / 2;
    _titleView.backgroundColor = [UIColor colorWithRed:0.9843 green:0.0 blue:0.0353 alpha:1.0];
    
    _titleLabel.text = @"热映电影";
    _titleLabel.textColor = [UIColor colorWithRed:0.0745 green:0.0745 blue:0.0745 alpha:1.0];
    
    [_jumpButton setTitleColor:[UIColor colorWithRed:0.6471 green:0.6471 blue:0.6471 alpha:1.0] forState:UIControlStateNormal];
}

@end
