//
//  UIImage+Util.h
//  Happy
//
//  Created by chenhaojie on 15/8/4.
//  Copyright © 2015年 tsunami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)
/**
 *  功能:给色值生成图片(给Btn背景使用)
 *
 *  参数: color 色值
 *
 *  返回值:图
 */
+(UIImage*)imageWithColor:(UIColor*) color;



+ (UIImage *)fixOrientation:(UIImage *)aImage;
@end
