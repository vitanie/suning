//
//  ICCLabel.h
//  Lottery
//
//  Created by chenhaojie on 13-8-16.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//

//  =====================================================
//  视图:自定义UILabel实现不同文字 自动居中对齐
//  功能:自定义UILabel实现不同文字 自动居中对齐
//  =====================================================

#import <UIKit/UIKit.h>

@interface ICCLabel : UIView

@property(atomic,copy)NSString *text;
@property(atomic,retain)UIFont *font;
@property(nonatomic,copy)NSString* baseText;
@property(atomic,retain)UIColor *textColor;



- (id)initWithFrame:(CGRect)frame font:(UIFont *)afont  text:(NSString *)atext;

- (id)initWithFrame:(CGRect)frame font:(UIFont *)afont  text:(NSString *)atext textCount:(NSString *)baseText textColor:(UIColor*)textColor;

@end
