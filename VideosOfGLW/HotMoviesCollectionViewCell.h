//
//  HotMoviesCollectionViewCell.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotMoviesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avtarOfMovies;
@property (weak, nonatomic) IBOutlet UIImageView *startsImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameOfMovies;
@property (weak, nonatomic) IBOutlet UILabel *startsNumberLabel;

@property (nonatomic,strong) void(^ myBlock)();

@end
