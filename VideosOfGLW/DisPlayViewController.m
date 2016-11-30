//
//  DisPlayViewController.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/7.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "DisPlayViewController.h"

@interface DisPlayViewController ()
///添加子视图
-(void)addSubviews;
///响应点击addButton的事件
-(void)addButtonAction;
@end

@implementation DisPlayViewController {
    UIButton *addButton;
    UIButton *voteButton;
    UIButton *messageButton;
    UIView *maskView;
    UITableView *myTableView;
    UIImageView *headImageView;
    
    CGFloat height;
    BOOL isShowMaskView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"演出";
    isShowMaskView = NO;
    height = 300;
    [self addSubviews];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addSubviews {
    myTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    myTableView.backgroundColor = [UIColor whiteColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -height, [UIScreen mainScreen].bounds.size.width, height)];
    headImageView.image = [UIImage imageNamed:@"4"];
    
    [myTableView addSubview: headImageView];
    myTableView.tableHeaderView = [UIView new];
    myTableView.tableFooterView = [UIView new];
    
    myTableView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    myTableView.contentOffset = CGPointMake(0, -height);
    
    [self.view addSubview:myTableView];
    
    maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.0;
    [self.view addSubview:maskView];
    maskView.hidden = YES;
    
    CGFloat buttonWidthHeight = 30;
    addButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - buttonWidthHeight - 20, [UIScreen mainScreen].bounds.size.height - 79 - buttonWidthHeight, buttonWidthHeight, buttonWidthHeight)];
    addButton.backgroundColor = [UIColor orangeColor];
    [addButton setTitle:@"＋" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    addButton.layer.cornerRadius = addButton.bounds.size.height / 2;
    
    voteButton = [[UIButton alloc] initWithFrame:addButton.bounds];
    voteButton.backgroundColor = [UIColor blackColor];
    voteButton.layer.cornerRadius = voteButton.bounds.size.height / 2;
    voteButton.hidden = YES;
    voteButton.alpha = 0.0;
    
    messageButton = [[UIButton alloc] initWithFrame:addButton.bounds];
    messageButton.backgroundColor = [UIColor cyanColor];
    messageButton.layer.cornerRadius = messageButton.bounds.size.height / 2;
    messageButton.hidden = YES;
    messageButton.alpha = 0.0;
    
    [self.view addSubview:voteButton];
    [self.view addSubview:messageButton];
    [self.view addSubview:addButton];
} //addSubviews

-(void)addButtonAction {
    
    isShowMaskView = !isShowMaskView;
    maskView.hidden = NO;
    CGPoint originPoint = CGPointMake([UIScreen mainScreen].bounds.size.width, addButton.center.y - 100);
    
    [UIView animateWithDuration:0.35 animations:^() {
        if (isShowMaskView) {
            [self moveCircleAnimation:voteButton.layer startAngle:3.14 / 2 + 3.14 / 6 endAngle:3.14 originPoint:originPoint animationTime:0.5 radius:100 clockwise:YES];
            [self moveCircleAnimation:messageButton.layer startAngle:3.14 / 2 + 3.14 / 6 endAngle:3.14 / 2 + 3.14 / 3 originPoint:originPoint animationTime:0.4 radius:100 clockwise:YES];
            addButton.transform = CGAffineTransformMakeRotation( - 3.14 / 4);
            voteButton.alpha = 1.0;
            messageButton.alpha = 1.0;
            maskView.alpha = 0.7;
        } else {
            [self moveCircleAnimation:voteButton.layer startAngle:3.14 endAngle:3.14 / 2 + 3.14 / 6 originPoint:originPoint animationTime:0.35 radius:100 clockwise:NO];
            [self moveCircleAnimation:voteButton.layer startAngle:3.14 / 2 + 3.14 / 3 endAngle:3.14 / 2 + 3.14 / 6 originPoint:originPoint animationTime:0.25 radius:100 clockwise:NO];
            addButton.transform = CGAffineTransformMakeRotation(0);
            voteButton.alpha = 0.0;
            messageButton.alpha = 0.0;
            maskView.alpha = 0.0;
        }
    } completion:^(BOOL finish){
        voteButton.hidden = !isShowMaskView;
        messageButton.hidden = !isShowMaskView;
        maskView.hidden = !isShowMaskView;
    }];
    
} //addButtonAction


-(void)moveCircleAnimation:(CALayer *)layer  startAngle:(CGFloat)start endAngle:(CGFloat)end originPoint:(CGPoint)origin  animationTime:(CFTimeInterval)time radius:(CGFloat)radius clockwise:(BOOL)clockwise {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    animation.path = [UIBezierPath bezierPathWithArcCenter:origin radius:radius startAngle:start endAngle:end clockwise:clockwise].CGPath;
    animation.duration = time;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [layer addAnimation:animation forKey:@"position"];
} //moveCircleAnimation


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (myTableView.contentOffset.y <= -height) {
        CGFloat offSet = myTableView.contentOffset.y + height;
        headImageView.frame = CGRectMake(offSet / 2, myTableView.contentOffset.y, [UIScreen mainScreen].bounds.size.width + fabs(offSet), -myTableView.contentOffset.y);
    }
}

// pramna mark - UITableViewdataSource UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
