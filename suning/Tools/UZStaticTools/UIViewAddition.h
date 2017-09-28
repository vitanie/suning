//
//  ViewUtility.h
//  AXZ
//
//  Created by hao chentao on 12-2-19.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIView (Utility)

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

// 获取自身UIView的中心店
- (CGPoint)getViewCurrentCenter;


@end
