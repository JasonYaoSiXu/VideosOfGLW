//
//  HotMoviesTableViewCell.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "HotMoviesTableViewCell.h"
#import "HotMoviesCollectionViewCell.h"
#import "UIImageView+loadIMageView.h"

@implementation HotMoviesTableViewCell {
    NSString *cellIdentifier;
    NSMutableArray *cellArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    [self initCollectionView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)initCollectionView{
    cellIdentifier = @"HotMoviesCollectionViewCell";
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(100, 200);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    
    UICollectionView *collectionView = [[UICollectionView alloc]  initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 10, self.bounds.size.height) collectionViewLayout:flowLayout ];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:NULL];
    [collectionView registerNib:nib forCellWithReuseIdentifier:cellIdentifier];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [self addSubview:collectionView];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1000;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (cellArray == nil) {
        cellArray = [[NSMutableArray alloc] init];
    }
    
    HotMoviesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cellArray addObject:cell];
    [cell.avtarOfMovies loadImageWithURLString:@"http://mobileimg.gewara.com/images/adv/201609/s6594cbad_156fed0617c__7ff9.jpg"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
//    if (self.tapCell) {
//        _tapCell();
//    }
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    HotMoviesCollectionViewCell *cell = cellArray[indexPath.row];
    CGPoint originPoint = CGPointMake(self.frame.origin.x + 10, self.frame.origin.y);
    [_delegate tapRect:originPoint infoRect:cell.avtarOfMovies.frame];
}

@end
