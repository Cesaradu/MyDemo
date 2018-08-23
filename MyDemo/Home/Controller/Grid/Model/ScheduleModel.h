//
//  ScheduleModel.h
//  Demo
//
//  Created by Oliver on 2018/2/11.
//  Copyright © 2018年 cesar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleModel : NSObject

@property (nonatomic, strong) NSString *monday;
@property (nonatomic, strong) NSString *tuesday;
@property (nonatomic, strong) NSString *wednesday;
@property (nonatomic, strong) NSString *thursday;
@property (nonatomic, strong) NSString *friday;

- (instancetype)initWithMondaySchedule:(NSString *)monday TuesdaySchedule:(NSString *)tuesday WednesdaySchedule:(NSString *)wednesday ThursdaySchedule:(NSString *)thursday FridaySchedule:(NSString *)friday;

@end
