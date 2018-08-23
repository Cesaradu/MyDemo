//
//  ScheduleCell.h
//  Demo
//
//  Created by Oliver on 2018/2/11.
//  Copyright © 2018年 cesar. All rights reserved.
//

#import "BaseTableCell.h"

@interface ScheduleCell : BaseTableCell

@property (nonatomic, strong) UILabel *scheduleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

- (void)loadCell:(NSString *)string;

@end
