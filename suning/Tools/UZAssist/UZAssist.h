//
//  UZAssist.h
//  UZLottery
//
//  Created by kevin on 28/7/15.
//  Copyright (c) 2015年 kevin. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UZAssist : NSObject

#define firstInQXC @"firstInQXC"
#define firstInPai5 @"Pai5"
#define firstInDLT @"firstInDLT"

#define firstInPai3 @"Pai3"

#define firstInHN4P1 @"HN4P1"

#define firstInJCZQ @"JCZQ"

#define guidanceGap 12

//显示说明  TestFiled Font
#define kFontSizeExplanation_12 [UIFont systemFontOfSize:12.0f]

//获取当前window的宽度
#define kWindowWidth  CGRectGetWidth([UIScreen mainScreen].bounds)

//获取当前window的高度
#define kWindowHeight  CGRectGetHeight([UIScreen mainScreen].bounds)

//获取系统版本
#define kUZversion [[[[[UIDevice currentDevice] systemVersion] description]substringToIndex:1]integerValue]

//取得系统底层控制器
#define kRootViewController [UIApplication sharedApplication].keyWindow.rootViewController
//取得系统代理
#define kAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//Navigation上面控件的minY
#define kStateBarHeight   ((kUZversion >= 10)?(40.0f):(20.0f))
//Navigation的高度
#define kNavigationHeight 64.0f
#define kNavigationBarHeight ((kUZversion >= 10)?(64.0f):(44.0f))
//TabBar的高度
#define kTabbarHeight ((kUZversion >= 7)?(49.0f):(49.0f))
//Navigation的颜色
#define kNavigationColor [UIColor colorWithRed:34.0/255 green:136.0/255 blue:212.0/255 alpha:1]
//Button的颜色
#define kButtonColor [UIColor colorWithRed:52.0/255 green:152.0/255 blue:219.0/255 alpha:1]

//黑色投影透明%50
#define kShadowBlockColor [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.5]
//银灰背景
#define kBackGroundColor [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1]
//TextField 分割线颜色
#define kTextLineColor [UIColor colorWithRed:209.0/255 green:209.0/255 blue:209.0/255 alpha:1]
//TextField标题颜色
#define kTextFontColor [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1]
//TextField标题颜色
#define kTextOrangeColor [UIColor colorWithRed:251.0/255 green:146.0/255 blue:88.0/255 alpha:1]
//浅灰色文字颜色
#define kFontGrayColor [UIColor colorWithRed:191.0/255 green:191.0/255 blue:191.0/255 alpha:1]
//红色文字颜色
#define kFontRedColor [UIColor colorWithRed:252.0/255 green:55.0/255 blue:61.0/255 alpha:1]
//找回密码提示语颜色
#define kTishiFontColor [UIColor colorWithRed:189.0/255 green:195.0/255 blue:199.0/255 alpha:1]
//开奖红球颜色
#define kRedBallColor [UIColor colorWithRed:212.0/255 green:56.0/255 blue:59.0/255 alpha:1]
//开奖绿球颜色
#define kGreenBallColor [UIColor colorWithRed:121.0/255 green:176.0/255 blue:33.0/255 alpha:1]
//草绿色文字
#define kGreenTextColor [UIColor colorWithRed:142.0/255 green:190.0/255 blue:80.0/255 alpha:1]


//直播进行中的绿色
#define kLiveSportsGreenTextColor [UIColor colorWithRed:55.0/255 green:210.0/255 blue:52.0/255 alpha:1]
//浅灰色背景
#define kBGGrayColor [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]

//浅红色背景
#define  kBGRedColor [UIColor colorWithRed:253/255.0 green:148/255.0 blue:149/255.0 alpha:1]

//浅蓝色背景
#define kBGBlueColor [UIColor colorWithRed:155/255.0 green:212/255.0 blue:252/255.0 alpha:1]

//开奖蓝球颜色
#define kBlueBallColor [UIColor colorWithRed:34.0/255 green:136.0/255 blue:212.0/255 alpha:1]
//高清 1 像素 分割线
#define kSingleLineHeight   ((1 / [UIScreen mainScreen].scale) / 2)
//高清 1 像素 分割线颜色
#define kSingleLineColor [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1]

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)

#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

#pragma mark mark    给色值生成图片
/**
 *  功能:给色值生成图片(给Btn背景使用)
 *
 *  参数: color 色值
 *
 *  返回值:图
 */
UIImage* imageWithColor(UIColor* color);

#pragma mark mark    16进制颜色转换
/**
 *  功能:16进制颜色转换
 *
 *  参数: color:16进制颜色
 *
 *  返回值:颜色
 */
UIColor *colorWithHexString(NSString *color);

@end
