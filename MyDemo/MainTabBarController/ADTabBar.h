//
//  ADTabBar.h
//  TabBarDemo
//
//  Created by hztuen on 17/3/21.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADTabBarItem.h"

@interface ADTabBar : UITabBar

/**
 数据，主要用于判断有几个BarItem
 */
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, weak) ADTabBarItem *seleItem;

@end
