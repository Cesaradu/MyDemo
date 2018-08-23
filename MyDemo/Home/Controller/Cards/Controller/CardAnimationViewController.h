//
//  CardAnimationViewController.h
//  Demo
//
//  Created by hztuen on 2017/6/1.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "BaseViewController.h"
#import "CardScrollViewer.h"

@interface CardAnimationViewController : BaseViewController

@property (nonatomic, strong) CardScrollViewer *cardScrollViewer;

/**
 *  记录当前点击的indexPath
 */
@property (nonatomic, assign) NSInteger currentIndex;

@end
