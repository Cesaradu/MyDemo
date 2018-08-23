//
//  JHSingleTitleGridView.m
//  JHSingleTitleGridView
//
//  Created by 307A on 16/9/25.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "JHGridView.h"
@interface JHGridView() <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic) NSArray *titles;
@property (nonatomic) NSArray *tags;
@property (nonatomic) NSArray *objects;

@property (nonatomic) UIScrollView *backScrollView;
@property (nonatomic) UIScrollView *backTitleScrollView;
@end

@implementation JHGridView
#pragma mark --Init Methods
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}

- (void)setTitles:(NSArray *)titles andObjects:(NSArray *)objects withTags:(NSArray *)tags{
    if (titles.count != tags.count) {
        //warning
    }
    _titles = titles;
    _tags = tags;
    _objects = objects;
    
    [self setupView];
}

- (void)setupView {
    //remove subviews
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    //calculate table's height and width
    long titleNum = _titles.count;
    CGFloat tableHeight = 0;
    CGFloat tableWidth = 0;
    for (int i = 0; i<_objects.count; i++) {
        tableHeight += [self heightForRowAtIndex:i];
    }
    for (int i = 0; i<_titles.count; i++) {
        tableWidth += [self widthForColAtIndex:i];
    }
    
    //setup background scrollview and titles
    float titleHeight = [self heightForTitles];
    float gridWidth = 0;
    if ([self isTitleFixed]) {
        //setup scrollview for titles
        _backTitleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, titleHeight)];
        _backTitleScrollView.showsHorizontalScrollIndicator = NO;
        _backTitleScrollView.showsVerticalScrollIndicator = NO;
        _backTitleScrollView.scrollEnabled = YES;
        _backTitleScrollView.contentSize = CGSizeMake(tableWidth, titleHeight);
        _backTitleScrollView.delegate = self;
        _backTitleScrollView.bounces = NO;
        
        //setup titles
        float offsetX = 0;
        for (long i = 0; i < _titles.count; i++) {
            gridWidth = [self widthForColAtIndex:i];
            CGRect frame = CGRectMake(offsetX, 0, gridWidth, titleHeight);
            offsetX += gridWidth;
            UIView *titleView = [[UIView alloc] initWithFrame:frame];
            titleView.layer.borderWidth = 0.5;
            titleView.layer.borderColor = [[UIColor colorWithRed:38/255.0 green:119/255.0 blue:255/255.0 alpha:1] CGColor];
            titleView.backgroundColor = [self backgroundColorForTitleAtIndex:i];
            UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            titleLbl.text = [_titles objectAtIndex:i];
            titleLbl.textColor = [self textColorForTitleAtIndex:i];
            [titleLbl setFont:[self fontSizeForTitleAtIndex:i]];
            [self applyAlignmentTypeFor:titleLbl];
            [titleView addSubview:titleLbl];
            [_backTitleScrollView addSubview:titleView];
        }
        
        //setup scrollview
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleHeight, self.frame.size.width, self.frame.size.height-titleHeight)];
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
        _backScrollView.scrollEnabled = YES;
        _backScrollView.delegate = self;
        _backScrollView.bounces = NO;
        [self addSubview:_backTitleScrollView];
        [self addSubview:_backScrollView];
    }else if (![self isTitleFixed]) {
        //setup scrollview
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
        _backScrollView.scrollEnabled = YES;
        _backScrollView.bounces = NO;
        
        //setup titles
        float offsetX = 0;
        for (long i = 0; i < _titles.count; i++) {
            gridWidth = [self widthForColAtIndex:i];
            CGRect frame = CGRectMake(offsetX, 0, gridWidth, titleHeight);
            offsetX += gridWidth;
            UIView *titleView = [[UIView alloc] initWithFrame:frame];
            titleView.layer.borderWidth = 0.5;
            titleView.layer.borderColor = [[UIColor colorWithRed:38/255.0 green:119/255.0 blue:255/255.0 alpha:1] CGColor];
            titleView.backgroundColor = [self backgroundColorForTitleAtIndex:i];
            UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            titleLbl.text = [_titles objectAtIndex:i];
            titleLbl.textColor = [self textColorForTitleAtIndex:i];
            [titleLbl setFont:[self fontSizeForTitleAtIndex:i]];
            [self applyAlignmentTypeFor:titleLbl];
            [titleView addSubview:titleLbl];
            [_backScrollView addSubview:titleView];
        }
        [self addSubview:_backScrollView];
    }

    //setup tables
    float offsetX = 0;
    for (long i = 0; i < titleNum; i++) {
        CGRect frame = CGRectZero;
        gridWidth = [self widthForColAtIndex:i];
        if ([self isTitleFixed]) {
            frame = CGRectMake(offsetX, 0, gridWidth, tableHeight);
        }else{
            frame = CGRectMake(offsetX, [self heightForTitles], gridWidth, tableHeight);
        }
        offsetX += gridWidth;
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.layer.borderWidth = 0.5;
        tableView.layer.borderColor = [[UIColor colorWithRed:38/255.0 green:119/255.0 blue:255/255.0 alpha:1] CGColor];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = NO;
        tableView.tag = i;
        [_backScrollView addSubview:tableView];
    }
    
    //setup scrollview's content size
    float contentWidth = tableWidth;
    float contentHeight = [self isTitleFixed]?tableHeight:tableHeight + [self heightForTitles];
    [_backScrollView setContentSize:CGSizeMake(contentWidth, [self isTitleFixed]?tableHeight:contentHeight)];
}

#pragma mark --Set Up Methods
- (void)applyAlignmentTypeFor:(UILabel *)label{
    switch ([self gridViewAlignmentType]) {
        case JHGridAlignmentTypeDefault:
        case JHGridAlignmentTypeCenter:
            label.textAlignment = NSTextAlignmentCenter;
            break;
        case JHGridAlignmentTypeLeft:
            label.textAlignment = NSTextAlignmentLeft;
            break;
        case JHGridAlignmentTypeRight:
            label.textAlignment = NSTextAlignmentRight;
            break;
        default:
            break;
    }

}

#pragma mark --Self TableView Delegate Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"JHGridTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    //setup content of cells
    long index = indexPath.row;
    cell.textLabel.text = [[_objects objectAtIndex:index] valueForKey:[_tags objectAtIndex:tableView.tag]];
    [self applyAlignmentTypeFor:cell.textLabel];
    
    GridIndex gridIndex;
    gridIndex.col = tableView.tag;
    gridIndex.row = indexPath.row;
    cell.backgroundColor = [self backgroundColorForGridAtGridIndex:gridIndex];
    cell.textLabel.textColor = [self textColorForGridAtGridIndex:gridIndex];
    [cell.textLabel setFont:[self fontSizeForGridAtGridIndex:gridIndex]];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    cell.layer.borderWidth = 0.5;
    cell.layer.borderColor = [UIColor colorWithRed:38/255.0 green:119/255.0 blue:255/255.0 alpha:1].CGColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GridIndex gridIndex;
    gridIndex.col = tableView.tag;
    gridIndex.row = indexPath.row;
    
    [self didSelectRowAtGridIndex:gridIndex];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _objects.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndex:(NSIndexPath *)indexPath {
    return [self heightForRowAtIndex:indexPath.row];
}

#pragma mark --Self ScrollView Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_backTitleScrollView]) {
        CGPoint offset = _backScrollView.contentOffset;
        offset.x = _backTitleScrollView.contentOffset.x;
        [_backScrollView setContentOffset:offset];
    }else{
        CGPoint offset = _backTitleScrollView.contentOffset;
        offset.x = _backScrollView.contentOffset.x;
        [_backTitleScrollView setContentOffset:offset];
    }
}

#pragma mark --JHGridView Delegate Methods
- (CGFloat)heightForTitles{
    if([_delegate respondsToSelector:@selector(heightForTitles)]){
        return [_delegate heightForTitles];
    }else{
        return [self Suit:44];
    }
}

- (BOOL)isTitleFixed{
    if([_delegate respondsToSelector:@selector(isTitleFixed)]){
        return [_delegate isTitleFixed];
    }else{
        return NO;
    }
}

- (BOOL)isRowSelectable{
    if([_delegate respondsToSelector:@selector(isRowSelectable)]){
        return [_delegate isRowSelectable];
    }else{
        return NO;
    }
}

- (CGFloat)heightForRowAtIndex:(long)index{
    if([_delegate respondsToSelector:@selector(heightForRowAtIndex:)]){
        return [_delegate heightForRowAtIndex:index];
    }else{
        return 44;
    }
}

- (CGFloat)widthForColAtIndex:(long)index{
    if([_delegate respondsToSelector:@selector(widthForColAtIndex:)]){
        return [_delegate widthForColAtIndex:index];
    }else{
        return [self Suit:80];
    }
}

- (void)didSelectRowAtGridIndex:(GridIndex)gridIndex{
    if([_delegate respondsToSelector:@selector(didSelectRowAtGridIndex:)]){
        [_delegate didSelectRowAtGridIndex:gridIndex];
    }
}

- (JHGridSelectType)gridViewSelectType{
    if ([_delegate respondsToSelector:@selector(gridViewSelectType)]) {
        return [_delegate gridViewSelectType];
    }else{
        return JHGridSelectTypeDefault;
    }
}

- (JHGridAlignmentType)gridViewAlignmentType{
    if ([_delegate respondsToSelector:@selector(gridViewSelectType)]) {
        return [_delegate gridViewAlignmentType];
    }else{
        return JHGridAlignmentTypeCenter;
    }
}

- (UIColor *)backgroundColorForTitleAtIndex:(long)index{
    if ([_delegate respondsToSelector:@selector(backgroundColorForTitleAtIndex:)]) {
        return [_delegate backgroundColorForTitleAtIndex:index];
    }else{
        return JHGridSelectTypeDefault;
    }
}

- (UIColor *)backgroundColorForGridAtGridIndex:(GridIndex)gridIndex{
    if ([_delegate respondsToSelector:@selector(backgroundColorForGridAtGridIndex:)]) {
        return [_delegate backgroundColorForGridAtGridIndex:gridIndex];
    }else{
        return [UIColor whiteColor];
    }
}

- (UIColor *)textColorForTitleAtIndex:(long)index{
    if ([_delegate respondsToSelector:@selector(textColorForTitleAtIndex:)]) {
        return [_delegate textColorForTitleAtIndex:index];
    }else{
        return JHGridSelectTypeDefault;
    }
}

- (UIColor *)textColorForGridAtGridIndex:(GridIndex)gridIndex{
    if ([_delegate respondsToSelector:@selector(textColorForGridAtGridIndex:)]) {
        return [_delegate textColorForGridAtGridIndex:gridIndex];
    }else{
        return [UIColor whiteColor];
    }
}
- (UIFont *)fontSizeForTitleAtIndex:(long)index{
    if ([_delegate respondsToSelector:@selector(fontForTitleAtIndex:)]) {
        return [_delegate fontForTitleAtIndex:index];
    }else{
        return [UIFont systemFontOfSize:15];
    }
}

- (UIFont *)fontSizeForGridAtGridIndex:(GridIndex)gridIndex{
    if ([_delegate respondsToSelector:@selector(fontForGridAtGridIndex:)]) {
        return [_delegate fontForGridAtGridIndex:gridIndex];
    }else{
        return [UIFont systemFontOfSize:15];
    }
}

/**
 适配 给定4.7寸屏尺寸，适配4和5.5寸屏尺寸
 */
- (float)Suit:(float)MySuit
{
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(MySuit=MySuit/Suit4Inch):((IS_IPHONE55INCH)?(MySuit=MySuit*Suit55Inch):MySuit);
    return MySuit;
}

/**
 适配 给定4.7寸屏字号，适配4(-1)和5.5(+1)寸屏字号
 */
- (float)SuitFont:(float)font {
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(font=font-1):((IS_IPHONE55INCH)?(font=font+1):font);
    return font;
}

@end
