//
//  UIDevice+UIDevice_Util.h
//  Happy
//
//  Created by chenhaojie on 15/8/25.
//  Copyright © 2015年 tsunami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Util)
/**
 *  功能:获取设备名称根据屏幕尺寸返回（p3,p3gs->p3|p4,p4s->p4 |p5,p5c,p5s-p5|p6->p6 |p6plus->p6plus ）
 *
 *  返回值:设备平台
 */

+(NSString *)deviceName;
@end
