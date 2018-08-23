//
//  SignatureViewController.m
//  Demo
//
//  Created by hztuen on 2017/6/30.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "SignatureViewController.h"
#import "PaletteViewController.h"

@interface SignatureViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUI];
}

- (void)buildUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2-30, 100, 60, 40)];
    [button1 setTitle:@"去签名" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor lightGrayColor];
    [button1 addTarget:self action:@selector(clickSignatureButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, ScreenHeight-200)];
    self.imageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.imageView];
}

- (void)clickSignatureButton {
    PaletteViewController *paletteVC = [[PaletteViewController alloc] init];
    __weak typeof(self)weakSelf = self;
    paletteVC.generateClickBlock = ^(UIImage *image) {
        weakSelf.imageView.image = image;
    };
    [self.navigationController pushViewController:paletteVC animated:YES];
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
