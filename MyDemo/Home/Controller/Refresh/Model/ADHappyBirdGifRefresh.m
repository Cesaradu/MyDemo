//
//  ADHappyBirdGifRefresh.m
//  HappBird
//
//  Created by Oliver on 2017/9/8.
//  Copyright © 2017年 三友智云. All rights reserved.
//

#import "ADHappyBirdGifRefresh.h"

@implementation ADHappyBirdGifRefresh

#pragma mark - 重写方法
- (void)prepare {
    [super prepare];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i<=18; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"happybird%d", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置正在刷新状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateRefreshing];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (int i = 13; i<=18; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"happybird%d", i]];
//        [refreshingImages addObject:image];
//    }
    [self setImages:idleImages forState:MJRefreshStatePulling];
    
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    self.stateLabel.hidden = YES;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
