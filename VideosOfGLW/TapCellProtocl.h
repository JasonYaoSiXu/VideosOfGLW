//
//  TapCellProtocl.h
//  VideosOfGLW
//
//  Created by yaosixu on 16/9/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

@protocol TapCellProtocl <NSObject>
-(void)tapRect:(CGPoint)cellOrigin infoRect:(CGRect)rect;
@end