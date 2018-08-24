//
//  ADLoadingView.h
//  MyDemo
//
//  Created by Adu on 2018/8/24.
//  Copyright © 2018年 Cesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADLoadingView : UIView

//开始动画
- (void)starAnimation;

//停止动画
- (void)stopAnimation;

//一次动画所持续时长 默认2秒
@property (nonatomic, assign) NSTimeInterval duration;

//线条颜色
@property (nonatomic, strong) UIColor *strokeColor;

@end
