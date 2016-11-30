//
//  MoviesViewController.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/8/31.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "MoviesViewController.h"

@interface MoviesViewController ()
///初始化所有的子视图
-(void)initSubviews;
@end

@implementation MoviesViewController {
    NSMutableArray *labelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self initSubviews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (IBAction)tapChooseCityButton:(UIButton *)sender {
    NSLog(@"%s",__FUNCTION__);
    UINavigationController *nVC = [[UINavigationController alloc] initWithRootViewController:[[ChooseCityViewController alloc] init]];
    [self presentViewController:nVC animated:YES completion:nil];
}

- (IBAction)tapSegmentButton:(UISegmentedControl *)sender {
    NSLog(@"%s",__FUNCTION__);
    _segmentButton.selectedSegmentIndex = sender.selectedSegmentIndex;
    
    for (UILabel *label in labelArray) {
        if (label.tag == _segmentButton.selectedSegmentIndex) {
            label.textColor = [UIColor redColor];
        } else {
            label.textColor = [UIColor blackColor];
        }
    }

}

- (IBAction)tapSearchButton:(UIButton *)sender {
    NSLog(@"%s",__FUNCTION__);
}

-(void) initSubviews {
    
    _headView.backgroundColor = [UIColor darkGrayColor];
    
    if (labelArray == nil) {
        labelArray = [[NSMutableArray alloc] init];
    }
    
    _hotMoviesLabel.tag = 0;
    _wullDisplayLabel.tag = 1;
    [labelArray addObject:_hotMoviesLabel];
    [labelArray addObject:_wullDisplayLabel];
    
    _segmentButton.selectedSegmentIndex = 0;
    _hotMoviesLabel.textColor = [UIColor redColor];
    _segmentButton.tintColor = [UIColor redColor];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    [_segmentButton setTitleTextAttributes:dict forState:UIControlStateNormal];
    [_segmentButton setTitleTextAttributes:dict forState:UIControlStateSelected];
    _segmentButton.layer.cornerRadius = _segmentButton.frame.size.height / 2;
    _segmentButton.layer.masksToBounds = YES;
    
    _customCollectionView.backgroundColor = [UIColor whiteColor];
}//initSubviews


@end
