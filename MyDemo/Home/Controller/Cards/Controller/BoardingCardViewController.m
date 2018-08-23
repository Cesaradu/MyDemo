//
//  BoardingCardViewController.m
//  Demo
//
//  Created by hztuen on 2017/5/24.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "BoardingCardViewController.h"
#import "CardScrollView.h"
#import "CardView.h"

#define adsViewWidth 293.0*(APPScreenBoundsWidth/320.0)
#define RatioValue  (APPScreenBoundsHeight-118)/450.0
#define APPScreenBoundsHeight [UIScreen mainScreen].bounds.size.height
#define APPScreenBoundsWidth [UIScreen mainScreen].bounds.size.width

@interface BoardingCardViewController () <CardScrollViewDelegate>
{
    CardScrollView *_cardView;
}

//@property (nonatomic, strong) CardView *cardView;

@end

@implementation BoardingCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self buildUI];
}

- (void)initData {
    self.title = @"登机牌";
    self.view.backgroundColor = [UIColor colorWithHexString:@"cdcdcd" alpha:1.0];
}

- (void)buildUI {
    NSArray *array = @[
                       @{@"red":@"255",@"green":@"46",@"blue":@"62"},
  @{@"red":@"82",@"green":@"255",@"blue":@"64"},
  @{@"red":@"82",@"green":@"255",@"blue":@"255"},
  @{@"red":@"79",@"green":@"85",@"blue":@"255"},
  @{@"red":@"236",@"green":@"30",@"blue":@"255"},
  @{@"red":@"46",@"green":@"255",@"blue":@"219"},
  @{@"red":@"255",@"green":@"152",@"blue":@"56"}
                       ];
    
    CGRect rect = {{lrintf((APPScreenBoundsWidth-adsViewWidth)/2.0),118},{lrintf(adsViewWidth) , APPScreenBoundsHeight-118}};
    
    _cardView = [[CardScrollView alloc]initWithFrame:rect AndzMarginValue:9/(RatioValue) AndxMarginValue:11/(RatioValue) AndalphaValue:1 AndangleValue:2000];
    _cardView.delegate = self;
    [_cardView addCardDataWithArray:array];
    _cardView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_cardView];
}

#pragma mark- 代理
-(void)cardScrollViewDidEndScrollIndex:(NSInteger)index
{
    //    NSLog(@"__end__%ld",index);
}

-(void)cardScrollViewDidSlectIndex:(NSInteger)index
{
    //    NSLog(@"__select__%ld",index);
}

-(void)cardScrollViewDidScrollAllPage:(NSInteger)page AndIndex:(NSInteger)index
{
    //    NSLog(@"__page__%ld__index__%ld",page,index);
    
    //    判断是否为第一页
    //    if(page == index){
    //        if (self.comeBackFirstMessageButton.frame.origin.y<APPScreenBoundsHeight) {
    //            [UIView animateWithDuration:0.8 animations:^{
    //                self.comeBackFirstMessageButton.center = CGPointMake(self.comeBackFirstMessageButton.center.x, self.comeBackFirstMessageButton.center.y+self.comeBackFirstMessageButton.frame.size.height);
    //            }];
    //        }
    //    }else{
    //        if (self.comeBackFirstMessageButton.frame.origin.y>=APPScreenBoundsHeight) {
    //            [UIView animateWithDuration:0.8 animations:^{
    //                self.comeBackFirstMessageButton.center = CGPointMake(self.comeBackFirstMessageButton.center.x, self.comeBackFirstMessageButton.center.y-self.comeBackFirstMessageButton.frame.size.height);
    //            }];
    //        }
    //    }
    
    //    提醒已是最后一条消息,由透明慢慢显现
    //    if (_curPage == _totalPage && slideImageView.scrollView.contentOffset.y<0) {
    //        self.lastMessageLabel.alpha = -(slideImageView.scrollView.contentOffset.y/50.0);
    //    }
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
