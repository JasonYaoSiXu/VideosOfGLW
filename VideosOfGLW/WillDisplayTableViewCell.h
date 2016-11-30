//
//  WillDisplayTableViewCell.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapCellProtocl.h"

@interface WillDisplayTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *customCollectionView;
@property (weak,nonatomic) id<TapCellProtocl> delegate;
//@property (nonatomic,strong) NSMutableArray *actionArray;
//@property (nonatomic,strong) void(^tapCell)();

@end
