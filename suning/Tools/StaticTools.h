//
//  StaticTools.h
//  MailPlus
//
//  Created by Fish on 09-11-20.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PUSHTAG @"pushTag" //消息通知的key值

#define Iphone5Scale    3    //分辨率 iphone5
#define Iphone6Scale    4    //分辨率 iphone6
#define Iphone6PScale   5    //分辨率 iphone6P

@interface StaticTools : NSObject {

    
}

/**
 *  获取显示不同颜色的秒数
 *
 *  @param body   数据返回体
 *  @param second 秒数
 *
 *  @return 返回可以标颜色的字符串
 */
+ (NSAttributedString *)getClosingDate:(id)body Second:(NSInteger)second Title:(NSString *)title;

/**
 *  功能:获取设备名称根据屏幕尺寸返回（p3,p3gs->p3|p4,p4s->p4 |p5,p5c,p5s-p5|p6->p6 |p6plus->p6plus ）
 *
 *  返回值:设备平台
 */

+(NSString *)deviceName;
+(NSString*)getDeviceVersion;
//取到分 保留两位小数
+(NSString*)fenToyuan:(NSString*)fen;
//取整 舍角分
+(NSString*)yuan:(NSString*)fen;
//校验字符串是否为空
+(BOOL)isEmptyString:(NSString*)string;


//返回程序Decoument目录
+(NSString*)decoumentPath;

+(NSString*)getMlotTemplatePath:(NSString *)pid;
//转换0,0,0,0 rect字符串到 CGRect
+(CGRect)rectWithRectString:(NSString*)str_rect;

+(UIImage*)getImage:(NSString*)path;
+(BOOL)isContentStr:(NSString * )a b:(NSString *)b;
//转换0,0,0 RGB字符串到 UIColor
+(UIColor*)colorWithRGBString:(NSString*)str_color;

+(NSString*)formatFenToFinanceYuan:(int64_t)amount;
+(NSString*)formatFenToFinanceYuanNoDot:(int64_t)amount;
//获取模板压缩包目录
+(NSString*)getTemplateZipPathNew:(NSString*)zipName;
//解压缩文件
+(BOOL)uncompressZipFile:(NSString*)src_path toDir:(NSString*)target_dir;

+(NSString*)formatDateWithSourceFormater:(NSString*)sourceFormater
                             desFormater:(NSString*)desFormater
                              sourceTime:(NSString*)dateTime;


//验证密码复杂度
+ (BOOL)verifyPassWord:(NSString *)password;
//字符串去空格
+(NSString*)stringTrim:(NSString*)string;

//获取音频相关路径
+(NSString *)getAudioPath:(NSString *)fileName;
//删除系统通知栏里面的信息
+(void)deleteSysNotifications;

//获取当前分辨率
+(NSInteger)getVersion;

//旋转动作
+ (BOOL)rotateWithObject:(UIView*)aView rotate:(BOOL)aR;

+(NSString*)transLotteryImageName:(NSString*)lotteryId;

@end




