//
//  ChooseCityViewController.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "ChooseCityViewController.h"

@interface ChooseCityViewController ()
///初始化子视图
-(void)initSubviews;
@end

@implementation ChooseCityViewController {
    UISearchBar *mySearchBar;
    UITableView *myTableView;
    UIView *maskView;
    NSArray *titleArray;
    CGFloat tableViewOriginY;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubviews];
    
    titleArray = [[NSArray alloc] initWithObjects:@"定位城市",@"热门城市",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"选择城市";
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil];
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 100, 30)];
    [closeButton addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:@"关闭" attributes:dict];
    [closeButton setAttributedTitle:buttonTitle forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:closeButton];
}

-(void)initSubviews {
    //添加搜索框
    mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 64)];
    mySearchBar.delegate = self;
    mySearchBar.placeholder = @"搜索";
    [self.view addSubview:mySearchBar];
    
    tableViewOriginY = mySearchBar.frame.origin.y + mySearchBar.frame.size.height;
    //添加tableView
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableViewOriginY, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - tableViewOriginY)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.tintColor = [UIColor  whiteColor];
    [self.view addSubview:myTableView];
    
    maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0;
    [self.view addSubview:maskView];
    maskView.hidden = YES;
    
    UITapGestureRecognizer *tapMaskView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCancleButtonAction)];
    [maskView addGestureRecognizer:tapMaskView];
}

-(void)dismissSelf {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//UITableVIew Delegate DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return titleArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (cell == nil) {
        cell = [UITableViewCell new];
        cell.textLabel.text = titleArray[indexPath.row];
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headTitleView = [[UIView alloc] init];
    headTitleView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, [UIScreen mainScreen].bounds.size.width, 22)];
    label.text = titleArray[section];
    [headTitleView addSubview:label];
    
    return headTitleView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return titleArray;
}

// UISearchBar Delegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"%s",__FUNCTION__);
    __block typeof(ChooseCityViewController *)Self = self;
    [UIView animateWithDuration:0.35 animations:^(){
        mySearchBar.frame = CGRectMake(0, 0, mySearchBar.frame.size.width, mySearchBar.frame.size.height);
        maskView.alpha = 0.6;
        maskView.hidden =  NO;
        mySearchBar.showsCancelButton = YES;
        myTableView.frame = CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - tableViewOriginY);
        Self.navigationController.navigationBar.frame = CGRectMake(0, -Self.navigationController.navigationBar.frame.size.width,Self.navigationController.navigationBar.frame.size.width , Self.navigationController.navigationBar.frame.size.height);
    }];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self tapCancleButtonAction];
}

-(void)tapCancleButtonAction {
    __block typeof(ChooseCityViewController *)Self = self;
    [UIView animateWithDuration:0.35 animations:^(){
        Self.navigationController.navigationBar.frame = CGRectMake(0,20,Self.navigationController.navigationBar.frame.size.width , Self.navigationController.navigationBar.frame.size.height);
        Self->mySearchBar.frame = CGRectMake(0, 64, Self->mySearchBar.frame.size.width, Self->mySearchBar.frame.size.height);
        Self->myTableView.frame = CGRectMake(0, tableViewOriginY,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - tableViewOriginY);
        Self->mySearchBar.showsCancelButton = NO;
        [Self->mySearchBar resignFirstResponder];
        maskView.alpha = 0;
        maskView.hidden =  YES;
    }];
}
@end
