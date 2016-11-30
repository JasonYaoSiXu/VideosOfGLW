//
//  CircleView.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/1.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "CircleView.h"
#import "CustomPageControl.h"
#import "CircleViewCollectionViewCell.h"

@implementation CircleView {
    NSMutableArray *itemArray;
    UICollectionView *collectionView;
    CustomPageControl *pageControl;
    NSString *cellIdentifier;
}

-(instancetype)initWithFrameItemArray:(CGRect)frame itemArray:(NSMutableArray *)item {
    itemArray = item;
    
    cellIdentifier = @"CircleViewCollectionViewCell";
    if (self == [super initWithFrame:frame]) {
        return self;
    }
    return self;
}

-(void)initAddSubviews {
    [self initCollectionView];
    [self initPageControl];
}

//初始化并添加collectionview
-(void)initCollectionView {
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewFlowLayout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    collectionViewFlowLayout.minimumLineSpacing = 0;
    collectionViewFlowLayout.minimumInteritemSpacing = 0;
    
    collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:collectionViewFlowLayout];
    collectionView.pagingEnabled = YES;
    collectionView.bounces = false;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:NULL];
    [collectionView registerNib:nib forCellWithReuseIdentifier:cellIdentifier];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [self addSubview:collectionView];
}

//初始化并添加pageControl
-(void)initPageControl{
    pageControl = [[CustomPageControl alloc] initWithFrameDotSize:CGRectMake(0, self.bounds.size.height - 10, 100, 10) dotSize:CGSizeMake(20, 3)];
    pageControl.numberOfPages = itemArray.count;
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.pageIndicatorTintColor = [UIColor redColor];
    pageControl.center = CGPointMake(self.center.x, pageControl.center.y);
    [self addSubview:pageControl];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / self.bounds.size.width;
    [pageControl setCurrentPage:index];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return itemArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CircleViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.bgImageView.image = [UIImage imageNamed:itemArray[indexPath.row]];
    return cell;
}

@end
