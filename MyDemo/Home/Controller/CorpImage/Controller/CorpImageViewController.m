//
//  CorpImageViewController.m
//  Demo
//
//  Created by hztuen on 2017/7/13.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "CorpImageViewController.h"
#import "TOCropViewController.h"
#import "TZImagePickerController.h"

@interface CorpImageViewController () <TZImagePickerControllerDelegate, TOCropViewControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *naviRightBtn;

@end

@implementation CorpImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self buildUI];
}

- (void)initData {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"裁剪图片";
}

- (void)buildUI {
    
    //编辑
    self.naviRightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.naviRightBtn.frame = CGRectMake(0, 0, 40, 40);
    [self.naviRightBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.naviRightBtn addTarget:self action:@selector(clickEditButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviRightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //图片
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    
    
    
}

- (void)clickEditButton {
    if ([self.naviRightBtn.titleLabel.text isEqualToString:@"添加"]) //添加照片
    {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        // 你可以通过block或者代理，来得到用户选择的照片.
        //选择完返回的照片
        imagePickerVc.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto)
        {
            for(UIImage *image in photos)
            {
                self.imageView.image = image;
            }
            [self.naviRightBtn setTitle:@"裁剪" forState:UIControlStateNormal];
        };
        [self presentViewController:imagePickerVc animated:YES completion:nil];

    }
    else //裁剪
    {
        TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault image:self.imageView.image];
        cropController.delegate = self;
        CGRect viewFrame = [self.view convertRect:self.imageView.frame toView:self.navigationController.view];
        [cropController presentAnimatedFromParentViewController:self
                                                      fromImage:self.imageView.image
                                                       fromView:nil
                                                      fromFrame:viewFrame
                                                          angle:0
                                                   toImageFrame:CGRectZero
                                                          setup:nil
                                                     completion:nil];
    }
    
}

#pragma mark - TOCropViewControllerDelegate
//裁剪成功回调
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle {
    //先dismiss控制器
    [cropViewController dismissViewControllerAnimated:YES completion:nil];
    //做需要的操作
    self.imageView.image = image;
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
