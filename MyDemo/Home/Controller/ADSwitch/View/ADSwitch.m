//
//  ADSwitch.m
//  Demo
//
//  Created by Oliver on 2018/2/9.
//  Copyright © 2018年 cesar. All rights reserved.
//

#import "ADSwitch.h"

/**
 *  Animation keys
 */
NSString * const kHeadLayerPositionAnimationKey = @"kHeadLayerPositionAnimationKey";
NSString * const kHeadLayerScaleAnimationKey = @"kHeadLayerScaleAnimationKey";
NSString * const kBackgroundAnimationKey = @"BackgroundAnimationKey";


@interface ADSwitch () <CAAnimationDelegate>
{
    CGFloat _sideOfHead;
    
    CGFloat _moveDistance;
    
    BOOL isAnimating;
    
    ADSwitchDidSelectedBlock _adSwitchDidSelectedBlock;
    
    CGFloat _kWidthOfPadding;
}

@property (nonatomic,strong)CAShapeLayer * headLayer;

@end

const CGFloat kAnimationDuration = 0.75f;

@implementation ADSwitch

#pragma mark  set method
- (void)setOnColor:(UIColor *)onColor {
    _onColor = onColor;
    if (_isOn) {
        self.backgroundColor = _onColor;
    }
}

- (void)setOffColor:(UIColor *)offColor {
    _offColor = offColor;
    if (!_isOn) {
        self.backgroundColor = _offColor;
    }
}

- (void)setHeadColor:(UIColor *)headColor {
    _headColor = headColor;
    self.headLayer.fillColor = _headColor.CGColor;
}

- (void)setIsOn:(BOOL)isOn {
    _isOn = isOn;
    self.backgroundColor = _isOn?_onColor:_offColor;
}

- (CALayer *)headLayer {
    if (!_headLayer) {
        _sideOfHead = self.frame.size.height - 2 * _kWidthOfPadding;
        
        _headLayer = [CAShapeLayer layer];
        _headLayer.frame = CGRectMake(_kWidthOfPadding, _kWidthOfPadding, _sideOfHead, _sideOfHead);
        UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:_headLayer.bounds];
        _headLayer.path = path.CGPath;
        
        [self.layer addSublayer:_headLayer];
    }
    return _headLayer;
}

- (void)setADSwitchDidSelectedBlock:(ADSwitchDidSelectedBlock)block {
    _adSwitchDidSelectedBlock = block;
}

#pragma mark
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        NSAssert(frame.size.width > frame.size.height,@"width must more than height");
        _moveDistance = self.frame.size.width - self.frame.size.height;
        
        [self initLBWSwitch];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchTouched:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)initLBWSwitch {
    isAnimating = NO;
    _isOn = NO;
    self.layer.cornerRadius = self.frame.size.height/2;
    _kWidthOfPadding = self.frame.size.width/3;
    
    self.onColor = [UIColor colorWithRed:73/255.0 green:182/255.0 blue:235/255.0 alpha:1.f];
    self.offColor = [UIColor colorWithRed:211/255.0 green:207/255.0 blue:207/255.0 alpha:1.f];
    self.headColor = [UIColor whiteColor];
    
    self.headLayer.masksToBounds = YES;
    
}

#pragma mark   Tap GestureRecognizer
- (void)switchTouched:(UITapGestureRecognizer *)tap {
    if (isAnimating) {
        return;
    }
    
    isAnimating = YES;
    
    CABasicAnimation *headLayerPositionAnimation = [self animationForHeadLayerWithBeginPosition:self.headLayer.position endPosition:CGPointMake(_isOn?self.headLayer.position.x - _moveDistance:self.headLayer.position.x + _moveDistance, self.headLayer.position.y)];
    headLayerPositionAnimation.delegate = self;
    [self.headLayer addAnimation:headLayerPositionAnimation forKey:kHeadLayerPositionAnimationKey];
    
    CABasicAnimation *headLayerScaleAnimation = [self animationForHeadLayerWithBeginSize:_isOn?2:1 endSize:_isOn?1:2];
    [self.headLayer addAnimation:headLayerScaleAnimation forKey:kHeadLayerScaleAnimationKey];
    
    CABasicAnimation * backgroundAnimation = [self animationForBackgroundColorWithBeginColor:_isOn?_onColor:_offColor endColor:_isOn?_offColor:_onColor];
    [self.layer addAnimation:backgroundAnimation forKey:kBackgroundAnimationKey];
}

#pragma mark   animation
- (CABasicAnimation *)animationForHeadLayerWithBeginPosition:(CGPoint)beginPosition endPosition:(CGPoint)endPosition {
    CABasicAnimation * headLayerAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    headLayerAnimation.fromValue = [NSValue valueWithCGPoint:beginPosition];
    headLayerAnimation.toValue = [NSValue valueWithCGPoint:endPosition];
    headLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    headLayerAnimation.duration = kAnimationDuration * 2 /3;
    headLayerAnimation.removedOnCompletion = NO;
    headLayerAnimation.fillMode = kCAFillModeForwards;
    
    return headLayerAnimation;
}

- (CABasicAnimation *)animationForHeadLayerWithBeginSize:(CGFloat)beginFloat endSize:(CGFloat)endFloat {
    CABasicAnimation * headLayerAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    headLayerAnimation.fromValue = [NSNumber numberWithFloat:beginFloat];
    headLayerAnimation.toValue = [NSNumber numberWithFloat:endFloat];
    headLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    headLayerAnimation.duration = kAnimationDuration * 2 /3;
    headLayerAnimation.removedOnCompletion = NO;
    headLayerAnimation.fillMode = kCAFillModeForwards;
    
    return headLayerAnimation;
}

- (CABasicAnimation *)animationForBackgroundColorWithBeginColor:(UIColor *)beginColor endColor:(UIColor *)endColor {
    CABasicAnimation * backgroundColorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColorAnimation.fromValue = (id)beginColor.CGColor;
    backgroundColorAnimation.toValue = (id)endColor.CGColor;
    backgroundColorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    backgroundColorAnimation.duration = kAnimationDuration / 3 * 2;
    backgroundColorAnimation.removedOnCompletion = NO;
    backgroundColorAnimation.fillMode = kCAFillModeForwards;
    
    return backgroundColorAnimation;
}

#pragma mark   Animation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        isAnimating = NO;
        _headLayer.position = CGPointMake(_isOn?_headLayer.position.x - _moveDistance : _headLayer.position.x + _moveDistance, _headLayer.position.y);
        self.isOn = !self.isOn;
        if (_adSwitchDidSelectedBlock)
        {
            _adSwitchDidSelectedBlock(_isOn);
        }
        return;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
