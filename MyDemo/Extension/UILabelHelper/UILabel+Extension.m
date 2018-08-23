//
//  UILabel+Extension.m
//  OKSheng
//
//  Created by hztuen on 17/3/20.
//  Copyright © 2017年 hztuen. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

//创建label，位置自己写
+ (UILabel *)labelWithColor:(NSString *)color AndFont:(CGFloat)font AndAlignment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithHexString:color alpha:1.0];
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = alignment;
    return label;
}

//创建label，带标题，位置自己写
+ (UILabel *)labelWithTitle:(NSString *)title AndColor:(NSString *)color AndFont:(CGFloat)font AndAlignment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = [UIColor colorWithHexString:color alpha:1.0];
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = alignment;
    return label;
}

//动态计算label高度
+ (CGFloat)getSpaceLabelHeight:(NSString *)str withWidth:(CGFloat)width {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}


@end
