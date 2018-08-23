//
//  GridCell.m
//  JHGridViewDemo
//
//  Created by Oliver on 2018/2/11.
//  Copyright © 2018年 徐嘉宏. All rights reserved.
//

#import "GridCell.h"

@implementation GridCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLabel = [[UILabel alloc] initWithFrame:self.frame];
//        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:self.titleLabel];
        
    }
    return self;
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
