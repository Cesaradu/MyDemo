//
//  EmptyView.m
//  Happybird_watch
//
//  Created by Oliver on 2018/1/26.
//  Copyright © 2018年 Oliver. All rights reserved.
//

#import "EmptyView.h"

@implementation EmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.emptyImage = [[UIImageView alloc] init];
        self.emptyImage.image = [UIImage imageNamed:@"meiyoushju_icon"];
        [self addSubview:self.emptyImage];
        [self.emptyImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).offset([self Suit:85]);
        }];
        
        self.title = [UILabel labelWithTitle:@"" AndColor:MainColor AndFont:0 AndAlignment:NSTextAlignmentCenter];
        self.title.font = [UIFont boldSystemFontOfSize:[self SuitFont:20]];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.emptyImage.mas_bottom).offset([self Suit:45]);
        }];
        
        self.subTitle = [UILabel labelWithTitle:@"" AndColor:@"" AndFont:[self SuitFont:15] AndAlignment:NSTextAlignmentCenter];
        self.subTitle.textColor = [UIColor colorWithHexString:MainColor alpha:0.8];
        self.subTitle.numberOfLines = 2;
        [self addSubview:self.subTitle];
        [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.title.mas_bottom).offset([self Suit:25]);
        }];
        
        
        
    }
    return self;
}

/**
 适配 给定4.7寸屏尺寸，适配4,5.5,5.8寸屏尺寸
 5.8寸iPhonex 屏宽也是375，适配暂时跟4.7寸一样
 */
- (float)Suit:(float)MySuit {
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(MySuit=MySuit/Suit4Inch):((IS_IPHONE55INCH)?(MySuit=MySuit*Suit55Inch):MySuit);
    return MySuit;
}

/**
 适配 给定4.7寸屏字号，适配4(-1)和5.5(+1)寸屏字号
 */
- (float)SuitFont:(float)font {
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(font=font-1):((IS_IPHONE55INCH)?(font=font+1):font);
    return font;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
