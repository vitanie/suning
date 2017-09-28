//
//  UIView.h
//  Lottery
//
//  Created by hao chentao on 13-5-15.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ICLabel;
@interface ICView : UIView

///**
// @功能: 初始化4场进球对阵详情界面
// @参数: sessions 对阵球队的场次数组
// @参数: parentView 父视图
// @返回值: 4场进球对阵详情界面
// */
//-(id)initWithSessionsArray:(NSArray *)sessions superView:(UIView *)parentView
//;

/**
 @功能: 创建公共的单元格
 @参数: frame 表格坐标系
 @参数: aflag 改变背景颜色
 @参数: parentView 父类视图
 @返回值: 斑马线单元格
 */
- (UIView *)createCellWidthFrame:(CGRect)frame flag:(BOOL)aflag parentView:(UIView *)parentView;



/**
 @功能: 创建label
 @参数: viewParent 父类
 @参数: rect 坐标
 @参数: text 文本内容
 @参数: color 背景颜色
 @参数: font 显示字体
 @参数: alignment 显示位置
 @返回值: label
 */
-(ICLabel *)createLable:(UIView *)viewParent
                  Frame:(CGRect)rect
                   Text:(NSString *)text
                  Color:(UIColor *)color
                   Font:(CGFloat)font
              Alignment:(UITextAlignment)alignment
;

@end
