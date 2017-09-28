//
//  UZAssist.m
//  UZLottery
//
//  Created by kevin on 28/7/15.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "UZAssist.h"
#import <UIKit/UIKit.h>


#pragma mark mark    给色值生成图片
/**
 *  功能:给色值生成图片(给Btn背景使用)
 *
 *  参数: color 色值
 *
 *  返回值:图
 */
UIImage* imageWithColor(UIColor* color)
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


