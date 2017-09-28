//
//  ViewUtility.h
//  AXZ
//
//  Created by hao chentao on 12-2-19.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Util)

// 设置UIView的X
- (void)setViewX:(CGFloat)newX;

// 设置UIView的Y
- (void)setViewY:(CGFloat)newY;

// 设置UIView的Origin
- (void)setViewOrigin:(CGPoint)newOrigin;

// 设置UIView的width
- (void)setViewWidth:(CGFloat)newWidth;

// 设置UIView的height
- (void)setViewHeight:(CGFloat)newHeight;

// 设置UIView的Size
- (void)setViewSize:(CGSize)newSize;



- (void)setCornerRadius:(CGFloat)cornerRadius;
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color;

/**
 *  功能:将view转换成image
 *
 *  返回值:image
 */
- (UIImage *)convertViewToImage;
/**
 *  功能:高斯模糊
 *
 *  参数: image 原始图片
 *  参数: blur 模糊度
 *
 *  返回值: 高斯模糊图片
 */
+(UIImage *)blurryGPUImage:(UIImage *)image withBlurLevel:(NSInteger)blur;



/**
 *  功能:画虚线
 *
 *  参数: size 范围
 *  参数: imageView 将要绘制的imageView视图
 *
 */
+(void)dashLineSize:(CGSize)size imageView:(UIImageView*)imageView;

+(void)dashLineSize:(CGSize)size imageView:(UIImageView*)imageView color:(UIColor*)lineColor;
/**
 *  功能:画虚线
 *
 *  参数: size 范围
 *  参数: imageView 将要绘制的imageView视图
 *
 */
+(void)stokeLineSize:(CGSize)size imageView:(UIImageView*)imageView ;

/**
 *  功能:将view 转换成图片
 *
 *  参数: view view视图
 *
 *  返回值: image对象
 */
+(UIImage *)convertViewToImageWithView:(UIView*)view;
+(UIView *)createView:(id)parents :(int )tag :(CGRect) rect :(UIColor *) backColor;
@end
