//
//  WaitView.h
//  LotteryClient
//
//  Created by 马寅生 on 13-10-22.
//  Copyright (c) 2012-2013 UUZZ All rights reserved.
//

/*
 功能：等待提示框
 其他：带GIF动画的等待提示框
 */
#import <UIKit/UIKit.h>

@interface WaitView : UIImageView 
{
    UIImageView *gifImageView;                     //GIF动画View
    double angle;
    BOOL isStopAnimation;//是否停止旋转
}
@property (retain, nonatomic) UIView *baseView; //背景透明层
@property (nonatomic, retain) UIImageView *bgView; //等待方形View
@property (nonatomic, retain) UIView *jdtBgView; //进度条View
@property (nonatomic, assign) float bgHeight;      //等待框高度
@property (nonatomic, assign) float bgStartY;      //等待框Y坐标
+(id)share;
/*
 * 功能：改变提示框可见区域大小及提示框内各控件位置(普通等待框)
 * 参数：width - 动态宽度 ； height - 动态高度
 */
- (void)changePositionWithWidth:(float)width AndHeight:(float)height;
/*
 * 功能：改变提示框可见区域大小及提示框内各控件位置(下载等待框)
 * 参数：width - 动态宽度 ； height - 动态高度
 */
- (void)changePositionWithWidthWithProcess:(float)width AndHeight:(float)height;
/*
 * 功能：开始动画
 */
-(void)startAnimation;
/*
 * 功能：停止动画
 */
-(void)stopAnimation;


-(void)showDalog;

-(void)closeDalog;

@end
