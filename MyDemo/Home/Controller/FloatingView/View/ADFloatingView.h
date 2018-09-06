//
//  FloatingView.h
//  MyDemo
//
//  Created by Adu on 2018/9/6.
//  Copyright © 2018年 Cesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADFloatingView : UIView

//气泡的缩放比例，默认1
@property (nonatomic, assign) CGFloat circleScale;

//是否自动浮动
@property (nonatomic, assign) BOOL isAutoFloating;

//气泡数量
@property (nonatomic, assign) int circleCount;

@end
