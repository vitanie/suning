//
//  UIView+UIView_Toast.h
//  Lottery
//
//  Created by chenhaojie on 15/7/16.
//  Copyright © 2015年 UUZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToastView :UIView

@property(nonatomic,copy)void (^finishBlock)();
@property(nonatomic,retain)UIFont* textFont;

/**
 *  功能:显示带文字的toast
 *
 *  参数: string文本内容
 *  参数: width 显示宽度
 *  参数: parentView 父视图
 */
-(void)showToastWithStr:(NSString*)string  toastViewWidth:(CGFloat)width parentView:(UIView*)parentView;



/**
 *  功能:防伪码显示弹框
 *
 *  参数: checkCode 防伪码
 *  参数: startY 防伪码弹框起始y坐标
 *  参数: centerX  箭头中心点显示位置（相对坐标，需要转换）
 *  参数: parentView 父视图
 *  参数: maxwidth 最大宽度
 */
-(void)showPopView:(NSString*)checkCode   startY:(CGFloat)startY centerX:(CGFloat)centerX parentView:(UIView*)parentView toastViewMaxWidth:(CGFloat)maxwidth;


/**
 *  功能:超出2万提示框
 *
 *  参数: string文本内容
 *  参数: width 显示宽度
 *  参数: parentView 父视图
 */
-(void)showToastViewWithStr:(NSString*)string  toastViewWidth:(CGFloat)width parentView:(UIView*)parentView;

@end
