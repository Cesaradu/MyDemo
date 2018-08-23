//
//  WaterfallCollectionViewController.m
//  Demo
//
//  Created by hztuen on 2017/6/27.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "WaterfallCollectionViewController.h"
#import "WaterFlowLayout.h"
#import "WaterFlowModel.h"
#import "WaterFlowCell.h"

@interface WaterfallCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, WaterFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;//数据源

@end

@implementation WaterfallCollectionViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        _dataArray = [WaterFlowModel mj_objectArrayWithFilename:@"1.plist"];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self buildUI];
}

- (void)initData {
    self.title = @"瀑布流";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)buildUI {
    WaterFlowLayout *flowLayout = [[WaterFlowLayout alloc] init];
    flowLayout.delegate = self;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[WaterFlowCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionView 

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了%ld个item", indexPath.row);
}

#pragma mark - WaterFlowLayoutDelegate
- (CGFloat)WaterFlowLayout:(WaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth
{
    WaterFlowModel *model = self.dataArray[index];
    
    return itemWidth * model.h / model.w;
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
