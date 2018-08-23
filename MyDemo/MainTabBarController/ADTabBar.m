//
//  ADTabBar.m
//  TabBarDemo
//
//  Created by hztuen on 17/3/21.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "ADTabBar.h"

@interface ADTabBar ()

@property (nonatomic, strong) UIButton *centerBtn;

@end

@implementation ADTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

//重写方法，调整tabbar中包含的5个按钮的位置
- (void)layoutSubviews {

    [super layoutSubviews];
    
    //设置其他tabBarItem的位置和尺寸
    self.seleItem = (ADTabBarItem *)self.selectedItem;
    CGFloat tabBarButtonW = self.bounds.size.width / self.dataSource.count;
    CGFloat buttonIndex = 0;
    //遍历tabBar中的所有子视图
    //只有当遍历到的子视图的类型是UITabBarButton时，才代表找到的其他按钮，调整位置即可
    for (UIView *child in self.subviews) {
        //获取UITabBarButton的类型描述信息
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            CGRect frame = child.frame;
            frame.size.width = tabBarButtonW;
            frame.origin.x = tabBarButtonW * buttonIndex;
            child.frame = frame;
            buttonIndex++;
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
