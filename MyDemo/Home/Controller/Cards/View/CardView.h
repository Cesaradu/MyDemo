//
//  CardView.h
//  Demo
//
//  Created by hztuen on 2017/5/24.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *bottomView;

- (void)loadCardViewWithData:(NSDictionary *)data;

@end
