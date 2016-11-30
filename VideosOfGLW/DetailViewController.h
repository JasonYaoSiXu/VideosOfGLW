//
//  DetailViewController.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/8/31.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

-(instancetype)initWithDestFrame:(CGRect)destFrame;
@property (nonatomic,strong) UIImageView *imageViews;
@property (nonatomic,strong) UIView *snapView;

@end
