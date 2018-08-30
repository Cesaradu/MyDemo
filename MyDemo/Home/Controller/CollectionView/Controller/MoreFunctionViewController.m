//
//  MoreFunctionViewController.m
//  MyDemo
//
//  Created by Adu on 2018/8/29.
//  Copyright © 2018年 Cesar. All rights reserved.
//

#import "MoreFunctionViewController.h"
#import "MoreFunctionCell.h"

@interface MoreFunctionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MoreFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self buildUI];
}

- (void)initData {
    self.view.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.title = @"更多应用";
}

- (void)buildUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake((ScreenWidth - [self Suit:50])/4, (ScreenWidth - [self Suit:50])/4)];
    layout.sectionInset = UIEdgeInsetsMake([self Suit:10], [self Suit:10], [self Suit:10], [self Suit:10]);
    layout.minimumLineSpacing = [self Suit:10];
    layout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[MoreFunctionCell class] forCellWithReuseIdentifier:@"collectionCell"];
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MoreFunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    MoreFunctionCell *cell = (MoreFunctionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell downSize];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    MoreFunctionCell *cell = (MoreFunctionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell resize];
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
