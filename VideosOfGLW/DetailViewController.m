//
//  DetailViewController.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/8/31.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "DetailViewController.h"
#import "MaskLayerAnimation.h"
#import "PopAnimationViewController.h"
#import "DiscoverViewController.h"
#import "DetailCollectionViewCell.h"
#import "DetailTableViewCell.h"

@interface DetailViewController ()

@end

@implementation DetailViewController {
    MaskLayerAnimation *maskLayer;
    PopAnimationViewController *popAnimation;
    
    CGRect originRect;
    CGRect destRect;
    CGPoint touchBeginPoint;
    CGFloat touchMoveProgress;
    BOOL isCanTouchMove;
    BOOL tableViewIsHidden;
    BOOL isTapBackButtonToPop;
    
    UICollectionView *_collectionView;
    UITableView *_tableView;
    UIView *bottomMenuView;
    UIButton *showDetailButton;
    UIButton *hiddenDetaiButton;
    NSString *collectionCellIdentifier;
    NSString *tableViewCellIdentifier;
}

-(instancetype)initWithDestFrame:(CGRect)destFrame {
    originRect = destFrame;
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:destFrame];
    myImageView.frame = destFrame;
    myImageView.image = [UIImage imageNamed:@"login_bg"];
    _imageViews = myImageView;
    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:_imageViews];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.view.layer.mask = [[CAShapeLayer alloc] init];
    self.navigationController.delegate = self;
    popAnimation = [[PopAnimationViewController alloc] init];
    isTapBackButtonToPop = NO;
    
    collectionCellIdentifier = @"DetailCollectionViewCell";
    tableViewCellIdentifier = @"DetailTableViewCell";
    
    //初始化并添加_collectionView
    [self initCollectionView];
    //添加显示按钮
    [self addShowButton];
    //初始化并添加_tableView
    [self initTableView];
    // Do any additional setup after loading the view.
    [self addBottomMenuView];
    [self addBackButton];
//    [self swipeBack:_tableView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    NSLog(@"%@",NSStringFromCGRect(_imageViews.frame));
    [UIView animateWithDuration:1 animations:^(void){
        _imageViews.frame = CGRectMake(10, 200, _imageViews.frame.size.width, _imageViews.frame.size.height);
    } completion:^(BOOL finish) {
        NSLog(@"%@",NSStringFromCGRect(_imageViews.frame));
        originRect = _imageViews.frame;
        maskLayer = [[MaskLayerAnimation alloc] initShapeLayer:self.view durtionTime:1.5 locationPoint:CGPointMake(_imageViews.center.x, _imageViews.center.y) isShow:NO];
        [maskLayer startAnimation];
        __block DetailViewController *Self = self;
        maskLayer.finishAnimation = ^() {
            [Self->_imageViews removeFromSuperview];
//            [Self.view addSubview:Self->_imageViews];
            [Self addHeadViewForTableView];
        };
    }];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化collectionView
-(void)initCollectionView{
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, 150);
    collectionViewFlowLayout.minimumLineSpacing = 1;
    collectionViewFlowLayout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collectionViewFlowLayout ];
    UINib *nib = [UINib nibWithNibName:collectionCellIdentifier bundle:NULL];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:collectionCellIdentifier];
    _collectionView.backgroundColor = [UIColor grayColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
}

//初始化tableView
-(void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _tableView.backgroundColor = [UIColor clearColor];
    UINib *nib = [UINib nibWithNibName:tableViewCellIdentifier bundle:NULL];
    [_tableView registerNib:nib forCellReuseIdentifier:tableViewCellIdentifier];
    
    _tableView.rowHeight = 150;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)addHeadViewForTableView{
    UIView *tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 300)];
    tableHeadView.backgroundColor = [UIColor clearColor];
    [tableHeadView addSubview:_imageViews];
    _tableView.tableHeaderView = tableHeadView;
    
    hiddenDetaiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    hiddenDetaiButton.backgroundColor = [UIColor clearColor];
    hiddenDetaiButton.center = tableHeadView.center;
    [hiddenDetaiButton setTitle:@"隐藏" forState:UIControlStateNormal];
    [hiddenDetaiButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [hiddenDetaiButton addTarget:self action:@selector(hiddenButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [tableHeadView addSubview:hiddenDetaiButton];
}

-(void)hiddenButtonAction{
    [UIView animateWithDuration:1.0 animations:^(void){
        bottomMenuView.alpha = 0.0;
        _tableView.frame = CGRectMake(0, self.view.bounds.size.height, _tableView.bounds.size.width, _tableView.bounds.size.height);
    }completion:^(BOOL finish){
         showDetailButton.alpha = 0.7;
         tableViewIsHidden = YES;
    }];
}

-(void)addShowButton{
    showDetailButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 30, self.view.bounds.size.width, 30) ];
    showDetailButton.backgroundColor = [UIColor blackColor];
    [showDetailButton setTitle:@"显示" forState:UIControlStateNormal];
    [showDetailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [showDetailButton addTarget:self action:@selector(showButtonAction) forControlEvents:UIControlEventTouchUpInside];
    showDetailButton.alpha = 0.0;
    [self.view addSubview:showDetailButton];
}

-(void)showButtonAction{
    [UIView animateWithDuration:1.0 animations:^(void){
        bottomMenuView.alpha = 1.0;
        _tableView.frame = CGRectMake(0, 0, _tableView.bounds.size.width, _tableView.bounds.size.height);
    }completion:^(BOOL finish){
        showDetailButton.alpha = 0.0;
        tableViewIsHidden = NO;
    }];
}

//添加返回按钮
-(void)addBackButton {
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 40, 50, 30)];
    [backButton setBackgroundColor: [UIColor darkGrayColor]];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(tapBackButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

//返回按钮执行的动作
-(void)tapBackButtonAction {
    if (tableViewIsHidden) {
        [self showButtonAction];
    } else {
        isTapBackButtonToPop = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
}


// 滑动返回
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSArray * touchsArray = touches.allObjects;
    UITapGestureRecognizer *tap = touchsArray.lastObject;
    NSLog(@"%@",NSStringFromCGPoint([tap locationInView:[UIApplication sharedApplication].keyWindow]));
    touchBeginPoint = [tap locationInView:[UIApplication sharedApplication].keyWindow];
    if (touchBeginPoint.x > 20 ) {
        isCanTouchMove = NO;
        return;
    } else {
        isCanTouchMove = YES;
    }

    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor blackColor];
    _snapView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [[UIApplication sharedApplication].keyWindow addSubview:_snapView];
    [[UIApplication sharedApplication].keyWindow sendSubviewToBack:_snapView];
    
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (!isCanTouchMove) {
        return;
    }
    _tableView.scrollEnabled = NO;
    _collectionView.scrollEnabled = NO;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - touchBeginPoint.x;
    NSArray * touchsArray = touches.allObjects;
    UITapGestureRecognizer *tap = touchsArray.lastObject;
    CGPoint touchPoint = [tap locationInView:[UIApplication sharedApplication].keyWindow];
    /*
        初始的时候_sanpView的transform = CGAffineTransformMakeScake(0.8,0.8), 要_snapView和屏幕一样大还差0.2,
        通过 (touchPoint.x - touchBeginPoint.x) / width的值的范围是0到1。再除以5就是0到0.2了.
     */
    touchMoveProgress = (touchPoint.x - touchBeginPoint.x) / width / 5;
    _snapView.transform = CGAffineTransformMakeScale(0.8 + touchMoveProgress, 0.8 + touchMoveProgress);
    self.view.frame = CGRectMake(touchPoint.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (!isCanTouchMove) {
        return;
    }
    
    NSArray * touchsArray = touches.allObjects;
    UITapGestureRecognizer *tap = touchsArray.lastObject;
    CGPoint touchPoint = [tap locationInView:[UIApplication sharedApplication].keyWindow];

    if (touchPoint.x > [UIScreen mainScreen].bounds.size.width / 2) {
        [UIView animateWithDuration:0.5 animations:^(void){
            if (touchMoveProgress < 1) {
                _snapView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }
            self.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        }completion:^(BOOL finish){
            [_snapView removeFromSuperview];
            [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
            [self.navigationController popViewControllerAnimated:NO];
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^(void){
            _snapView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }completion:^(BOOL finish){
            [_snapView removeFromSuperview];
            [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
            _tableView.scrollEnabled = YES;
            _collectionView.scrollEnabled = YES;
        }];
    }
    
}

//自定义转场动画

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0) {
    
    if (operation == UINavigationControllerOperationPop && [toVC isKindOfClass:[DiscoverViewController class]]) {
        if (isTapBackButtonToPop) {
            return popAnimation;
        } else {
            return NULL;
        }
    }
    
    return NULL;
}


//UICollectionView 代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s",__FUNCTION__);
}

//UITableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier forIndexPath:indexPath];
    return cell;
}


//添加底部菜单栏
-(void)addBottomMenuView{
    bottomMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40) ];
    bottomMenuView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:bottomMenuView];
}

//滑动tableView显示与隐藏底部菜单栏
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _tableView) {
        NSLog(@"%s",__FUNCTION__);
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == _tableView) {
        [UIView animateWithDuration:0.5 animations:^(void){
            bottomMenuView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 40);
        }];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _tableView) {
        [UIView animateWithDuration:0.5 animations:^(void){
            bottomMenuView.frame = CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40);
        }];
    }
}



//// 添加手势滑动返回
//-(void)swipeBack:(UIView *)destView {
//    UIPanGestureRecognizer *swipeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:) ];
//    [destView addGestureRecognizer:swipeGesture];
//}
//
//
//-(void)swipeAction:(UIPanGestureRecognizer *)swipeGesture {
//    CGPoint point = [swipeGesture locationInView:swipeGesture.view];
//    if (swipeGesture.state == UIGestureRecognizerStateChanged) {
//        
//    } else if (swipeGesture.state == UIGestureRecognizerStateEnded) {
//        [self endSwipe:point];
//        NSLog(@"%@",NSStringFromCGPoint(point));
//    } else if (swipeGesture.state == UIGestureRecognizerStateBegan) {
//        NSLog(@"%@",NSStringFromCGPoint(point));
//    }
//}
//
//-(void)endSwipe:(CGPoint)point{
//    NSLog(@"%s,%@",__FUNCTION__,NSStringFromCGPoint(point));
//}

@end

@implementation UIScrollView (UITouch)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

@end
