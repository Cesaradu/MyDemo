//
//  IDPhotoDetailViewController.m
//  Demo
//
//  Created by hztuen on 2017/7/17.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "IDPhotoDetailViewController.h"

@interface IDPhotoDetailViewController () <UIPrintInteractionControllerDelegate>

@property (nonatomic, strong) UIImageView *singleImage;
@property (nonatomic, strong) UIImageView *allImage;

@end

@implementation IDPhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self buildUI];
    
}

- (void)initData {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)buildUI {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"打印" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.singleImage = [[UIImageView alloc] init];
    [self.singleImage sd_setImageWithURL:[NSURL URLWithString:self.singleImageArray[2]]];
    self.singleImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.singleImage];
    [self.singleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(74);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.height.mas_equalTo(350);
    }];
    
    self.allImage = [[UIImageView alloc] init];
    self.allImage.contentMode = UIViewContentModeScaleAspectFit;
    if (self.allImageArray.count) {
        [self.allImage sd_setImageWithURL:[NSURL URLWithString:self.allImageArray[2]]];
    }
    [self.view addSubview:self.allImage];
    [self.allImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.singleImage.mas_centerX);
        make.left.equalTo(self.singleImage.mas_left);
        make.top.equalTo(self.singleImage.mas_bottom).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
    }];
    
}

- (void)clickRightItem {
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"jpeg"];
//    NSData *dataFromPath = [NSData dataWithContentsOfFile:path];
    UIImage *image = self.allImage.image;
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
//    NSLog(@"data = %@", data);
    
    UIPrintInteractionController *printController = [UIPrintInteractionController sharedPrintController];
    
    if(printController && [UIPrintInteractionController canPrintData:data]) {
        
        printController.delegate = self;
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputPhoto;
//        printInfo.jobName = [path lastPathComponent];
        printInfo.jobName = @"打印照片";
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        printController.printInfo = printInfo;
        printController.showsPageRange = YES;
        printController.printingItem = data;
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
            if (!completed && error) {
                NSLog(@"FAILED! due to error in domain %@ with error code %ld", error.domain, (long)error.code);
            }
        };
        [printController presentAnimated:YES completionHandler:completionHandler];
    }
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
