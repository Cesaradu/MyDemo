//
//  MoreFunctionCell.m
//  MyDemo
//
//  Created by Adu on 2018/8/29.
//  Copyright © 2018年 Cesar. All rights reserved.
//

#import "MoreFunctionCell.h"

@implementation MoreFunctionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor colorWithHexString:@"ffffff" alpha:1.0];
        self.bgView.layer.cornerRadius = 5;
        self.bgView.layer.shadowRadius = [self Suit:3];
        self.bgView.layer.shadowOffset = CGSizeMake([self Suit:3], [self Suit:3]);
        self.bgView.layer.shadowOpacity = 0.5;
        self.bgView.layer.shadowColor = [UIColor colorWithHexString:@"9a9a9a" alpha:0.4].CGColor;
        //解决圆角+阴影卡顿的问题
        [self.bgView.layer setShouldRasterize:YES];//设置缓存仅用于设置此选项。
        [self.bgView.layer setRasterizationScale:[[UIScreen mainScreen] scale]];//设置对应比例，防止cell出现模糊和锯齿
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
        }];
        
        self.image = [[UIImageView alloc] init];
        self.image.contentMode = UIViewContentModeScaleAspectFit;
        [self.bgView addSubview:self.image];
        [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView.mas_top).offset([self Suit:5]);
            make.centerX.equalTo(self.bgView.mas_centerX);
            make.width.height.mas_equalTo([self Suit:50]);
        }];
        
        self.title = [UILabel labelWithTitle:@"标题" AndColor:@"000000" AndFont:[self SuitFont:15] AndAlignment:NSTextAlignmentCenter];
        self.title.alpha = 0.8;
        [self.bgView addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView.mas_centerX);
            make.top.equalTo(self.image.mas_bottom).offset([self Suit:5]);
        }];
        
        
    }
    return self;
}

- (void)loadData:(NSDictionary *)data {
    self.image.image = [UIImage imageNamed:data[@"imageName"]];
    self.title.text = data[@"titleName"];
}

- (void)downSize {
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.transform = CGAffineTransformMakeScale(0.85, 0.85);
    }];
}

- (void)resize {
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

@end
