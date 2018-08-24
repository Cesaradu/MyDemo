//
//  LoadingViewController.m
//  MyDemo
//
//  Created by Adu on 2018/8/24.
//  Copyright © 2018年 Cesar. All rights reserved.
//

#import "LoadingViewController.h"
#import "ADLoadingView.h"

@interface LoadingViewController ()

@property (nonatomic, strong) ADLoadingView *loadingView;

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.loadingView  = [[ADLoadingView alloc] initWithFrame:CGRectMake(ScreenWidth/2 - [self Suit:15], ScreenHeight/2 - [self Suit:15], [self Suit:30], [self Suit:30])];
    self.loadingView.strokeColor = [UIColor orangeColor];
    [self.loadingView starAnimation];
    [self.view addSubview:self.loadingView];
}

- (void)dealloc {
    [self.loadingView stopAnimation];
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
