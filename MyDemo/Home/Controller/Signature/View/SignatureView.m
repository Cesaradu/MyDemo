//
//  SignatureView.m
//  Demo
//
//  Created by hztuen on 2017/6/30.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "SignatureView.h"

@interface SignatureView ()

@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (strong, nonatomic) NSMutableArray *startPoints;
@property (strong, nonatomic) NSMutableArray *points;

@end

@implementation SignatureView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _pathColor = [UIColor blackColor];
        _pathWidth = 5;
        
    }
    return self;
}

//起点
- (NSMutableArray *)startPoints {
    if (_startPoints == nil) {
        _startPoints= [[NSMutableArray alloc] init];
    }
    return _startPoints;
}

- (NSMutableArray*) points {
    if (_points == nil) {
        _points = [[NSMutableArray alloc] init];
    }
    return _points;
}

- (void)setPathColor:(UIColor *)pathColor {
    _pathColor = pathColor;
}

- (void)setPathWidth:(CGFloat)pathWidth {
    _pathWidth = pathWidth;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    for (int j = 0; j < self.startPoints.count; j++) {
        NSMutableArray *points = self.startPoints[j];
        for (int i = 0; i < points.count; i++) {
            CGPoint point = [points[i] CGPointValue];
            if (i == 0) {
                CGContextMoveToPoint(ctx, point.x, point.y);
            } else {
                CGContextAddLineToPoint(ctx, point.x, point.y);
            }
        }
    }
    
    [_pathColor set];
    CGContextSetLineWidth(ctx, _pathWidth);
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);//设置线条拐角
    CGContextSetLineCap(ctx, kCGLineCapRound);//设置连接线的样式
    CGContextStrokePath(ctx);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:touch.view];
    
    NSMutableArray *points = [NSMutableArray array];
    [points addObject:[NSValue  valueWithCGPoint:p]];//结构体转换为对象
    
    [self.startPoints addObject:points];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch=[touches anyObject];
    
    NSMutableArray *points = [self.startPoints lastObject];
    CGPoint point = [touch previousLocationInView:touch.view];
    [points addObject:[NSValue  valueWithCGPoint:point]];//结构体转换为对象
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (UIBezierPath *)bezierPath {
    if (!_bezierPath) {
        _bezierPath = [UIBezierPath bezierPath];
        _bezierPath.lineWidth = 3;
    }
    return _bezierPath;
}

- (void)clearSignature {
    NSLog(@"self.startPoints = %@",self.startPoints);
    if (self.startPoints.count == 0) {
        return;
    }
    [self.startPoints removeAllObjects];
    self.startPoints = nil;
    [self setNeedsDisplay];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
