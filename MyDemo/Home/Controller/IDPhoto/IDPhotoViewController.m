//
//  IDPhotoViewController.m
//  Demo
//
//  Created by hztuen on 2017/7/17.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "IDPhotoViewController.h"
#import "IDPhotoDetailViewController.h"

@interface IDPhotoViewController ()

@property (nonatomic, strong) UIImageView *originalImage;
@property (nonatomic, strong) UIImageView *returnedImage;

@end

@implementation IDPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self buildUI];
}

-(void)initData {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)buildUI {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"制作" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.originalImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 64+15, ScreenWidth-30, self.view.frame.size.height-64-30)];
    self.originalImage.contentMode = UIViewContentModeScaleAspectFit;
    self.originalImage.image = [UIImage imageNamed:@"test.jpg"];
    [self.view addSubview:self.originalImage];
    
}

//点击制作
- (void)clickRightItem {
    UIImage *image = [UIImage imageNamed:@"test.jpg"];
    NSData *data =UIImageJPEGRepresentation(image, 1.0);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@"382" forKey:@"spec_id"];//小二寸
    [parameters setValue:encodedImageStr forKey:@"file"];
    
    [ADBaseRequest postRequest:parameters AndUrl:@"http://api.id-photo-verify.com/api/test_api" success:^(id responseDict) {
        
        NSLog(@"responseDict = %@", responseDict);
        if ([responseDict[@"code"] intValue] == 200) {
            NSArray *urlArray = responseDict[@"result"][@"url"];
            NSArray *urlPrintArray = responseDict[@"result"][@"url_print"];
            NSMutableArray *newArray = [NSMutableArray new];
            NSMutableArray *printArray = [NSMutableArray new];
            for (int i = 0; i < urlArray.count; i++) {
                NSString *urlStr = urlArray[i];
                NSString *newUrl = [NSString stringWithFormat:@"http://api.id-photo-verify.com/%@", urlStr];
                [newArray addObject:newUrl];
                
                if (urlPrintArray.count) {
                    NSString *printStr = urlPrintArray[i];
                    NSString *newPrintUrl = [NSString stringWithFormat:@"http://api.id-photo-verify.com/%@", printStr];
                    [printArray addObject:newPrintUrl];
                }
            }
            NSLog(@"newArray = %@", newArray);
            NSLog(@"newPrintArray = %@", printArray);
            IDPhotoDetailViewController *detailVC = [[IDPhotoDetailViewController alloc] init];
            detailVC.singleImageArray = newArray;
            detailVC.allImageArray = printArray;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
        
    } fail:^(NSError *error) {
        NSLog(@"error = %@", error);
    }];
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
