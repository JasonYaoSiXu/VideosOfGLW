//
//  TodayRecommendTableViewCell.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "TodayRecommendTableViewCell.h"
#import "TodayRecommendCollectionViewCell.h"

@implementation TodayRecommendTableViewCell {
    NSString *cellIdentifier;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self initSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initSubviews {
    cellIdentifier = @"TodayRecommendCollectionViewCell";
    _customCollectionView.backgroundColor = [UIColor whiteColor];
    _customCollectionView.delegate = self;
    _customCollectionView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:NULL];
    [_customCollectionView registerNib:nib forCellWithReuseIdentifier:cellIdentifier];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _pageControl.currentPage = scrollView.contentOffset.x / 270;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    _pageControl.numberOfPages = 6;
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TodayRecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.myBlock = ^() {
        NSLog(@"%ld",indexPath.row);
    };
    
    return cell;
}



@end
