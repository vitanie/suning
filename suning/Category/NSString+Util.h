//
//  NSString+Util.h
//  Happy
//
//  Created by chenhaojie on 15/8/1.
//  Copyright © 2015年 tsunami. All rights reserved.
//

#import <Foundation/Foundation.h>

#define compareStr(a,b) [a isEqualToString:b]

@interface NSString (Util)
/**
 *  功能:计算字符串的宽度
 *
 *  参数: str   字符串内容
 *  参数: witdh 宽
 *  参数: height高
 *  参数: font  字体
 *
 *  返回值:字符串的size
 */
+(CGSize)getStringSize:(NSString *)str width:(float)witdh height:(float) height font:(UIFont *)font;


/**
 *  功能:是否事空对象
 *  返回值: bool类型变量
 */
+(BOOL)isEmptyStr:(NSString*)string;
+ (BOOL) checkIsPhoneString:(NSString *)string;



#pragma mark- new method
- (BOOL)isEMail;
- (NSString *)getFormateStringSource:(NSString*)source des:(NSString*)des;
- (BOOL)containsString:(NSString *)string;
- (BOOL)isEmpty;
- (CGSize)sizeWithWidth:(float)witdh height:(float)height font:(UIFont *)font;
@end
