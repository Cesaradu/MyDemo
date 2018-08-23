//
//  DetailViewController.h
//  Demo
//
//  Created by hztuen on 2017/6/8.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailViewController : BaseViewController <UINavigationControllerDelegate>

@property (nonatomic, assign) NSInteger index;//点击第几张
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIImageView *topImageView;//顶部图片
@property (nonatomic, strong) UIView *titleView;//标题视图


@end
