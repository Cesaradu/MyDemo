//
//  PaletteViewController.m
//  Demo
//
//  Created by hztuen on 2017/6/30.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "PaletteViewController.h"
#import "SignatureView.h"

@interface PaletteViewController ()

@property (nonatomic, strong) SignatureView *signatureView;

@end

@implementation PaletteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
}

- (void)buildUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/4-30, 100, 60, 40)];
    [button1 setTitle:@"生成" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor lightGrayColor];
    [button1 addTarget:self action:@selector(generateSignature)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/4*3 - 30, 100, 60, 40)];
    [button2 setTitle:@"清除" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor lightGrayColor];
    [button2 addTarget:self action:@selector(clearSignature)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    self.signatureView = [[SignatureView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, ScreenHeight - 200)];
    self.signatureView.backgroundColor = [UIColor grayColor];
    self.signatureView.pathColor = [UIColor redColor];
    self.signatureView.pathWidth = 5;
    [self.view addSubview:self.signatureView];
    
}

- (void)generateSignature {
    if (self.generateClickBlock) {
        self.generateClickBlock([self imageWithUIView:self.signatureView]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImage*) imageWithUIView:(UIView*) view {
    
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tImage;
}


- (void)clearSignature {
    [self.signatureView clearSignature];
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
