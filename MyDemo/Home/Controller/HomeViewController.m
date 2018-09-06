//
//  HomeViewController.m
//  BaseFramework
//
//  Created by hztuen on 17/3/2.
//  Copyright © 2017年 Cesar. All rights reserved.
//

#import "HomeViewController.h"
#import "CardViewController.h"
#import "BoardingCardViewController.h"
#import "CardAnimationViewController.h"
#import "DownLoadZipViewController.h"
#import "WaterfallCollectionViewController.h"
#import "SignatureViewController.h"
#import "BlueToothViewController.h"
#import "CorpImageViewController.h"
#import "IDPhotoViewController.h"
#import "BeautyViewController.h"
#import "ADSwitchViewController.h"
#import "ScanViewController.h"
#import "GridViewController.h"
#import "RefreshViewController.h"
#import "MoreFunctionViewController.h"
#import "FloatingViewController.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"首页";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildTableView];
}

- (void)buildTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"卡片动画1";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"卡片动画2";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"卡片动画3";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"zip下载";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"瀑布流";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"签名";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"蓝牙";
    } else if (indexPath.row == 7) {
        cell.textLabel.text = @"图片裁剪";
    } else if (indexPath.row == 8) {
        cell.textLabel.text = @"证件照接口";
    } else if (indexPath.row == 9) {
        cell.textLabel.text = @"照片美颜";
    } else if (indexPath.row == 10) {
        cell.textLabel.text = @"switch";
    } else if (indexPath.row == 11) {
        cell.textLabel.text = @"二维码扫描";
    } else if (indexPath.row == 12) {
        cell.textLabel.text = @"课程表";
    } else if (indexPath.row == 13) {
        cell.textLabel.text = @"刷新列表";
    } else if (indexPath.row == 14) {
        cell.textLabel.text = @"collectionView点击效果";
    } else if (indexPath.row == 15) {
        cell.textLabel.text = @"气泡浮动效果";
    } else {
        cell.textLabel.text = @"";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        CardViewController *cardVC = [[CardViewController alloc] init];
        [self.navigationController pushViewController:cardVC animated:YES];
    } else if (indexPath.row == 1) {
        BoardingCardViewController *boardingVC = [[BoardingCardViewController alloc] init];
        [self.navigationController pushViewController:boardingVC animated:YES];
    } else if (indexPath.row == 2) {
        CardAnimationViewController *cardAnim = [[CardAnimationViewController alloc] init];
        [self.navigationController pushViewController:cardAnim animated:YES];
    } else if (indexPath.row == 3) {
        DownLoadZipViewController *downloadVC = [[DownLoadZipViewController alloc] init];
        [self.navigationController pushViewController:downloadVC animated:YES];
    } else if (indexPath.row == 4) {
        WaterfallCollectionViewController *waterfallVC = [[WaterfallCollectionViewController alloc] init];
        [self.navigationController pushViewController:waterfallVC animated:YES];
    } else if (indexPath.row == 5) {
        SignatureViewController *signatureVC = [[SignatureViewController alloc] init];
        [self.navigationController pushViewController:signatureVC animated:YES];
    } else if (indexPath.row == 6) {
        BlueToothViewController *blueToothVC = [[BlueToothViewController alloc] init];
        [self.navigationController pushViewController:blueToothVC animated:YES];
    } else if (indexPath.row == 7) {
        CorpImageViewController *corpImageVC = [[CorpImageViewController alloc] init];
        [self.navigationController pushViewController:corpImageVC animated:YES];
    } else if (indexPath.row == 8) {
        IDPhotoViewController *idVC = [[IDPhotoViewController alloc] init];
        [self.navigationController pushViewController:idVC animated:YES];
    } else if (indexPath.row == 9) {
        BeautyViewController *beautyVC = [[BeautyViewController alloc] init];
        [self.navigationController pushViewController:beautyVC animated:YES];
    } else if (indexPath.row == 10) {
        ADSwitchViewController *switchVC = [[ADSwitchViewController alloc] init];
        [self.navigationController pushViewController:switchVC animated:YES];
    } else if (indexPath.row == 11) {
        ScanViewController *scanVC = [[ScanViewController alloc] init];
        [self.navigationController pushViewController:scanVC animated:YES];
    } else if (indexPath.row == 12) {
        GridViewController *gridVC = [[GridViewController alloc] init];
        [self.navigationController pushViewController:gridVC animated:YES];
    } else if (indexPath.row == 13) {
        RefreshViewController *refreshVC = [[RefreshViewController alloc] init];
        [self.navigationController pushViewController:refreshVC animated:YES];
    } else if (indexPath.row == 14) {
        MoreFunctionViewController *moreVC = [[MoreFunctionViewController alloc] init];
        [self.navigationController pushViewController:moreVC animated:YES];
    } else if (indexPath.row == 15) {
        FloatingViewController *floatingVC = [[FloatingViewController alloc] init];
        [self.navigationController pushViewController:floatingVC animated:YES];
    } else {
        
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
