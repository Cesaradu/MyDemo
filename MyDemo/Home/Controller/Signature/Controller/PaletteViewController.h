//
//  PaletteViewController.h
//  Demo
//
//  Created by hztuen on 2017/6/30.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "BaseViewController.h"

@interface PaletteViewController : BaseViewController

@property (nonatomic, copy) void (^generateClickBlock) (UIImage *image);//点击生成

@end
