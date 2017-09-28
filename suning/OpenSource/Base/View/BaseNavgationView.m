//
//  NavgationView.m
//  happy
//
//  Created by chenhaojie on 15/6/2.
//  Copyright (c) 2015年  tsunami All rights reserved.
//

#import "BaseNavgationView.h"
@interface BaseNavgationView ()
{
 
    

}
@end

@implementation BaseNavgationView
@synthesize leftButton;
@synthesize titleLabel;
@synthesize rightButton;



/**
 *  功能:创建视图
 *
 *  参数: frame frame
 */
-(void)createMainViewWithFrame:(CGRect)frame
{
    
    [self setFrame:frame];
    [self setBackgroundColor:c2D88D4];
    
    [self setUserInteractionEnabled:YES];
    
    //----左侧按钮-----
    
    UIButton*tmpLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tmpLeftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [tmpLeftButton setImage:[UIImage imageNamed:@"bt_jiantou_fanhui.png"] forState:UIControlStateNormal];
    [tmpLeftButton setImage:[UIImage imageNamed:@"bt_jiantou_fanhui.png"] forState:UIControlStateHighlighted];
    
    [self addSubview:tmpLeftButton];
    leftButton = tmpLeftButton;
    
    
    //--- 标题----
    
    UILabel* tmpTitleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    
    [tmpTitleLabel setFont:kBoldFontSizeExplanation_17];
    [tmpTitleLabel setTextColor:[UIColor whiteColor]];
    [tmpTitleLabel setTextAlignment:1];
    [self addSubview:tmpTitleLabel];
    titleLabel = tmpTitleLabel;
    
    
    //----右侧按钮------
    
    UIButton*tmpRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tmpRightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tmpRightButton];
    self.rightButton = tmpRightButton;
    
    
    
    //设置坐标
    [leftButton setFrame:CGRectMake(0, 0, 60, 44)];
    UIEdgeInsets  rightLefttitleEdgeInset = {13,15,13,33};
    [leftButton setImageEdgeInsets:rightLefttitleEdgeInset];
    [leftButton.titleLabel setTextAlignment:0];
    
    [rightButton setFrame:CGRectMake(CGRectGetWidth(self.frame)-75, 0, 60, 44)];
    [rightButton.titleLabel setTextAlignment:2];
    UIEdgeInsets rightTitleEdgeInset = {7,30,7,0};
     [rightButton setTitleEdgeInsets:rightTitleEdgeInset];
    CGFloat titleLabelStartX = CGRectGetMaxX(leftButton.frame);
    CGFloat titleLableWidth  = CGRectGetMinX(rightButton.frame)- titleLabelStartX;
    [titleLabel setFrame:CGRectMake(titleLabelStartX, 0, titleLableWidth, 44)];
    

}

/**
 *  功能:左侧按钮点击响应时间
 *
 *  参数: button  button对象
 */
-(void)leftButtonAction:(UIButton*)button{

    if (self.leftButtonBlock) {
        self.leftButtonBlock();
    }

}


/**
 *  功能:右侧按钮点击响应事件
 *
 *  参数: button  button对象
 */
-(void)rightButtonAction:(UIButton*)button{

    if (self.rightButtonBlock) {
        self.rightButtonBlock();
    }


}




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
                rightButtonTitleColor:(UIColor*)rightColor{


//    [leftButton setTitle:leftTitle forState:UIControlStateNormal];
//    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    
    
    
    
    [titleLabel setText:titleStr];
    
    
    
    [rightButton setTitle:rightTitle forState:UIControlStateNormal];
    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    

}




/**
 *  功能:设置子视图
 *  参数: titleStr  导航栏标题
 */
-(void)setNavTitle:(NSString*)titleStr
{
    
[titleLabel setText:titleStr];
}

/**
 *  功能:隐藏左侧按钮
 */
-(void)setHiddenLeftButton{

    self.leftButton.hidden = YES;

}

/**
 *  功能:隐藏右侧按钮
 */
-(void)setHiddenRightButton{



    self.rightButton.hidden = YES;

}

/**
 *  功能:设置右边按钮为普通按钮
 */
-(void)setRightButtonNormal{

    [self.rightButton.titleLabel setFont:kFontSizeExplanation_15];
}


/**
 *  功能:设置右边按钮为普通按钮
 */
-(void)setLeftButtonNormal{
    
    [self.leftButton.titleLabel setFont:kFontSizeExplanation_15];
}
@end
