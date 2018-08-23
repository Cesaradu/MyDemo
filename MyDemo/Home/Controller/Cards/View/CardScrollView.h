//
//  CardScrollView.h
//  Demo
//
//  Created by hztuen on 2017/5/24.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardScrollViewDelegate <NSObject>

-(void)cardScrollViewDidSlectIndex:(NSInteger)index;//选中某张卡片
-(void)cardScrollViewDidScrollAllPage:(NSInteger)page AndIndex:(NSInteger)index;//滚动某张卡片
-(void)cardScrollViewDidEndScrollIndex:(NSInteger)index;//滚动结束时的当前卡片

@end

@interface CardScrollView : UIView <UIScrollViewDelegate>

@property (nonatomic,weak) id <CardScrollViewDelegate> delegate;
@property(nonatomic,assign) CGFloat zMarginValue;//图片之间z方向的间距值，越小间距越大
@property(nonatomic,assign) CGFloat xMarginValue;//图片之间x方向的间距值，越小间距越大
@property(nonatomic,assign) CGFloat alphaValue;//图片的透明比率值
@property(nonatomic,assign) CGFloat angleValue;//偏移角度
@property(nonatomic,strong) NSMutableArray* cardDataArray;//卡片信息数组

#pragma mark- init method

/*通过参数进行初始化
 注:ZMarginValue与XMarginValue的值越接近，效果越佳
 透明比率值建议设置在1000左右
 */
-(instancetype)initWithFrame:(CGRect)frame AndzMarginValue:(CGFloat)zMarginValue AndxMarginValue:(CGFloat)xMarginValue AndalphaValue:(CGFloat)alphaValue AndangleValue:(CGFloat)angleValue;

/*
 添加卡片信息
 */
-(void)addCardDataWithArray:(NSArray*)array;

@end
