//
//  MoreFunctionCell.h
//  MyDemo
//
//  Created by Adu on 2018/8/29.
//  Copyright © 2018年 Cesar. All rights reserved.
//

#import "BaseCollectionCell.h"

@interface MoreFunctionCell : BaseCollectionCell

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *title;

- (void)loadData:(NSDictionary *)data;

- (void)downSize;
- (void)resize;

@end
