//
//  FloatingViewController.m
//  MyDemo
//
//  Created by Adu on 2018/9/6.
//  Copyright © 2018年 Cesar. All rights reserved.
//

#import "FloatingViewController.h"
#import "ADFloatingView.h"

@interface FloatingViewController ()

@property (nonatomic, strong) ADFloatingView *floatingView;

@end

@implementation FloatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self buildUI];
}

- (void)initData {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"浮动动画";
}

- (void)buildUI {
    self.floatingView = [[ADFloatingView alloc] initWithFrame:CGRectMake(0, (ScreenHeight - ScreenWidth)/2, ScreenWidth, ScreenWidth)];
    self.floatingView.backgroundColor = [UIColor whiteColor];
    self.floatingView.circleCount = 8;
    self.floatingView.isAutoFloating = YES;
    self.floatingView.circleScale = 0.6;
//    self.floatingView.clipsToBounds = YES;
    [self.view addSubview:self.floatingView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
