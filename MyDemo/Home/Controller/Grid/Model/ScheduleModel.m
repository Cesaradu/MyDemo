//
//  ScheduleModel.m
//  Demo
//
//  Created by Oliver on 2018/2/11.
//  Copyright © 2018年 cesar. All rights reserved.
//

#import "ScheduleModel.h"

@implementation ScheduleModel

- (instancetype)initWithMondaySchedule:(NSString *)monday TuesdaySchedule:(NSString *)tuesday WednesdaySchedule:(NSString *)wednesday ThursdaySchedule:(NSString *)thursday FridaySchedule:(NSString *)friday {
    if (self = [super init]) {
        _monday = monday;
        _tuesday = tuesday;
        _wednesday = wednesday;
        _thursday = thursday;
        _friday = friday;
    }
    return self;
}

@end
