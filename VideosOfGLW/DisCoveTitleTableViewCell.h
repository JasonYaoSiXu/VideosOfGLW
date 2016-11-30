//
//  DisCoveTitleTableViewCell.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/8/31.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisCoveTitleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;

- (IBAction)tapJumpButton:(UIButton *)sender;

@property (nullable,nonatomic, strong) void(^tapAction)(void);

@end
