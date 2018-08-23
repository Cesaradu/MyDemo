//
//  CardView.m
//  Demo
//
//  Created by hztuen on 2017/5/24.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "CardView.h"
#import "UIView+Rotate.h"

@interface CardView ()

//topView子视图
@property (nonatomic, strong) UILabel *startCityLabel;
@property (nonatomic, strong) UILabel *destinationCityLabel;
@property (nonatomic, strong) UILabel *shortStartCityLabel;
@property (nonatomic, strong) UILabel *shortDestinationCityLabel;
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UILabel *arriveTimeLabel;

//middleView子视图
@property (nonatomic, strong) UILabel *terminalLabel;
@property (nonatomic, strong) UILabel *gateLabel;
@property (nonatomic, strong) UILabel *boardingTimeLabel;

//bottomView子视图
@property (nonatomic, strong) UIImageView *lineImage;
@property (nonatomic, strong) UIImageView *codeImage;
@property (nonatomic, strong) UILabel *passengerLabel;
@property (nonatomic, strong) UILabel *passenger;
@property (nonatomic, strong) UILabel *seatLabel;
@property (nonatomic, strong) UILabel *seat;


@end

@implementation CardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    
        [self buildTopView];
        [self buildMiddleView];
        [self buildBottomView];
        
    }
    return self;
}

- (void)buildTopView {
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = [UIColor colorWithHexString:@"F7F8FA" alpha:1.0];
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(240);
    }];
    
    //飞机
    UIImageView *planeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plane"]];
    [self.topView addSubview:planeImage];
    [planeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView.mas_centerX);
        make.centerY.equalTo(self.topView.mas_centerY);
        make.width.height.mas_equalTo(33);
    }];
    
    //4个点
    UIImageView *leftFourPoint = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fourPoint"]];
    [self.topView addSubview:leftFourPoint];
    [leftFourPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(planeImage.mas_centerY);
        make.right.equalTo(planeImage.mas_left).offset(-10);
    }];
    
    UIImageView *rightFourPoint = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fourPoint"]];
    [self.topView addSubview:rightFourPoint];
    [rightFourPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(planeImage.mas_centerY);
        make.left.equalTo(planeImage.mas_right).offset(10);
    }];
    
    //出发城市、出发城市简称、出发时间
    self.shortStartCityLabel = [UILabel labelWithTitle:@"SFO" AndColor:@"515151" AndFont:50 AndAlignment:NSTextAlignmentCenter];
    [self.topView addSubview:self.shortStartCityLabel];
    [self.shortStartCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(planeImage.mas_centerY);
        make.right.equalTo(leftFourPoint.mas_left).offset(-10);
    }];
    
    self.startCityLabel = [UILabel labelWithTitle:@"SAN FRANCISCO" AndColor:@"8a8a8a" AndFont:13 AndAlignment:NSTextAlignmentCenter];
    [self.topView addSubview:self.startCityLabel];
    [self.startCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shortStartCityLabel.mas_centerX);
        make.bottom.equalTo(self.shortStartCityLabel.mas_top).offset(-10);
    }];
    
    self.startTimeLabel = [UILabel labelWithTitle:@"4:00PM" AndColor:@"515151" AndFont:16 AndAlignment:NSTextAlignmentCenter];
    [self.topView addSubview:self.startTimeLabel];
    [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shortStartCityLabel.mas_centerX);
        make.top.equalTo(self.shortStartCityLabel.mas_bottom).offset(10);
    }];
    
    //目的地城市、目的地城市简称、到达时间
    self.shortDestinationCityLabel = [UILabel labelWithTitle:@"LHR" AndColor:@"515151" AndFont:50 AndAlignment:NSTextAlignmentCenter];
    [self.topView addSubview:self.shortDestinationCityLabel];
    [self.shortDestinationCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(planeImage.mas_centerY);
        make.left.equalTo(rightFourPoint.mas_right).offset(10);
    }];
    
    self.destinationCityLabel = [UILabel labelWithTitle:@"LONDON" AndColor:@"8a8a8a" AndFont:13 AndAlignment:NSTextAlignmentCenter];
    [self.topView addSubview:self.destinationCityLabel];
    [self.destinationCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shortDestinationCityLabel.mas_centerX);
        make.bottom.equalTo(self.shortDestinationCityLabel.mas_top).offset(-10);
    }];
    
    self.arriveTimeLabel = [UILabel labelWithTitle:@"4:00PM" AndColor:@"515151" AndFont:16 AndAlignment:NSTextAlignmentCenter];
    [self.topView addSubview:self.arriveTimeLabel];
    [self.arriveTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shortDestinationCityLabel.mas_centerX);
        make.top.equalTo(self.shortDestinationCityLabel.mas_bottom).offset(10);
    }];
}

- (void)buildMiddleView {
    self.middleView = [[UIView alloc] init];
    self.middleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.middleView];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(120);
    }];
    
    UILabel *gate = [UILabel labelWithTitle:@"GATE" AndColor:@"8a8a8a" AndFont:13 AndAlignment:NSTextAlignmentCenter];
    [self.middleView addSubview:gate];
    [gate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.middleView.mas_centerX);
        make.bottom.equalTo(self.middleView.mas_centerY).offset(-3);
        make.width.mas_equalTo(ScreenWidth/3);
    }];
    
    self.gateLabel = [UILabel labelWithTitle:@"22" AndColor:@"515151" AndFont:18 AndAlignment:NSTextAlignmentCenter];
    [self.middleView addSubview:self.gateLabel];
    [self.gateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(gate.mas_centerX);
        make.top.equalTo(self.middleView.mas_centerY).offset(3);
        make.width.mas_equalTo(ScreenWidth/3);
    }];
    
    UILabel *terminal = [UILabel labelWithTitle:@"TERMINAL" AndColor:@"8a8a8a" AndFont:13 AndAlignment:NSTextAlignmentCenter];
    [self.middleView addSubview:terminal];
    [terminal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleView.mas_left);
        make.right.equalTo(gate.mas_left);
        make.centerY.equalTo(gate.mas_centerY);
    }];
    
    self.terminalLabel = [UILabel labelWithTitle:@"B" AndColor:@"515151" AndFont:18 AndAlignment:NSTextAlignmentCenter];
    [self.middleView addSubview:self.terminalLabel];
    [self.terminalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(terminal.mas_centerX);
        make.top.equalTo(self.middleView.mas_centerY).offset(3);
        make.width.mas_equalTo(ScreenWidth/3);
    }];
    
    UILabel *boarding = [UILabel labelWithTitle:@"BOARDING" AndColor:@"8a8a8a" AndFont:13 AndAlignment:NSTextAlignmentCenter];
    [self.middleView addSubview:boarding];
    [boarding mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(gate.mas_right);
        make.right.equalTo(self.middleView.mas_right);
        make.centerY.equalTo(gate.mas_centerY);
    }];
    
    self.boardingTimeLabel = [UILabel labelWithTitle:@"02:58 PM" AndColor:@"515151" AndFont:18 AndAlignment:NSTextAlignmentCenter];
    [self.middleView addSubview:self.boardingTimeLabel];
    [self.boardingTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(boarding.mas_centerX);
        make.top.equalTo(self.middleView.mas_centerY).offset(3);
        make.width.mas_equalTo(ScreenWidth/3);
    }];
    
    UIImageView *circle1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle1"]];
    [self.middleView addSubview:circle1];
    [circle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.middleView.mas_bottom);
        make.left.equalTo(self.middleView.mas_left);
        make.width.height.mas_equalTo(12);
    }];

    UIImageView *circle2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle2"]];
    [self.middleView addSubview:circle2];
    [circle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.middleView.mas_bottom);
        make.right.equalTo(self.middleView.mas_right);
        make.width.height.mas_equalTo(12);
    }];
    
}

- (void)buildBottomView {
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBottomView)];
    [self.bottomView addGestureRecognizer:tap];
    
    UIImageView *circle3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle3"]];
    [self.bottomView addSubview:circle3];
    [circle3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top);
        make.left.equalTo(self.bottomView.mas_left);
        make.width.height.mas_equalTo(12);
    }];
    
    UIImageView *circle4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle4"]];
    [self.bottomView addSubview:circle4];
    [circle4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top);
        make.right.equalTo(self.bottomView.mas_right);
        make.width.height.mas_equalTo(12);
    }];
    
    //虚线
    self.lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, ScreenWidth-24-30, 5)];
    self.lineImage.backgroundColor = [UIColor whiteColor];
    self.lineImage.contentMode = UIViewContentModeScaleAspectFit;
    self.lineImage.image = [UIImage imageNamed:@"dotLine"];
    [self.bottomView addSubview:self.lineImage];
    
    self.codeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barCode"]];
    [self.bottomView addSubview:self.codeImage];
    [self.codeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.left.equalTo(self.bottomView.mas_left).offset(30);
        make.width.height.mas_equalTo(120);
    }];
    
    self.passengerLabel = [UILabel labelWithTitle:@"PASSENGER" AndColor:@"8a8a8a" AndFont:14 AndAlignment:NSTextAlignmentCenter];
    [self.bottomView addSubview:self.passengerLabel];
    [self.passengerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeImage.mas_top);
        make.left.equalTo(self.bottomView.mas_centerX);
    }];
    
    self.passenger = [UILabel labelWithTitle:@"César Du" AndColor:@"515151" AndFont:20 AndAlignment:NSTextAlignmentCenter];
    [self.bottomView addSubview:self.passenger];
    [self.passenger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passengerLabel.mas_bottom).offset(5);
        make.left.equalTo(self.bottomView.mas_centerX);
    }];
    
    self.seat = [UILabel labelWithTitle:@"1A" AndColor:@"515151" AndFont:20 AndAlignment:NSTextAlignmentCenter];
    [self.bottomView addSubview:self.seat];
    [self.seat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.codeImage.mas_bottom);
        make.left.equalTo(self.bottomView.mas_centerX);
    }];
    
    self.seatLabel = [UILabel labelWithTitle:@"SEAT" AndColor:@"8a8a8a" AndFont:14 AndAlignment:NSTextAlignmentCenter];
    [self.bottomView addSubview:self.seatLabel];
    [self.seatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.seat.mas_top).offset(-5);
        make.left.equalTo(self.bottomView.mas_centerX);
    }];
}

- (void)clickBottomView {
    //不加这句，再次动画bottomView的高度会变化
//    self.bottomView.frame = CGRectMake(0, 360, ScreenWidth-30, ScreenHeight-30-360+64);
//    self.bottomView.topRotate().rotateX().animationRotate(2,^(BOOL flag){
//        [UIView animateWithDuration:0.7f animations:^{
//            CATransition *animation = [CATransition animation];
//            animation.duration = 0.7f;
//            animation.type = @"pageCurl";
//            animation.subtype = kCATransitionFromLeft;
//            animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
//            [self.bottomView.layer addAnimation:animation forKey:@"animation"];
//        } completion:^(BOOL finished) {
//            self.bottomView.backgroundColor = [UIColor colorWithHexString:@"cdcdcd" alpha:1.0];
//            self.bottomView.userInteractionEnabled = NO;
//            self.lineImage.hidden = YES;
//            self.codeImage.hidden = YES;
//            self.passengerLabel.hidden = YES;
//            self.passenger.hidden = YES;
//            self.seatLabel.hidden = YES;
//            self.seat.hidden = YES;
//        }];
//        
//    });
    
//    [UIView animateWithDuration:0.7f animations:^{
//        CATransition *animation = [CATransition animation];
//        animation.duration = 0.7f;
//        animation.type = @"pageCurl";
//        animation.subtype = kCATransitionFromLeft;
//        animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
//        [self.bottomView.layer addAnimation:animation forKey:@"animation"];
//    } completion:^(BOOL finished) {
//        self.bottomView.backgroundColor = [UIColor colorWithHexString:@"cdcdcd" alpha:1.0];
//        self.bottomView.userInteractionEnabled = NO;
//        self.lineImage.hidden = YES;
//        self.codeImage.hidden = YES;
//        self.passengerLabel.hidden = YES;
//        self.passenger.hidden = YES;
//        self.seatLabel.hidden = YES;
//        self.seat.hidden = YES;
//    }];
}


- (void)loadCardViewWithData:(NSDictionary *)data {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
