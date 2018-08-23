//
//  GridViewController.m
//  Demo
//
//  Created by Oliver on 2018/2/11.
//  Copyright © 2018年 cesar. All rights reserved.
//

#import "GridViewController.h"
#import "ScheduleModel.h"
#import "ScheduleCell.h"
#import "JHGridView.h"

@interface GridViewController () <JHGridViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *leftDataArray;

@end

@implementation GridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

- (void)setUI {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.scrollView.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake([self Suit:10], [self Suit:10], ScreenWidth - [self Suit:260], ScreenHeight)];
    self.leftTableView.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:self.leftTableView];
    
    JHGridView *gridView = [[JHGridView alloc] initWithFrame:CGRectMake(ScreenWidth - [self Suit:250], [self Suit:10], [self Suit:240], ScreenHeight)];
    gridView.delegate = self;
    [gridView setTitles:@[@"星期一",
                          @"星期二",
                          @"星期三",
                          @"星期四",
                          @"星期五"]
             andObjects:self.dataArray withTags:@[@"monday",@"tuesday",@"wednesday",@"thursday",@"friday"]];
    [self.scrollView addSubview:gridView];
}

#pragma mark - JHGridViewDelegate
- (void)didSelectRowAtGridIndex:(GridIndex)gridIndex {
    NSLog(@"selected at\ncol:%ld -- row:%ld", gridIndex.col, gridIndex.row);
}

- (BOOL)isTitleFixed {
    return YES;
}

- (CGFloat)widthForColAtIndex:(long)index {
    return [self Suit:80];
}

- (UIColor *)backgroundColorForTitleAtIndex:(long)index{
    return [UIColor colorWithRed:232/255.0 green:241/255.0 blue:255/255.0 alpha:1];
}

- (UIColor *)backgroundColorForGridAtGridIndex:(GridIndex)gridIndex{
    return [UIColor whiteColor];
}

- (UIColor *)textColorForTitleAtIndex:(long)index{
    return [UIColor colorWithRed:38/255.0 green:119/255.0 blue:255/255.0 alpha:1];
}

- (UIColor *)textColorForGridAtGridIndex:(GridIndex)gridIndex{
    return [UIColor colorWithRed:38/255.0 green:119/255.0 blue:255/255.0 alpha:1];
}

- (UIFont *)fontForTitleAtIndex:(long)index{
    return [UIFont systemFontOfSize:[self SuitFont:15]];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self Suit:44];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.leftTableView.frame), [self Suit:44])];
    headView.backgroundColor = [UIColor colorWithRed:232/255.0 green:241/255.0 blue:255/255.0 alpha:1];
    headView.layer.borderWidth = 0.5;
    headView.layer.borderColor = [UIColor colorWithRed:38/255.0 green:119/255.0 blue:255/255.0 alpha:1].CGColor;
    
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[ScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    cell.layer.borderWidth = 0.5;
    cell.layer.borderColor = [UIColor colorWithRed:38/255.0 green:119/255.0 blue:255/255.0 alpha:1].CGColor;
    
    [cell loadCell:self.leftDataArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       [[ScheduleModel alloc] initWithMondaySchedule:@"语文" TuesdaySchedule:@"语文" WednesdaySchedule:@"语文" ThursdaySchedule:@"语文" FridaySchedule:@"语文"],
                       [[ScheduleModel alloc] initWithMondaySchedule:@"语文" TuesdaySchedule:@"语文" WednesdaySchedule:@"语文" ThursdaySchedule:@"语文" FridaySchedule:@"语文"],
                       [[ScheduleModel alloc] initWithMondaySchedule:@"语文" TuesdaySchedule:@"语文" WednesdaySchedule:@"语文" ThursdaySchedule:@"语文" FridaySchedule:@"语文"],
                       [[ScheduleModel alloc] initWithMondaySchedule:@"语文" TuesdaySchedule:@"语文" WednesdaySchedule:@"语文" ThursdaySchedule:@"语文" FridaySchedule:@"语文"],
                       [[ScheduleModel alloc] initWithMondaySchedule:@"语文" TuesdaySchedule:@"语文" WednesdaySchedule:@"语文" ThursdaySchedule:@"语文" FridaySchedule:@"语文"],
                       [[ScheduleModel alloc] initWithMondaySchedule:@"语文" TuesdaySchedule:@"语文" WednesdaySchedule:@"语文" ThursdaySchedule:@"语文" FridaySchedule:@"语文"],
                       [[ScheduleModel alloc] initWithMondaySchedule:@"语文" TuesdaySchedule:@"语文" WednesdaySchedule:@"语文" ThursdaySchedule:@"语文" FridaySchedule:@"语文"],
                       [[ScheduleModel alloc] initWithMondaySchedule:@"语文" TuesdaySchedule:@"语文" WednesdaySchedule:@"语文" ThursdaySchedule:@"语文" FridaySchedule:@"语文"],
                       [[ScheduleModel alloc] initWithMondaySchedule:@"语文" TuesdaySchedule:@"语文" WednesdaySchedule:@"语文" ThursdaySchedule:@"语文" FridaySchedule:@"语文"],
                       [[ScheduleModel alloc] initWithMondaySchedule:@"语文" TuesdaySchedule:@"语文" WednesdaySchedule:@"语文" ThursdaySchedule:@"语文" FridaySchedule:@"语文"],
                       [[ScheduleModel alloc] initWithMondaySchedule:@"语文" TuesdaySchedule:@"语文" WednesdaySchedule:@"语文" ThursdaySchedule:@"语文" FridaySchedule:@"语文"]
                       ];
    }
    return _dataArray;
}

- (NSArray *)leftDataArray {
    if (!_leftDataArray) {
        _leftDataArray = @[@"第一节(07:30-08:15)", @"第二节(07:30-08:15)", @"第三节(07:30-08:15)", @"第四节(07:30-08:15)", @"第五节(07:30-08:15)", @"第六节(07:30-08:15)", @"第七节(07:30-08:15)", @"第八节(07:30-08:15)", @"第九节(07:30-08:15)", @"第十节(07:30-08:15)", @"第十一节(07:30-08:15)"];
    }
    return _leftDataArray;
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
