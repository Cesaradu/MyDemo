//
//  ScanUtil.h
//  Happybird_watch
//
//  Created by Oliver on 2018/2/9.
//  Copyright © 2018年 Oliver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScanUtil : NSObject

/**
 *  生成二维码图片
 *
 *  @param QRString  二维码内容
 *  @param sizeWidth 图片size（正方形）
 *  @param color     填充色
 *
 *  @return  二维码图片
 */
+ (UIImage *)createQRimageString:(NSString *)QRString sizeWidth:(CGFloat)sizeWidth fillColor:(UIColor *)color;

/**
 *  读取图片中二维码信息
 *
 *  @param image 图片
 *
 *  @return 二维码内容
 */
+ (NSString *)readQRCodeFromImage:(UIImage *)image;

@end
