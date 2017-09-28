//
//  ViewUtility.m
//  AXZ
//
//  Created by hao chentao on 12-2-19.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//

#import "UIViewAddition.h"


@implementation UIView (Utility)

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

// 获取自身UIView的中心点
- (CGPoint)getViewCurrentCenter
{
    CGRect viewFrame = [self frame];
    
    return CGPointMake(CGRectGetWidth(viewFrame)/2, CGRectGetHeight(viewFrame)/2);

}

@end
