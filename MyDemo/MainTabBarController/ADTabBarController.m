//
//  ADTabBarController.m
//  TabBarDemo
//
//  Created by hztuen on 17/3/21.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "ADTabBarController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "ADTabBar.h"
#import "AnimationFactory.h"
#import "ADTabBarItem.h"
#import "ADTabBarSource.h"

@interface ADTabBarController ()

@property (nonatomic, strong) NSMutableArray *chiledViewControllers;
@property (nonatomic, strong) NSMutableArray *barImageArr;
@property (nonatomic, strong) NSMutableArray *barTitleArr;
@property (nonatomic, strong) ADTabBar *adTabBar;

@end

@implementation ADTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createTabBar];
    [self setBarAppearance];
}

- (void)initData {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.adTabBar = [[ADTabBar alloc] init];
    self.chiledViewControllers = [NSMutableArray new];
    self.barImageArr = [NSMutableArray new];
    self.barTitleArr = [NSMutableArray new];
}

- (void)createTabBar {

    self.tabBar.tintColor = [UIColor whiteColor];
    
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.adTabBar.backgroundColor = [UIColor whiteColor];
    [self.adTabBar setBackgroundImage:img];
    [self.adTabBar setShadowImage:img];

    //使用kvc，将自定义的tabbar替换掉系统的tabbar
    [self setValue:self.adTabBar forKey:@"tabBar"];
    
    //tabbar分割线
    [self dropShadowWithOffset:CGSizeMake(0, -1) radius:0 color:[UIColor blackColor] opacity:0.1];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    MineViewController *mineVC = [[MineViewController alloc] init];
    
    NSMutableArray *controllerArray = [NSMutableArray arrayWithObjects:homeVC, mineVC, nil];
    NSMutableArray *normalImageArray = [NSMutableArray arrayWithArray:@[@"home_icon_normal", @"mine_icon_normal"]];
    NSMutableArray *selectedImageArray = [NSMutableArray arrayWithArray:@[@"home_icon_selected", @"mine_icon_selected"]];
    NSMutableArray *titleArray = [NSMutableArray arrayWithArray:@[@"首页", @"我的"]];
    
    ADTabBarSource *dataSource = [[ADTabBarSource alloc] init];
    dataSource.titleArr = titleArray;
    dataSource.viewControllers = controllerArray;
    dataSource.normalImageArr = normalImageArray;
    dataSource.selectImageArr = selectedImageArray;
    [self tabBarSetDataSource:dataSource];
}

- (void)setBarAppearance {
    
    // 设置导航条背景图
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    if (IS_IOS8 || Is_IOS9) {
        [[UINavigationBar appearance] setTranslucent:YES];
    }
    
    // UINavigationBar 设置字体
    [[UINavigationBar appearance] setTitleTextAttributes:
     @{ NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000" alpha:0.8], NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f]}];
}

//tabbar加阴影
- (void)dropShadowWithOffset:(CGSize)offset radius:(CGFloat)radius color:(UIColor *)color opacity:(CGFloat)opacity {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    self.tabBar.clipsToBounds = NO;
}

/**
 给Tabbar赋值：image、title、viewController
 @param dataSoucre 数据源
 */
- (void)tabBarSetDataSource:(ADTabBarSource *)dataSoucre {
    for (int  i = 0; i < dataSoucre.viewControllers.count; i++) {
        NSString *title = dataSoucre.titleArr[i];
        UIImage *normalImage = [UIImage imageNamed:dataSoucre.normalImageArr[i]];
        UIImage *selectImage = [UIImage imageNamed:dataSoucre.selectImageArr[i]];
        UIViewController *viewController = dataSoucre.viewControllers[i];
        viewController.title = dataSoucre.titleArr[i];
        [self setupOnChildViewController:viewController title:title normalImage:normalImage selectImage:selectImage tag:i];
    }
    self.viewControllers = self.chiledViewControllers;
    self.adTabBar.dataSource = self.viewControllers;
    [self.adTabBar setNeedsLayout];
    for (UIControl *tabbarButton in self.adTabBar.subviews) {
        if ([tabbarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            for (UIView *barSubView in tabbarButton.subviews) {
                if ([barSubView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                    [self.barImageArr addObject:barSubView];
                }
                if ([barSubView isKindOfClass:[UILabel class]]) {
                    [self.barTitleArr addObject:barSubView];
                }
            }
        }
    }
}

/**
 修改TabBarItem 属性 以及给TabBarItem赋数据 添加tabbar动画效果
 @param chiledVC 子视图
 @param title title
 @param normalImage 默认图
 @param selectImage 选中图
 */
- (void)setupOnChildViewController:(UIViewController *)chiledVC title:(NSString *)title normalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage tag:(NSInteger)tag {
    ADTabBarItem *barItem = [[ADTabBarItem alloc]init];
    barItem.title = title;
    barItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barItem.tag = tag;
    barItem.tabBarAnimation = [AnimationFactory animationWithType:JelloAnima];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:MainColor alpha:1.0]} forState:UIControlStateSelected];
    chiledVC.tabBarItem = barItem;
    [self.chiledViewControllers addObject:chiledVC];
}

/**
 点击TabBarItem代理
 @param tabBar tabBar
 @param item 当前点击Item
 */
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    ADTabBarItem *nowItem = (ADTabBarItem *)item;
    if (nowItem.tag != self.adTabBar.seleItem.tag) {
        [nowItem playAnimation:[self.barImageArr objectAtIndex:nowItem.tag] textLabel:[self.barTitleArr objectAtIndex:nowItem.tag]];
        [self.adTabBar.seleItem deselectAnimation:[self.barImageArr objectAtIndex:self.adTabBar.seleItem.tag] textLabel:[self.barTitleArr objectAtIndex:self.adTabBar.seleItem.tag]];
        self.adTabBar.seleItem = nowItem;
    }else{
        [nowItem selectedState:[self.barImageArr objectAtIndex:nowItem.tag] textLabel:[self.barTitleArr objectAtIndex:nowItem.tag]];
    }
}

/**
 通过self.selectIndex改变tabbar当前controller时调用
 @param index 想要选择某个controller
 */
- (void)changeSelectIndex:(NSInteger)index {
    self.selectedIndex = index;
    ADTabBarItem *barItem = (ADTabBarItem *)[self.adTabBar.items objectAtIndex:index];
    [self tabBar:self.adTabBar didSelectItem:barItem];
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
