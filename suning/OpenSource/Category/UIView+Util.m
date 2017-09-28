//
//  ViewUtility.m
//  AXZ
//
//  Created by hao chentao on 12-2-19.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//

#import "UIView+Util.h"


@implementation UIView (Util)

// 设置UIView的X
- (void)setViewX:(CGFloat)newX
{
	CGRect viewFrame = [self frame];
	viewFrame.origin.x = newX;
	[self setFrame:viewFrame];
}

// 设置UIView的Y
- (void)setViewY:(CGFloat)newY
{
	CGRect viewFrame = [self frame];
	viewFrame.origin.y = newY;
	[self setFrame:viewFrame];
}

// 设置UIView的Origin
- (void)setViewOrigin:(CGPoint)newOrigin
{
	CGRect viewFrame = [self frame];
	viewFrame.origin = newOrigin;
	[self setFrame:viewFrame];
}

// 设置UIView的width
- (void)setViewWidth:(CGFloat)newWidth
{
	CGRect viewFrame = [self frame];
	viewFrame.size.width = newWidth;
	[self setFrame:viewFrame];
}

// 设置UIView的height
- (void)setViewHeight:(CGFloat)newHeight
{
	CGRect viewFrame = [self frame];
	viewFrame.size.height = newHeight;
	[self setFrame:viewFrame];
}

// 设置UIView的Size
- (void)setViewSize:(CGSize)newSize
{
	CGRect viewFrame = [self frame];
	viewFrame.size = newSize;
	[self setFrame:viewFrame];
}



- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color
{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

/**
 *  功能:将view转换成image
 *
 *  返回值:image
 */
- (UIImage *)convertViewToImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}


/**
 *  功能:高斯模糊
 *
 *  参数: image 原始图片
 *  参数: blur 模糊度
 *
 *  返回值: 高斯模糊图片
 */
+(UIImage *)blurryGPUImage:(UIImage *)image withBlurLevel:(NSInteger)blur {
 
    
    
    
    return nil;
    
}



/**
 *  功能:画虚线
 *
 *  参数: size 范围
 *  参数: imageView 将要绘制的imageView视图
 *
 */
+(void)dashLineSize:(CGSize)size imageView:(UIImageView*)imageView{

   
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapSquare);  //设置线条终点形状
    
    
    CGFloat lengths[] = {10,5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, cCECECE.CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 1);    //开始画线
    CGContextAddLineToPoint(line, imageView.frame.size.width, 1);
    CGContextStrokePath(line);
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
}

/**
 *  功能:画虚线
 *
 *  参数: size 范围
 *  参数: imageView 将要绘制的imageView视图
 *
 */
+(void)dashLineSize:(CGSize)size imageView:(UIImageView*)imageView color:(UIColor*)lineColor
{
    
    
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapSquare);  //设置线条终点形状
    
    
    CGFloat lengths[] = {5,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, lineColor.CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 1);    //开始画线
    CGContextAddLineToPoint(line, imageView.frame.size.width, 1);
    CGContextStrokePath(line);
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
}

/**
 *  功能:画虚线
 *
 *  参数: size 范围
 *  参数: imageView 将要绘制的imageView视图
 *
 */
+(void)stokeLineSize:(CGSize)size imageView:(UIImageView*)imageView 
{
    
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
   
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapSquare);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 255.0, 255.0, 255.0, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0, imageView.frame.size.height+1);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), imageView.frame.size.width, -1);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();


}

/**
 *  功能:将view 转换成图片
 *
 *  参数: view view视图
 *
 *  返回值: image对象
 */
+(UIImage *)convertViewToImageWithView:(UIView*)view
{
    
    UIGraphicsBeginImageContext(view.bounds.size);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}


+(UIView *)createView:(id)parents :(int )tag :(CGRect) rect :(UIColor *) backColor
{
    UIView * view  = [[UIView alloc] initWithFrame:rect];
#ifdef DEBUG_UI_POS
    view.backgroundColor = createRandomColor();
#else
    view.backgroundColor = backColor;
#endif
    view.tag = tag;
    [parents addSubview:view];
    return view;
}
@end
