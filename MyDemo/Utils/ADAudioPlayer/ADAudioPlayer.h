//
//  ADAudioPlayer.h
//  Happybird_watch
//
//  Created by Oliver on 2018/4/23.
//  Copyright © 2018年 Oliver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface ADAudioPlayer : NSObject
@property (nonatomic, copy) void (^playerDelegate)(CGFloat value, CGFloat totalTime, NSString *timeStr, NSString *totalStr);

+ (instancetype)sharePlayer;
- (void)playWithName: (NSString *)name;
- (void)playWithValue: (CGFloat) value;
- (void)pause;
- (void)finishPlay;

@end
