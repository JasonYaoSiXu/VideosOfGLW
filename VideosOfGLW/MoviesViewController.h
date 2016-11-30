//
//  MoviesViewController.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/8/31.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseCityViewController.h"

@interface MoviesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIButton *chooseCityButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentButton;
@property (weak, nonatomic) IBOutlet UILabel *hotMoviesLabel;
@property (weak, nonatomic) IBOutlet UILabel *wullDisplayLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UICollectionView *customCollectionView;

- (IBAction)tapChooseCityButton:(UIButton *)sender;
- (IBAction)tapSegmentButton:(UISegmentedControl *)sender;
- (IBAction)tapSearchButton:(UIButton *)sender;

@end
