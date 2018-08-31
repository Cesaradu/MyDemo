//
//  MoreFunctionViewController.m
//  MyDemo
//
//  Created by Adu on 2018/8/29.
//  Copyright © 2018年 Cesar. All rights reserved.
//

#import "MoreFunctionViewController.h"
#import "MoreFunctionCell.h"

@interface MoreFunctionViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    BOOL    _isChange;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *cateArray;
@property (nonatomic, strong) NSMutableArray *cellAttributesArray;

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
    [layout setItemSize:CGSizeMake((ScreenWidth - [self Suit:25])/4, (ScreenWidth - [self Suit:25])/4)];
    layout.sectionInset = UIEdgeInsetsMake([self Suit:10], [self Suit:5], [self Suit:10], [self Suit:5]);
    layout.minimumLineSpacing = [self Suit:5];
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
    return self.cateArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MoreFunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    [cell loadData:self.cateArray[indexPath.row]];
    
    //为每个cell 添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [cell addGestureRecognizer:longPress];
    
    return cell;
}

//长按拖动
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    MoreFunctionCell *cell = (MoreFunctionCell *)longPress.view;
    NSIndexPath *cellIndexpath = [self.collectionView indexPathForCell:cell];
    [self.collectionView bringSubviewToFront:cell];
    
    _isChange = NO;
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            [self.cellAttributesArray removeAllObjects];
            for (int i = 0; i < self.cateArray.count; i++) {
                [self.cellAttributesArray addObject:[self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
            }
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            cell.center = [longPress locationInView:self.collectionView];
            for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
                if (CGRectContainsPoint(attributes.frame, cell.center) && cellIndexpath != attributes.indexPath) {
                    _isChange = YES;
                    NSDictionary *data = self.cateArray[cellIndexpath.row];
                    [self.cateArray removeObjectAtIndex:cellIndexpath.row];
                    [self.cateArray insertObject:data atIndex:attributes.indexPath.row];
                    [self.collectionView moveItemAtIndexPath:cellIndexpath toIndexPath:attributes.indexPath];
                }
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded: {
            if (!_isChange) {
                cell.center = [self.collectionView layoutAttributesForItemAtIndexPath:cellIndexpath].center;
            }
        }
            break;
        
        default:
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
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

- (NSMutableArray *)cellAttributesArray {
    if(_cellAttributesArray == nil) {
        _cellAttributesArray = [[NSMutableArray alloc] init];
    }
    return _cellAttributesArray;
}

- (NSMutableArray *)cateArray {
    if(_cateArray == nil) {
        _cateArray = [[NSMutableArray alloc] initWithArray:@[@{@"imageName": @"jiankangyundong", @"titleName": @"健康运动"}, @{@"imageName": @"kqoqing", @"titleName": @"考勤"}, @{@"imageName": @"youerqingjia", @"titleName": @"幼儿请假"}, @{@"imageName": @"qinzizuoye", @"titleName": @"亲子作业"}, @{@"imageName": @"shipu", @"titleName": @"食谱"}, @{@"imageName": @"tongzhigonggao", @"titleName": @"通知公告"}, @{@"imageName": @"banjixiangce", @"titleName": @"班级相册"}, @{@"imageName": @"chengzhangzuji", @"titleName": @"成长足迹"}, @{@"imageName": @"dingwei", @"titleName": @"定位"}, @{@"imageName": @"dianziweilan", @"titleName": @"电子围栏"}, @{@"imageName": @"lishiguiji", @"titleName": @"历史轨迹"}, @{@"imageName": @"banjitongxunlu", @"titleName": @"班级通讯录"}, @{@"imageName": @"yuanzhangxinxiang", @"titleName": @"园长信箱"}, @{@"imageName": @"guangrongbang", @"titleName": @"光荣榜"}, @{@"imageName": @"yizhouhuodong", @"titleName": @"一周活动"}]];
    }
    return _cateArray;
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
