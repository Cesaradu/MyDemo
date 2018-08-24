//
//  RefreshViewController.m
//  MyDemo
//
//  Created by Adu on 2018/8/23.
//  Copyright © 2018年 Cesar. All rights reserved.
//

#import "RefreshViewController.h"
#import "ADHappyBirdGifRefresh.h"
#import "LoadingViewController.h"

@interface RefreshViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildTableView];
}

- (void)buildTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self refreshData];
}

- (void)refreshData {
    ADHappyBirdGifRefresh *header = [ADHappyBirdGifRefresh headerWithRefreshingTarget:self refreshingAction:@selector(stopRefresh)];
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.tableView.mj_header = header;
}

- (void)stopRefresh {
    [self performSelector:@selector(stop) withObject:self afterDelay:3];
}

- (void)stop {
    [self.tableView.mj_header endRefreshing];
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", indexPath.row + 1];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LoadingViewController *loadVC = [[LoadingViewController alloc] init];
    [self.navigationController pushViewController:loadVC animated:YES];
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
