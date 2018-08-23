//
//  WaterFlowCell.h
//  Demo
//
//  Created by hztuen on 2017/6/27.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFlowModel.h"

@interface WaterFlowCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) WaterFlowModel *model;

@end
