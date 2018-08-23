//
//  WaterFlowCell.m
//  Demo
//
//  Created by hztuen on 2017/6/27.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "WaterFlowCell.h"

@implementation WaterFlowCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        
        self.image = [[UIImageView alloc] init];
        self.image.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.image];
        [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        self.label = [[UILabel alloc] init];
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:16];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.backgroundColor = [UIColor blackColor];
        self.label.alpha = 0.5;
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(30);
        }];
        
    }
    return self;
}

- (void)setModel:(WaterFlowModel *)model {
    _model = model;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.label.text = model.price;
}

@end
