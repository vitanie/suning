//
//  NavgationView.h
//  happy
//
//  Created by chenhaojie on 15/6/2.
//  Copyright (c) 2015年  tsunami All rights reserved.
//
//  =====================================================
//  视图:自动以导航条
//  功能:动态和发现自定义导航条
//  =====================================================
#import <UIKit/UIKit.h>

@interface BaseNavgationView : UIView

@property(nonatomic,strong)UIButton*  leftButton;//左侧按钮
@property(nonatomic,strong)UILabel*  titleLabel;//标题
@property(nonatomic,strong)UIButton* rightButton;//右边按钮
@property(nonatomic,copy)void (^leftButtonBlock) ();//左侧按钮回调
@property(nonatomic,copy)void (^rightButtonBlock)();//右侧按钮回调


/**
 *  功能:创建视图
 *
 *  参数: frame frame
 */
-(void)createMainViewWithFrame:(CGRect)frame;

/**
 *  功能:左侧按钮点击响应时间
 *
 *  参数: button  button对象
 */
-(void)leftButtonAction:(UIButton*)button;


/**
 *  功能:右侧按钮点击响应事件
 *
 *  参数: button  button对象
 */
-(void)rightButtonAction:(UIButton*)button;
    

/**
 *  功能:设置子视图
 *
 *  参数: leftTitle 左侧按钮标题
 *  参数: leftColor 右侧按钮标题
 *  参数: titleStr  导航栏标题
 *  参数: rightTitle 右侧按钮标题
 *  参数: rightColor 左侧按钮标题
 */
-(void)setSubViewsWithLeftButtonTitle:(NSString*)leftTitle
                 leftButtonTitleColor:(UIColor*)leftColor
                                title:(NSString*)titleStr
                     rightButtonTitle:(NSString*)rightTitle
                rightButtonTitleColor:(UIColor*)rightColor;





/**
 *  功能:设置子视图
 *  参数: titleStr  导航栏标题
 */
-(void)setNavTitle:(NSString*)titleStr;


/**
 *  功能:隐藏左侧按钮
 */
-(void)setHiddenLeftButton;

/**
 *  功能:隐藏右侧按钮
 */
-(void)setHiddenRightButton;


/**
 *  功能:设置右边按钮为普通按钮
 */
-(void)setRightButtonNormal;
/**
 *  功能:设置右边按钮为普通按钮
 */
-(void)setLeftButtonNormal;


@end
