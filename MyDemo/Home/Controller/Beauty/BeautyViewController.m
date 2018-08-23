//
//  BeautyViewController.m
//  Demo
//
//  Created by hztuen on 2017/7/18.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "BeautyViewController.h"
#import "GPUImageBeautifyFilter.h"

@interface BeautyViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation BeautyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUI];
}


- (void)buildUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-80)];
    self.imageView.image = [UIImage imageNamed:@"image.jpg"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    
    self.buttonArray = [NSMutableArray new];
    NSArray *imageArray = @[@"num1", @"num2", @"num3", @"num4", @"num5"];
    CGFloat buttonWidth = ScreenWidth/5;
    for (int i = 0; i < 5; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*i, CGRectGetMaxY(self.imageView.frame), buttonWidth, 80)];
        button.tag = 1000+i;
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickBeautyButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}


- (void)clickBeautyButton:(UIButton *)sender {
    
    UIImage *inputImage = [UIImage imageNamed:@"image.jpg"];
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:inputImage];
    GPUImageBeautifyFilter *filter = [[GPUImageBeautifyFilter alloc] init];
    filter.level = 0.2 * (sender.tag - 999) - 0.1;
    [filter forceProcessingAtSize:inputImage.size];
    [filter useNextFrameForImageCapture];
    [pic addTarget:filter];
    [pic processImage];
    UIImage *newImage = [filter imageFromCurrentFramebuffer];
    self.imageView.image = newImage;
    
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
