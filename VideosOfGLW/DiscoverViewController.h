//
//  DiscoverViewController.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/8/31.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadScroll.h"
#import "LocationMessage.h"
#import "DetailViewController.h"
#import "MaskLayerAnimation.h"
#import "CircleView.h"
#import "HeadScrollView.h"
#import "HeadScroll.h"
#import "CustomPageControl.h"
#import "DiscoverFirstCellTableViewCell.h"
#import "HotMoviesTableViewCell.h"
#import "DisCoveTitleTableViewCell.h"
#import "WillDisplayTableViewCell.h"
#import "TodayRecommendTableViewCell.h"
#import "CollectionLikeTableViewCell.h"
#import "RequestMessage.h"
#import "ConnectNet.h"
#import "TapCellProtocl.h"
#import "MapperDictionary.h"

@interface DiscoverViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,HeadScrollDelegate,LocationMessageDelegate,TapCellProtocl,ConnectNetDelegate>

@property (nonatomic,assign) CGRect destRect;

@end
