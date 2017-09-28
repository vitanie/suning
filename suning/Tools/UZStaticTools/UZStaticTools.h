//
//  UZStaticTools.h
//  UZLottery
//
//  Created by kevin on 28/7/15.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UZStaticTools : NSObject
//获取系统的高度
+ (float)getWindowHeight;

//NSDate 转 周期
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
/*  功能:获取urlscheme
 *
 *  返回值:urlscheme
 */
+(NSString *)urlScheme;
@end
