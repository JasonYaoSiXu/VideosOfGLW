//
//  CollectionLikeCollectionViewCell.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/13.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionLikeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avartImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
