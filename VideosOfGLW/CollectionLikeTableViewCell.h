//
//  CollectionLikeTableViewCell.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/13.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionLikeTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *avartImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *customCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,strong) NSMutableArray *actionArray;

@end
