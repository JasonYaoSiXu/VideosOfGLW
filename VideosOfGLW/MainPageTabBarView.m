//
//  MainPageTabBarView.m
//  VideosOfGLW
//
//  Created by yaosixu on 16/8/31.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

#import "MainPageTabBarView.h"
//#import "Masonry.h"
#import "BarItemView.h"

@implementation MainPageTabBarView {
    NSMutableArray *actionArray;
    NSMutableArray *itemArray;
    NSMutableArray *notSelectImageArray;
    NSMutableArray *selectImageArray;
    int selectIndex;
    NSInteger itemCount;
    CGFloat itemWidth;
    bool isLastAtOther;
}

-(instancetype)initWithFrameAndButtonCount:(CGRect)frame buttonActions:(NSMutableArray*)action {
    notSelectImageArray = [[NSMutableArray alloc] initWithObjects:@"首页",@"发现",@"购票",@"我的", nil];
    selectImageArray = [[NSMutableArray alloc] initWithObjects:@"首页-选中",@"发现-选中",@"购票-选中",@"我的-选中", nil];
    actionArray = action;
    itemCount = actionArray.count;
    isLastAtOther = NO;
    itemWidth = 90;
    selectIndex = 0;
    if (self == [super initWithFrame:frame] ) {
        return self;
    }
    return self;
}

-(void)addItem {
    itemArray =  [[NSMutableArray alloc] init ];
    for (NSInteger i = 0; i < itemCount; i++) {
        __block BarItemView *barItem;
        if (i == 0) {
            barItem = [[BarItemView alloc] initWithFrame:CGRectMake(0, 0, itemWidth, self.bounds.size.height) ];
            [barItem addSubViews];
            barItem.itemName.text = notSelectImageArray[i];
            barItem.imageName.image = [UIImage imageNamed:selectImageArray[i]];
            barItem.isSelect = YES;
        } else {
            barItem = [[BarItemView alloc] initWithFrame:CGRectMake(i * itemWidth / 3 + (itemWidth / 3 * 2), 0, itemWidth / 3, self.bounds.size.height) ];
            [barItem addSubViews];
            barItem.itemName.text = @"";
            barItem.imageName.image = [UIImage imageNamed:notSelectImageArray[i]];
            barItem.isSelect = NO;
        }
        barItem.tag = i;
        
//        barItem.backgroundColor = [UIColor blueColor];
        [itemArray addObject:barItem];
        [self addSubview:barItem];
        [self addAction:barItem];
        
//        BarItemView *barItem = [BarItemView new];
//        barItem.backgroundColor = [UIColor blueColor];
//        [self addSubview:barItem];
//        
//        if (i == 0) {
//            [barItem mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.mas_top).offset(0);
//                make.bottom.equalTo(self.mas_bottom).offset(0);
//                make.left.equalTo(self.mas_left).offset(10);
//                make.width.mas_equalTo(itemWidth);
//            }];
//        } else {
//            [barItem mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.mas_top).offset(0);
//                make.bottom.equalTo(self.mas_bottom).offset(0);
//                make.left.equalTo(((BarItemView *)itemArray[i - 1]).mas_right).offset(0);
//                make.width.mas_equalTo(itemWidth / 3);
//            }];
//        }
//        barItem.tag = i;
//        [barItem addSubViews];
//        [itemArray addObject:barItem];
//        [self addAction:barItem];
    }
}

-(void)addAction:(BarItemView *)barItem {
    __weak typeof(BarItemView *) Self = barItem;
    void (^myBlock)() = ^() {};
    myBlock = actionArray[Self.tag];
    Self.tapAction = ^() {
        if (Self.isSelect == NO) {
            myBlock();
            BarItemView * selectItem = ((BarItemView *)itemArray[selectIndex]);
            Self.itemName.text = notSelectImageArray[Self.tag];
            Self.imageName.image = [UIImage imageNamed:selectImageArray[Self.tag]];
            selectItem.itemName.text = @"";
            selectItem.imageName.image = [UIImage imageNamed:notSelectImageArray[selectItem.tag]];
            
            [UIView animateWithDuration:0.2 animations:^(void){
                for (NSInteger i = 0; i <  itemArray.count; i++) {
                    if (i > selectItem.tag) {
                        BarItemView *otherItem = ((BarItemView *)itemArray[i]);
                        otherItem.frame = CGRectMake(otherItem.frame.origin.x - itemWidth / 3 * 2, 0, otherItem.frame.size.width, otherItem.frame.size.height);
                    }
                    
                    if (i > Self.tag) {
                        BarItemView *otherItem = ((BarItemView *)itemArray[i]);
                        otherItem.frame = CGRectMake(otherItem.frame.origin.x + itemWidth / 3 * 2, 0, otherItem.frame.size.width, otherItem.frame.size.height);
                    }
                }
                
                Self.frame = CGRectMake(Self.frame.origin.x, Self.frame.origin.y, itemWidth, Self.frame.size.height);
                selectItem.frame = CGRectMake(selectItem.frame.origin.x, selectItem.frame.origin.y, itemWidth / 3, selectItem.frame.size.height);
            } completion:^(BOOL finished){
                selectIndex = (int)Self.tag;
                Self.isSelect = YES;
                selectItem.isSelect = NO;
            }];
        }
    };
}

/////最后一个按钮是不是和其它的按钮不在一边,默认为NO
//-(void)ifLastButtonAtOtherBorder:(BOOL)isAtOtherBorder {
//    isLastAtOther = isAtOtherBorder;
////    if (isAtOtherBorder == YES) {
////        
////    } else {
////        
////    }
//}
//
/////增加按钮
//-(void)addButtons {
//    buttonArray = [[NSMutableArray alloc] init ];
//    for (NSInteger i = 0; i < buttonsCount; i++) {
//        UIButton *button = [UIButton new];
//        button.backgroundColor = [UIColor whiteColor];
//        if (i == 0) {
//            [button setTitle:notSelectImageArray[i] forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:selectImageArray[i]] forState:UIControlStateNormal];
//        } else {
//            [button setImage:[UIImage imageNamed:notSelectImageArray[i]] forState:UIControlStateNormal];
//        }
//        
//        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        button.tag = i;
//        [buttonArray addObject:button];
//        [self addSubview:button];
//        
//        if (i == 0) {
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.mas_top).offset(0);
//                make.bottom.equalTo(self.mas_bottom).offset(0);
//                make.left.equalTo(self.mas_left).offset(10);
//                make.width.mas_equalTo(buttonWidth);
//            }];
//        } else if (i == buttonsCount - 1 && isLastAtOther == YES) {
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.mas_top).offset(0);
//                make.bottom.equalTo(self.mas_bottom).offset(0);
//                make.right.equalTo(self.mas_right).offset(0);
//                make.width.mas_equalTo(buttonWidth / 2);
//            }];
//        } else {
//            UIButton * beforeButton = (UIButton *)buttonArray[i-1];
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.mas_top).offset(0);
//                make.bottom.equalTo(self.mas_bottom).offset(0);
//                make.left.equalTo(beforeButton.mas_right).offset(10);
//                make.width.mas_equalTo(buttonWidth / 2);
//            }];
//        }
//        
//        [button addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//}
//
/////button 的点击事件
//-(void)tapButtonAction:(UIButton *)button {
//    NSLog(@"%s", __FUNCTION__);
//    void (^myBlock)() = ^() {};
//    
//    if (selectIndex != button.tag) {
//        myBlock = actionArray[button.tag];
//
//        [button setTitle:notSelectImageArray[button.tag] forState:UIControlStateNormal];
//        [button  setImage:[UIImage imageNamed:selectImageArray[button.tag]] forState:UIControlStateNormal];
//        
//        [buttonArray[selectIndex] setTitle:NULL forState:UIControlStateNormal];
//        [buttonArray[selectIndex] setImage:[UIImage imageNamed:notSelectImageArray[selectIndex]]forState:UIControlStateNormal];
//
//        [UIView animateWithDuration:0.5 animations:^(void){
//            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, buttonWidth, button.frame.size.height);
//            ((UIButton *)buttonArray[selectIndex]).frame = CGRectMake(((UIButton *)buttonArray[selectIndex]).frame.origin.x, ((UIButton *)buttonArray[selectIndex]).frame.origin.y, buttonWidth / 2, ((UIButton *)buttonArray[selectIndex]).frame.size.height);
//        }];
//        
//        selectIndex = button.tag;
//    }
//    
////    [button setTitle:notSelectImageArray[button.tag] forState:UIControlStateNormal];
////    [button  setImage:[UIImage imageNamed:selectImageArray[button.tag]] forState:UIControlStateNormal];
//    
////    for (NSInteger i = 0; i < buttonArray.count; i++) {
////        if (button.tag != ((UIButton *)buttonArray[i]).tag) {
////            [((UIButton *)buttonArray[i]) setTitle:NULL forState:UIControlStateNormal];
////            [((UIButton *)buttonArray[i]) setImage:[UIImage imageNamed:notSelectImageArray[i]]forState:UIControlStateNormal];
////        }
////    }
//    
//    myBlock();
//}

@end
