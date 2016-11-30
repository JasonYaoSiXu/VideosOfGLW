//
//  DiscoverViewController.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/8/31.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController {
    UIView *statusBarView;
    NSString *cellIdentifier;
    UITableView *myTableView;
    UIView *statusBackView;
    NSString *firstCellIdentifier;
    NSString *secondCellIdentifier;
    NSString *thirdCellIdentifier;
    NSString *fourthCellIdentifier;
    NSString *colletionCellIdentifier;
    NSArray *titleName;
    
    NSString *_lat;
    NSString *_lng;
    NSString *_cityCode;
    NSString *_cityName;
    
    HeadScroll *scroll;
    CustomPageControl *custom;
    ConnectNet *connect;
    RequestMessage *message;
    LocationMessage *locationMessage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"DISCOVER";
    // Do any additional setup after loading the view.
    
    cellIdentifier = @"DisCoveTitleTableViewCell";
    statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    statusBarView.backgroundColor = [UIColor colorWithRed:0.7216 green:0.7216 blue:0.7294 alpha:1.0];
    [self.view addSubview:statusBarView];
    
    //初始化轮播图
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4", nil];
    scroll = [[HeadScroll alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200) picturesArray:array atIndex:0];
    scroll.indexDelegate = self;
    
    custom = [[CustomPageControl alloc] initWithFrameDotSize:CGRectMake(0, scroll.bounds.size.height - 20, 100, 10) dotSize:CGSizeMake(15, 6)];
    custom.numberOfPages = array.count;
    custom.currentPage = 0;
    custom.currentPageIndicatorTintColor = [UIColor redColor];
    custom.pageIndicatorTintColor = [UIColor darkGrayColor];
    custom.center = CGPointMake(scroll.center.x, custom.center.y);
    //初始化tableView
    [self initTableView];
    //初始化状态栏背景视图
    statusBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    statusBackView.hidden = YES;
    [self.view addSubview:statusBackView];
    
    message = [[RequestMessage alloc] init];
    locationMessage = [[LocationMessage alloc] init];
    [locationMessage applyLoaciton];
    locationMessage.locationDelegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    statusBarView.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addStatusBackView:(UIColor*)backColor isShow:(BOOL)hidden statusStyle:(UIStatusBarStyle)style{
    statusBackView.backgroundColor = backColor;
    statusBackView.hidden = hidden;
    [UIApplication sharedApplication].statusBarStyle = style;
}

///初始化tableView
-(void)initTableView {
    firstCellIdentifier = @"DiscoverFirstCellTableViewCell";
    secondCellIdentifier = @"HotMoviesTableViewCell";
    thirdCellIdentifier = @"WillDisplayTableViewCell";
    fourthCellIdentifier = @"TodayRecommendTableViewCell";
    colletionCellIdentifier = @"CollectionLikeTableViewCell";
    titleName = [[NSArray alloc] initWithObjects:@"热映电影",@"即将上映",@"今日推荐",@"集赞商城",@"优惠享不停", nil];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,  [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49) style:UITableViewStyleGrouped];
    myTableView.tableHeaderView = scroll;
    myTableView.showsVerticalScrollIndicator = false;
    myTableView.backgroundColor = [UIColor whiteColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *nib = [UINib  nibWithNibName:cellIdentifier bundle:NULL];
    [myTableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    nib = [UINib nibWithNibName:firstCellIdentifier bundle:NULL];
    [myTableView registerNib:nib forCellReuseIdentifier:firstCellIdentifier];
    nib = [UINib nibWithNibName:secondCellIdentifier bundle:NULL];
    [myTableView registerNib:nib forCellReuseIdentifier:secondCellIdentifier];
    nib = [UINib nibWithNibName:thirdCellIdentifier bundle:NULL];
    [myTableView registerNib:nib forCellReuseIdentifier:thirdCellIdentifier];
    nib = [UINib nibWithNibName:fourthCellIdentifier bundle:NULL];
    [myTableView registerNib:nib forCellReuseIdentifier:fourthCellIdentifier];
    nib = [UINib nibWithNibName:colletionCellIdentifier bundle:NULL];
    [myTableView registerNib:nib forCellReuseIdentifier:colletionCellIdentifier];
    
    myTableView.tableFooterView = [UIView new];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    
    [self.view addSubview:myTableView];
    [myTableView addSubview:custom];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y > 0) {
        if (scrollView.contentOffset.y >= 200) {
            [self addStatusBackView:[UIColor colorWithRed:0.8078 green:0.8471 blue:0.8039 alpha:1.0] isShow:NO statusStyle:UIStatusBarStyleDefault];
        } else {
            [self addStatusBackView:[UIColor darkGrayColor] isShow:YES statusStyle:UIStatusBarStyleLightContent];
        }
    } else if (scrollView.contentOffset.y <= 0){
        scroll.clipsToBounds = false;
        scroll.midContainter.clipsToBounds = false;
        scroll.midContainter.subviews[0].clipsToBounds = false;
        scroll.midContainter.subviews[0].frame = CGRectMake( myTableView.contentOffset.y / 2, myTableView.contentOffset.y,self.view.bounds.size.width + fabs(myTableView.contentOffset.y), 200 + fabs(myTableView.contentOffset.y));
        if (scrollView.contentOffset.y == 0 ) {
            scroll.clipsToBounds = true;
            scroll.midContainter.clipsToBounds = true;
            scroll.midContainter.subviews[0].clipsToBounds = true;
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 3 || section == 5) {
        return 1;
    } else {
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DiscoverFirstCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCellIdentifier forIndexPath:indexPath];
        return cell;
    } else {
        if (indexPath.section == 3 || indexPath.section == 5) {
            TodayRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fourthCellIdentifier forIndexPath:indexPath];
            cell.titleLabel.text = @"今日推荐";
            return cell;
        } else {
            if (indexPath.row == 0) {
                DisCoveTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
                cell.titleLabel.text = titleName[indexPath.section - 1];
                return cell;
            } else if (indexPath.section == 1) {
                HotMoviesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondCellIdentifier forIndexPath:indexPath];
                cell.delegate = self;
                return cell;
            } else if (indexPath.section == 2) {
                WillDisplayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdCellIdentifier forIndexPath:indexPath];
                cell.delegate = self;
                return cell;
            } else {
                CollectionLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:colletionCellIdentifier forIndexPath:indexPath];
                return cell;
            }
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 100;
    }  else if (indexPath.section == 3 || indexPath.section == 5) {
        return 244;
    } else {
        if (indexPath.section == 4 && indexPath.row == 1) {
            return 400;
        } else if (indexPath.row == 0 ) {
            return 44;
        } else {
            return 200;
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 5) {
        return 0;
    } else {
        return 10;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 10)];
    view.backgroundColor = [UIColor colorWithRed:0.7216 green:0.7216 blue:0.7294 alpha:1.0];
    return view;
}

-(void)headScrollDelegateIndex:(NSInteger)index {
    [custom setCurrentPage:index];
}

-(void)latOfLocation:(NSString *)lat {//y
    _lat = lat;
}

-(void)logOfLocation:(NSString *)log { //x
    _lng = log;
}

-(void)cityCodeOfLocation:(NSString *)cityCode {
    _cityCode = cityCode;
}

-(void)cityNameOfLocation:(NSString *)cityName {
    _cityName = cityName;
    NSDictionary *messageDic = [message requestMessage:_lat lngOfLocation:_lng cityCodeOfLocation:_cityCode cityNameOfLocation:_cityName];
    
    connect = [[ConnectNet alloc] initWithURLHttpMethodHttpBody:@"/router/rest?" HttpMethod:POST HttpBody:(NSMutableDictionary *)messageDic];
//    NSLog(@"data == %@",[connect requestData]);
    connect.delegate = self;
    [connect requestData];
}

-(void)tapRect:(CGPoint)cellOrigin infoRect:(CGRect)rect {
    NSLog(@"%@,    %@",NSStringFromCGPoint(cellOrigin),NSStringFromCGRect(rect));
    _destRect = CGRectMake(cellOrigin.x + rect.origin.x, cellOrigin.y + rect.origin.y - myTableView.contentOffset.y, rect.size.width, rect.size.height);
    DetailViewController *vc = [[DetailViewController alloc] initWithDestFrame:_destRect ];
    vc.snapView = [[UIApplication sharedApplication].keyWindow snapshotViewAfterScreenUpdates:NO];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
    self.hidesBottomBarWhenPushed = YES;
}

-(void)responseData:(NSDictionary *)data {
    NSLog(@"-----------------------\n%lu",data.count);
    
    NSArray <NSDictionary *>*array = [MapperDictionary mapperObject:data];
    
    for (NSArray *item in array) {
        NSLog(@"%@",item);
    }
    
}


@end
