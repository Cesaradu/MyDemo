//
//  ADSwitchViewController.m
//  Demo
//
//  Created by Oliver on 2018/2/9.
//  Copyright © 2018年 cesar. All rights reserved.
//

#import "ADSwitchViewController.h"
#import "ADSwitch.h"

@interface ADSwitchViewController ()

@end

@implementation ADSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    
    ADSwitch *adswitch = [[ADSwitch alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 120)/2,200 , 80, 40)];
    [adswitch setADSwitchDidSelectedBlock:^(BOOL isOn) {
        if (isOn) {
            NSLog(@"开");
        } else {
            NSLog(@"关");
        }
    }];
    [self.view addSubview:adswitch];
    
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
