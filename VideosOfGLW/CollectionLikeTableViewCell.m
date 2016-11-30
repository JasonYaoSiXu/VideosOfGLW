//
//  CollectionLikeTableViewCell.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/13.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "CollectionLikeTableViewCell.h"
#import "CollectionLikeCollectionViewCell.h"

@implementation CollectionLikeTableViewCell {
    NSString *cellIdentifier;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self initSubviews];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)initSubviews {
    cellIdentifier = @"CollectionLikeCollectionViewCell";
    _titleLabel.text = @"开学季集赞商城";
    
    _customCollectionView.delegate = self;
    _customCollectionView.dataSource = self;
    _customCollectionView.backgroundColor = [UIColor whiteColor];
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:NULL];
    [_customCollectionView registerNib:nib forCellWithReuseIdentifier:cellIdentifier];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionLikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.nameLabel.text = @"duolaAmeng";
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
}


@end
