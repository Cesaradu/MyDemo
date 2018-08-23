//
//  SignatureView.h
//  Demo
//
//  Created by hztuen on 2017/6/30.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignatureView : UIView

@property (nonatomic, strong) UIColor *pathColor;//画笔颜色
@property (nonatomic, assign) CGFloat pathWidth;//画笔粗细

- (void)clearSignature; //清除签名

@end
