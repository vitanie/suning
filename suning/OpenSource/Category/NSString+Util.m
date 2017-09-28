//
//  NSString+Util.m
//  Happy
//
//  Created by chenhaojie on 15/8/1.
//  Copyright © 2015年 tsunami. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

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
+(CGSize)getStringSize:(NSString *)str width:(float)witdh height:(float) height font:(UIFont *)font
{

    
    
    
    return [str boundingRectWithSize:CGSizeMake(witdh, MAXFLOAT)
                             options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:@{NSFontAttributeName:font}
                             context:nil].size;;


}


/**
 *  功能:是否事空对象
 *  返回值: bool类型变量
 */
+(BOOL)isEmptyStr:(NSString*)string{

    if (string == nil) return YES;
    if ([string isEqual:[NSNull null]])  return YES;
    if ([string length] == 0) return YES;
    return NO;
}



/**
 *  功能:是否是电子邮件地址
 *
 *  返回值: bool变量
 */
-(BOOL)isEMail
{

    NSString *emailRegex = @"^(([0-9a-zA-Z]+)|([0-9a-zA-Z]+[-_.0-9a-zA-Z]*[0-9a-zA-Z]+))@[a-zA-Z0-9]+([.][a-zA-Z]+){1,2}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL bo = [emailTest evaluateWithObject:self];
    
    if (bo == 0) {
        
        
        return NO;
    }
    
    return  YES;

}




#pragma mark mark --------- 判断字符串是否是合法手机号
+(BOOL) checkIsPhoneString:(NSString *)string
{
    
    if ([string length] != 11) {
        
        return NO;
    }
    return YES;
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSString  *tel = @"^[1]([3-8][0-9]{1})[0-9]{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextesttel = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", tel];
    if (([regextestmobile evaluateWithObject:string] == YES)
        || ([regextestcm evaluateWithObject:string] == YES)
        || ([regextestct evaluateWithObject:string] == YES)
        || ([regextestcu evaluateWithObject:string] == YES)
        || ([regextesttel evaluateWithObject:string] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
/**
 *  功能:格式化时间
 *
 *  参数: source 原始格式
 *  参数: des   最终显示的格式
 *
 *  返回值:时间戳
 */
-(NSString *)getFormateStringSource:(NSString*)source des:(NSString*)des
{
    
    if ([NSString isEmptyStr:self]) {
        
        return @"";
    }
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:source];//@"yyyyMMdd"
    NSDate *date=[dateFormatter dateFromString:self];
    [dateFormatter setDateFormat:des];//@"yyyy-MM-dd"
    return [dateFormatter stringFromDate:date];
}

-(BOOL)containsString:(NSString *)string{

    
    NSRange range = [self rangeOfString:string];
    return range.location != NSNotFound ?YES:NO;
}

- (BOOL)isEmpty{

    if (self == nil) return YES;
    if ([self isEqual:[NSNull null]])  return YES;
    if ([self length] == 0) return YES;
    return NO;
}

- (CGSize)sizeWithWidth:(float)witdh height:(float)height font:(UIFont *)font{


    return [self boundingRectWithSize:CGSizeMake(witdh, MAXFLOAT)
                             options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:@{NSFontAttributeName:font}
                             context:nil].size;;
}
@end
