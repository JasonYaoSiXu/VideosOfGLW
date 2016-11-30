//
//  WillDisplayTableViewCell.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "WillDisplayTableViewCell.h"
#import "WillDisplayCollectionViewCell.h"

@implementation WillDisplayTableViewCell {
    NSString *cellIdentifier;
    NSMutableArray *cellArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
    [self initSubView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)initSubView {
    cellIdentifier = @"WillDisplayCollectionViewCell";
    UINib* nib = [UINib nibWithNibName:cellIdentifier bundle:NULL];
    [_customCollectionView registerNib:nib forCellWithReuseIdentifier:cellIdentifier];
    _customCollectionView.backgroundColor = [UIColor whiteColor];
    _customCollectionView.delegate = self;
    _customCollectionView.dataSource = self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (cellArray == nil) {
        cellArray = [[NSMutableArray alloc] init];
    }
    WillDisplayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cellArray addObject:cell];
//    cell.myBlock = ^() {
//        NSLog(@"%ld",indexPath.row);
//    };    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
//    if (self.tapCell) {
//        _tapCell();
//    }
    
    CGPoint point = CGPointMake(self.frame.origin.x + 10, self.frame.origin.y);
    WillDisplayCollectionViewCell *cell = cellArray[indexPath.row];
    [_delegate tapRect:point infoRect:cell.avartImageView.frame];
}

@end
