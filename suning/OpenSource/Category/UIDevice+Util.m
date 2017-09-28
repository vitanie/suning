//
//  UIDevice+UIDevice_Util.m
//  Happy
//
//  Created by chenhaojie on 15/8/25.
//  Copyright © 2015年 tsunami. All rights reserved.
//

#import "UIDevice+Util.h"
#include <sys/sysctl.h>
@implementation UIDevice (Util)

+(NSString*)getDeviceVersion
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    //NSString *platform = [NSStringstringWithUTF8String:machine];二者等效
    free(machine);
    return platform;
}

/**
 *  功能:获取设备名称根据屏幕尺寸返回（p3,p3gs->p3|p4,p4s->p4 |p5,p5c,p5s-p5|p6->p6 |p6plus->p6plus ）
 *
 *  返回值:设备平台
 */

+(NSString *)deviceName{
    
    NSString *platform = [UIDevice getDeviceVersion];
    if([platform rangeOfString:@"iPod4"].location !=NSNotFound){
        
        platform =@"iPhone4,1";
        
    }else if([platform rangeOfString:@"iPod5"].location !=NSNotFound){
        
        platform = @"iPhone5,1";
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"iPhone2",@"iPhone1,1",
                          @"iPhone3",@"iPhone1,2",
                          @"iPhone3",@"iPhone2,1",
                          @"iPhone4",@"iPhone3,1",
                          @"iPhone4",@"iPhone3,2",
                          @"iPhone4",@"iPhone3,3",
                          @"iPhone4",@"iPhone4,1",
                          @"iPhone5",@"iPhone5,1",
                          @"iPhone5",@"iPhone5,2",
                          @"iPhone5",@"iPhone5,3",
                          @"iPhone5",@"iPhone5,4",
                          @"iPhone5",@"iPhone6,1",
                          @"iPhone5",@"iPhone6,2",
                          @"iPhone6Plus",@"iPhone7,1",
                          @"iPhone6",@"iPhone7,2", nil];
    
    return  [dict objectForKey:platform];
    
}
@end
