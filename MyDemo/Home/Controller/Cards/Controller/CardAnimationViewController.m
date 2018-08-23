//
//  CardAnimationViewController.m
//  Demo
//
//  Created by hztuen on 2017/6/1.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "CardAnimationViewController.h"
#import "DetailViewController.h"


@interface CardAnimationViewController () <CardScrollDelegate, UINavigationControllerDelegate>

@end

@implementation CardAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

- (void)buildUI {
    self.cardScrollViewer = [[CardScrollViewer alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.cardScrollViewer.delegate = self;
    [self.view addSubview:self.cardScrollViewer];
}

#pragma mark -CardScrollViewerDelegate
- (void)CardScrollViewerDidSelectAtIndex:(NSInteger)index {
    NSLog(@"点击了 %ld", index);
    self.currentIndex = index;
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.index = index;
    self.navigationController.delegate = detailVC;
    [self.navigationController pushViewController:detailVC animated:YES];
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
