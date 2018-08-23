//
//  MotionShadowView.m
//  Happybird_keanxin
//
//  Created by Oliver on 2017/11/27.
//  Copyright © 2017年 happybird. All rights reserved.
//

#import "MotionShadowView.h"

@import CoreMotion;

@interface MotionShadowView ()

@property(nonatomic,strong) UIView *targetView;

@property(nonatomic,strong)CMMotionManager *motionManager;

@property CGFloat originalX;
@property CGFloat originalY;
@property CGFloat x;
@property CGFloat y;

@end

@implementation MotionShadowView

+ (MotionShadowView *)fromView:(UIView *)targetView{
    
    MotionShadowView *newView = [[MotionShadowView alloc] initWithTragetView:targetView];
    return newView;
    
}

- (instancetype)initWithTragetView:(UIView *)targetView {
    
    self = [super initWithFrame:CGRectMake(0, 0, MAXFLOAT, MAXFLOAT)];
    
    self.originalX  = 0;
    self.originalY  = 0;
    self.x          = 0;
    self.y          = 0;
    self.offset     = 30;
    self.speedLevel = 0.4;
    self.backSpeed  = 80;
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:targetView];
    
    self.layer.shadowOffset  = CGSizeMake(0, 0);
    self.layer.shadowColor   = [UIColor redColor].CGColor;
    self.layer.shadowRadius  = 30;
    self.layer.shadowOpacity = 0.8;
    
    self.targetView = targetView;
    
    [self startMotionTraking];
    
    return self;
}

- (void)setOffset:(CGFloat)offset {
    _offset = offset;
}

- (void)startMotionTraking {
    self.motionManager = [CMMotionManager new];
    self.motionManager.gyroUpdateInterval = 0.01;
    NSOperationQueue *q = [NSOperationQueue new];
    if  (self.motionManager.gyroAvailable && ! self.motionManager.gyroActive ) {
        [self.motionManager startGyroUpdatesToQueue:q
                                        withHandler:^(CMGyroData * __nullable gyroData,
                                                      NSError * _Nullable error)
         {
             //            NSLog(@"========================");
             //            NSLog(@"%f",(gyroData.rotationRate.x));
             //            NSLog(@"%f",(gyroData.rotationRate.y));
             //            NSLog(@"%f",(gyroData.rotationRate.z));
             
             if (self.x+gyroData.rotationRate.y*self.speedLevel>self.originalX+self.offset ||
                 self.x+gyroData.rotationRate.y*self.speedLevel<self.originalX-self.offset) {
                 
             } else {
                 self.x+=gyroData.rotationRate.y*self.speedLevel;
             }
             
             self.x = self.x+(self.originalX - self.x)/self.backSpeed;
             
             if (self.y+gyroData.rotationRate.y*self.speedLevel>self.originalY+self.offset ||
                 self.y+gyroData.rotationRate.y*self.speedLevel<self.originalY-self.offset) {
                 
             } else {
                 self.y+=gyroData.rotationRate.x*self.speedLevel;
             }
             self.y = self.y+(self.originalY - self.y)/self.backSpeed;
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.layer.shadowOffset = CGSizeMake(self.x, self.y);
             });
         }];
    }
}

@end

