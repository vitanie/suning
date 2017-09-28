//
//  ICLabel.h
//  Lottery
//
//  Created by hao chentao on 13-5-15.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICLabel : UILabel

/**
 *功能：自定义初始化标签
 *str-内容|warp-是否折行|rect-范围|color-文字颜色|bgcol-文字背景色|strfont-文字字体 
 */
- (id)initWithCustomeStr:(NSString *)str isWarping:(BOOL)warp re:(CGRect)rect col:(UIColor *)color bgCol:(UIColor *)bgcol fon:(UIFont *)strfont;

@end
