//
//  TodayRecommendTableViewCell.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayRecommendTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UICollectionView *customCollectionView;
@property (nonatomic,strong) NSMutableArray *actionArray;

@end
