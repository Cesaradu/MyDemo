//
//  FloatingView.m
//  MyDemo
//
//  Created by Adu on 2018/9/6.
//  Copyright © 2018年 Cesar. All rights reserved.
//

#import "ADFloatingView.h"
#import "ADMatrix.h"
#import <CoreMotion/CoreMotion.h>

#define ADAnmationDuration      0.3

@interface ADFloatingView () {
    ADPoint normalDirection;
    CGPoint lastPoint;
    CMDeviceMotion *lastMotion;
    CGFloat velocity;//速度
    UIPanGestureRecognizer *panGesture;//滑动手势
    CADisplayLink *timer;
    CADisplayLink *inertia; //惯性
}

@property (nonatomic, strong) NSMutableArray *circleArray;
@property (nonatomic, strong) NSMutableArray *coordinate;
@property (nonatomic, strong) NSMutableArray *coordinateStack;
@property (nonatomic, assign) BOOL isMoving;
@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation ADFloatingView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.circleScale = 1.0f;
    
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self addGestureRecognizer:panGesture];
    
    inertia = [CADisplayLink displayLinkWithTarget:self selector:@selector(inertiaStep)];
    [inertia addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    self.coordinateStack = [NSMutableArray array];
    self.circleArray = [NSMutableArray array];
    
    [self setIsAutoFloating:true];
}

#pragma mark - gesture selector
- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        lastPoint = [gesture locationInView:self];
        [self timerStop];
        [self inertiaStop];
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint current = [gesture locationInView:self];
        ADPoint direction = ADPointMake(lastPoint.y - current.y, current.x - lastPoint.x, 0);
        CGFloat distance = sqrt(direction.x * direction.x + direction.y * direction.y) * 2;
        CGFloat angle = distance / (self.width / 2.);
        
        for (NSInteger i = 0; i < self.circleArray.count; i ++) {
            [self updateFrameOfPoint:i direction:direction andAngle:angle];
        }
        normalDirection = direction;
        lastPoint = current;
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint velocityP = [gesture velocityInView:self];
        velocity = sqrt(velocityP.x * velocityP.x + velocityP.y * velocityP.y);
        [self inertiaStart];
    }
}

- (void)inertiaStep {
    if (velocity <= 0) {
        [self inertiaStop];
    } else {
        velocity -= 150.;
        CGFloat angle = velocity / self.width * 2. * inertia.duration;
        for (NSInteger i = 0; i < self.circleArray.count; i ++) {
            [self updateFrameOfPoint:i direction:normalDirection andAngle:angle];
        }
    }
}

- (void)updateFrameOfPoint:(NSInteger)index direction:(ADPoint)direction andAngle:(CGFloat)angle {
    NSValue *value = [self.coordinate objectAtIndex:index];
    ADPoint point;
    [value getValue:&point];
    
    ADPoint rPoint = ADPointMakeRotation(point, direction, angle);
    value = [NSValue value:&rPoint withObjCType:@encode(ADPoint)];
    self.coordinate[index] = value;
    
    [self setTagOfPoint:rPoint andIndex:index];
}

- (void)setTagOfPoint:(ADPoint)point andIndex:(NSInteger)index {
    ADPostion p = [self actualPostionOf:point];
    
    UIView *view = [self.circleArray objectAtIndex:index];
    view.center = CGPointMake(p.x, p.y);
    
    CGFloat transform = p.z;
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, transform * self.circleScale, transform * self.circleScale);
    view.layer.zPosition = transform;
    view.alpha = transform;
    view.userInteractionEnabled = NO;
}

- (ADPostion)actualPostionOf:(ADPoint)point {
    return ADPointMake((point.x + 1) * (self.width / 2.0), (point.y + 1) * (self.width / 2.0), (point.z + 2)/3.0);
}

- (void)_internalAnimateWithItems:(NSArray <UIView *>*)items {
    self.coordinate = [[NSMutableArray alloc] init];
    
    CGFloat p1 = M_PI * (3 - sqrt(5));
    CGFloat p2 = 2. / self.circleArray.count;
    
    for (NSInteger i = 0; i < self.circleArray.count; i ++) {
        CGFloat y = i * p2 - 1 + (p2 / 2);
        CGFloat r = sqrt(1 - y * y);
        CGFloat p3 = i * p1;
        CGFloat x = cos(p3) * r;
        CGFloat z = sin(p3) * r;
        
        ADPoint point = ADPointMake(x, y, z);
        NSValue *value = [NSValue value:&point withObjCType:@encode(ADPoint)];
        [self.coordinate addObject:value];
    }
    
    for (NSInteger i = 0; i < self.circleArray.count; i ++) {
        NSValue *value = self.coordinate[i];
        ADPoint point;
        [value getValue:&point];
        
        UIView *view = self.circleArray[i];
        [self addSubview:view];
        view.alpha = 0.0;
        view.center = CGPointMake(self.frame.size.width / 2., self.frame.size.height / 2.);
        view.transform = CGAffineTransformMakeScale(0.2, 0.2);
    }
    
    [UIView animateWithDuration:ADAnmationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        for (NSInteger i = 0; i < self.circleArray.count; i ++) {
            NSValue *value = [self.coordinate objectAtIndex:i];
            ADPoint point;
            [value getValue:&point];
            [self setTagOfPoint:point andIndex:i];
        }
    } completion:^(BOOL finished) {
        self->normalDirection = ADPointMake(arc4random() % 10 - 5, arc4random() % 10 - 5, 0);
        self.isMoving = false;
    }];
}


- (void)timerStart {
    timer.paused = NO;
}

- (void)timerStop {
    timer.paused = YES;
}

- (void)inertiaStart {
    [self timerStop];
    inertia.paused = NO;
}

- (void)inertiaStop {
    [self timerStart];
    inertia.paused = YES;
}

- (void)setIsMoving:(BOOL)isMoving {
    _isMoving = isMoving;
    panGesture.enabled = !isMoving;
    self.userInteractionEnabled = !isMoving;
    if (isMoving) {
        [self timerStop];
    } else {
        [self timerStart];
    }
}

- (void)setIsAutoFloating:(BOOL)isAutoFloating {
    _isAutoFloating = isAutoFloating;
    if (isAutoFloating) {
        if (!timer) {
            timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(autoFloating)];
            [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        }
    } else {
        [timer invalidate];
        timer = nil;
    }
}

- (void)autoFloating {
    if (self.isMoving || panGesture.state == UIGestureRecognizerStateChanged) {
        return;
    }
    for (NSInteger i = 0; i < self.circleArray.count; i ++) {
        [self updateFrameOfPoint:i direction:normalDirection andAngle:0.002];
    }
}

- (void)setCircleCount:(int)circleCount {
    _circleCount = circleCount;
    for (int i = 0; i < circleCount; i ++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width)];
        view.backgroundColor = [UIColor colorWithHexString:@"FF7A93" alpha:(float)(rand() % 100) / 100];
        view.layer.cornerRadius = self.width/2;
        [self.circleArray addObject:view];
    }
    [self _internalAnimateWithItems:self.circleArray];
}

- (void)dealloc {
    [self setIsAutoFloating:false];
    [inertia invalidate];
    inertia = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
