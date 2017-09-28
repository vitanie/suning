//
//  CustomPwdKeyBoard.h
//  jianpan
//  =====================================================
//  视图:自定义密码/身份证键盘
//  =====================================================
//  Created by Mr_Zhu on 15/2/4.
//  Copyright (c) 2015年 Mr_Zhu. All rights reserved.
//

/*
 *************暂时取消ios6效果,需要时打开注释*************
 *
 */
typedef enum {
    NumType = 1,    //随机数字
    cardType = 2,   //身份证
    doubelType = 3,  //倍数输入框
    smallType = 4   //小数点类型
}bordType;
#import <UIKit/UIKit.h>

@interface CustomPwdKeyBoard : UIControl
@property (assign, nonatomic) BOOL isNotBetting;    //控制可输入个数(YES输入多个,NO输入两个字符)
@property (copy, nonatomic) void (^removeBlock)();
@property (copy, nonatomic) void (^changeBlock)();
/**
 *  功能:初始化键盘
 *
 *  参数: view    加载的view
 *  参数: textView 文本框
 *  参数: type    键盘类型
 *
 *  返回值:当前对象
 */
+(id)shareWithView:(UIView *)view textViews:(id)textView bordType:(bordType)type;
//获取键盘高度
+(float)getKeyBoardHeight;
//暂时隐藏，不释放内存
+(void)removes;
//释放内存
+(void)release;
@end
