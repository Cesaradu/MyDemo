//
//  ADSwitch.h
//  Demo
//
//  Created by Oliver on 2018/2/9.
//  Copyright © 2018年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ADSwitchDidSelectedBlock)(BOOL isOn);

@interface ADSwitch : UIView

@property (nonatomic, strong) UIColor *onColor; //开的颜色

@property (nonatomic, strong) UIColor *offColor; //关的颜色

@property (nonatomic, strong) UIColor *headColor; //圆圈颜色

@property (nonatomic, assign) BOOL isOn;

-(void)setADSwitchDidSelectedBlock:(ADSwitchDidSelectedBlock)block;

@end
