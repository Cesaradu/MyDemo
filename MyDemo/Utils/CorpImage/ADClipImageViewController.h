//
//  ADCorpImageViewController.h
//  Happybird_Wristband
//
//  Created by Oliver on 2017/10/12.
//  Copyright © 2017年 happybird. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADClipImageViewController;

@protocol ADImageClipDelegate <NSObject>

- (void)imageCropper:(ADClipImageViewController *)clipViewController didFinished:(UIImage *)editedImage;
- (void)imageCropperDidCancel:(ADClipImageViewController *)clipViewController;

@end

@interface ADClipImageViewController : UIViewController

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, weak) id<ADImageClipDelegate> delegate;
@property (nonatomic, assign) CGRect cropFrame;


- (instancetype)initWithImage:(UIImage *)originalImage cropFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio;

@end
