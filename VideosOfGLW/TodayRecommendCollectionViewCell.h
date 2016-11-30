//
//  TodayRecommendCollectionViewCell.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayRecommendCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avartImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *classifyLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (nonatomic,strong) void(^ myBlock)();

@end
