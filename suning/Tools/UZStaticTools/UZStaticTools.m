//
//  UZStaticTools.m
//  UZLottery
//
//  Created by kevin on 28/7/15.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "UZStaticTools.h"

@implementation UZStaticTools
//获取系统的高度
+ (float)getWindowHeight
{
    return  (kUZversion >= 7)?(CGRectGetHeight([UIScreen mainScreen].applicationFrame)+20):CGRectGetHeight([UIScreen mainScreen].applicationFrame);//获取当前window的高度
    
}
//NSDate 转 周期
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

/*  功能:获取urlscheme
*
*  返回值:urlscheme
*/
+(NSString *)urlScheme{
    //    CFBundleURLTypes =     (
    //                            {
    //                                CFBundleTypeRole = Editor;
    //                                CFBundleURLSchemes =             (
    //                                                                  uzlottery
    //                                                                  );
    //                            },
    //                            {
    //                                CFBundleTypeRole = Editor;
    //                                CFBundleURLSchemes =             (
    //                                                                  uzlottery1
    //                                                                  );
    //                            }
    //                            );
    
    
    //---获取---系统info-plist -infoDictory  -数组
    
    NSDictionary *infoDictory = [[NSBundle mainBundle]infoDictionary];
    //-----CFBundleURLTypes--
    NSArray *urlTypes = [infoDictory objectForKey:@"CFBundleURLTypes"];
    
    //---默认获取第一个-----
    
    
    NSString * urlScheme  = nil;
    
    if ([urlTypes count]>0) {
        
        NSDictionary * urlTypeDictory = [urlTypes objectAtIndex:0];
        
        NSArray * urlSchemes = [urlTypeDictory objectForKey:@"CFBundleURLSchemes"];
        
        if ([urlSchemes count]>0) {
            
            urlScheme = [urlSchemes objectAtIndex:0];
        }
        
        
        
    }
    return urlScheme;
    
    
}



@end
