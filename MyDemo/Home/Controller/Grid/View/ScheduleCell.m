//
//  ScheduleCell.m
//  Demo
//
//  Created by Oliver on 2018/2/11.
//  Copyright © 2018年 cesar. All rights reserved.
//

#import "ScheduleCell.h"

@implementation ScheduleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.scheduleLabel = [UILabel labelWithColor:MainColor AndFont:[self SuitFont:13] AndAlignment:NSTextAlignmentCenter];
        [self addSubview:self.scheduleLabel];
        [self.scheduleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_centerY).offset([self Suit:-2]);
        }];
        
        self.timeLabel = [UILabel labelWithColor:MainColor AndFont:[self SuitFont:12] AndAlignment:NSTextAlignmentCenter];
        [self addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_centerY).offset([self Suit:3]);
        }];
    }
    return self;
}

- (void)loadCell:(NSString *)string {
    NSArray *array = [string componentsSeparatedByString:@"节"];
    self.scheduleLabel.text = [NSString stringWithFormat:@"%@节", array[0]];
    self.timeLabel.text = array[1];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
