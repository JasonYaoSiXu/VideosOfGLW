//
//  HotMoviesTableViewCell.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapCellProtocl.h"

@interface HotMoviesTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

//@property (nonatomic,strong) NSMutableArray *actionArray;
//@property (nonatomic,strong) void(^tapCell)();
@property (nonatomic,weak) id<TapCellProtocl> delegate;

@end
