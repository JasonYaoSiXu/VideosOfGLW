//
//  MainPageViewController.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/8/31.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//
#import "MainPageViewController.h"

@interface MainPageViewController ()

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUi];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpUi {
    
    NSMutableArray * viewControllerArray = [[NSMutableArray alloc] init ];
    
    UIViewController *vc;
    UINavigationController * nVC;
    
    
    vc = [[DiscoverViewController alloc] init];
    nVC = [[UINavigationController alloc] initWithRootViewController:vc];
    nVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"首页"] selectedImage:[UIImage imageNamed:@"首页-选中"]];
    nVC.tabBarItem.tag = 0;
    [viewControllerArray addObject:nVC];
    
    vc = [[MoviesViewController alloc] init];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MoviesViewController *moviesVC = [storyBoard instantiateViewControllerWithIdentifier:@"MoviesViewController"];
    nVC = [[UINavigationController alloc] initWithRootViewController:moviesVC ];
    nVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"电影" image:[UIImage imageNamed:@"购票"] selectedImage:[UIImage imageNamed:@"购票-选中"]];
    nVC.tabBarItem.tag = 1;
    [viewControllerArray addObject:nVC];
    
    vc = [[DisPlayViewController alloc] init];
    nVC = [[UINavigationController alloc] initWithRootViewController:vc ];
    nVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"演出" image:[UIImage imageNamed:@"购票"] selectedImage:[UIImage imageNamed:@"购票-选中"]];
    nVC.tabBarItem.tag = 2;
    [viewControllerArray addObject:nVC];

    self.viewControllers = viewControllerArray;
    
    NSMutableArray *actionArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.viewControllers.count; i++) {
        void (^myBlock)() = ^() {
            self.selectedIndex = (int)i;
        };
        [actionArray addObject:myBlock];
    }
    
    MainPageTabBarView *tabBarView = [[MainPageTabBarView alloc] initWithFrameAndButtonCount:self.tabBar.bounds buttonActions: actionArray];
    tabBarView.backgroundColor = [UIColor whiteColor];
    tabBarView.alpha = 1.0;
    [tabBarView addItem];
    [self.tabBar addSubview: tabBarView];
}


@end
