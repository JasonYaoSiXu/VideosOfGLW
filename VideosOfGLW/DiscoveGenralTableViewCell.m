//
//  DiscoveGenralTableViewCell.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/8/31.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "DiscoveGenralTableViewCell.h"

@implementation DiscoveGenralTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _bgImageView.clipsToBounds = YES;
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
