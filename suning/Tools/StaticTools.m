//
//  StaticTools.m
//  MailPlus
//
//  Created by Fish on 09-11-20.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//



#include <sys/sysctl.h>
@implementation StaticTools


 /**
 *  获取显示不同颜色的秒数
 *
 *  @param body   数据返回体
 *  @param second 秒数
 *
 *  @return 返回可以标颜色的字符串
 */
+ (NSAttributedString *)getClosingDate:(id)body Second:(NSInteger)second Title:(NSString *)title
{
    NSString* status = [body objectForKey:@"status"];
    if ([status isEqualToString:@"0"]) {
        status = @"未开期";
    }
    else if([status isEqualToString:@"1"] && second != 0) {
        status = @"";
    }
    else if([status isEqualToString:@"2"]) {
        status = @"销售暂停";
    }
    else if([status isEqualToString:@"3"]|| second == 0) {
        status = @"已封期";
    }
    
    //天
    NSInteger d = second / (24*60*60);
    //小时
    NSInteger h = second % (24*60*60)/ (60*60);
    //分
    NSInteger f= second % (24*60*60) % (60*60) / 60;
    //秒
    NSInteger m = second % (24*60*60) % (60*60) % 60;
    
    
    //当前期号
    NSString* issue = [body objectForKey:@"issue"];
    
    NSString *isseStr = title;
    
    NSString *dates = nil;
    if ([[body objectForKey:@"status"] isEqualToString:@"1"] && second != 0) {
        
        dates = [NSString stringWithFormat:@" %@截止 %02ld:%02ld:%02ld:%02ld %@",issue,(long)d,h,f,m,status];
        if (d < 1) {
            dates = [NSString stringWithFormat:@" %@截止 %02ld:%02ld:%02ld %@",issue,h,f,m,status];
        }
        
    }else
    {

        dates = [NSString stringWithFormat:@" %@%@",issue,status];
    }
    

    
    NSString *string = [NSString stringWithFormat:@"%@%@",isseStr,dates];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, [string length])];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([isseStr length], [dates length])];
    
    return str;
}

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
    
    NSString *platform = [StaticTools getDeviceVersion];
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
//校验字符串是否为空
+(BOOL)isEmptyString:(NSString*)string
{
    if (string == nil) return YES;
    if ([string isEqual:[NSNull null]])  return YES;
    if ([string  isEqual: @""]) return YES;
    //去空格之后判断length是否为0
    //	NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    //	NSString* content = [string stringByTrimmingCharactersInSet:whitespace];
    if ([string length] == 0) return YES;
    
    
    return NO;
}


//返回程序Decoument目录
+(NSString*)decoumentPath
{
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
    
    return documentsDirectory;
}

//获取彩票模板路径
+(NSString*)getMlotTemplatePath:(NSString *)pid
{
    
    
    if ([StaticTools isEmptyString:pid]) {
        
        return nil;
    }
//    //提取出/后面的所有字符串
//    NSRange range = [temp rangeOfString:@"/" options: NSBackwardsSearch];
//    NSString *fileName  = [temp substringFromIndex:(range.location+range.length)];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* path = [[StaticTools decoumentPath] stringByAppendingPathComponent:RES_DIR_TEMPLATE_PATH];
    
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",pid]];
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    return path;
}


//转换0,0,0,0 rect字符串到 CGRect
+(CGRect)rectWithRectString:(NSString*)str_rect
{
    CGRect rect = CGRectZero;
    if (!str_rect) return rect;
    
    NSArray* array = [str_rect componentsSeparatedByString:@","];
    
    if ([array count] == 4)
    {
        rect.origin.x = [[array objectAtIndex:0] floatValue];
        rect.origin.y = [[array objectAtIndex:1] floatValue];
        rect.size.width = [[array objectAtIndex:2] floatValue];
        rect.size.height= [[array objectAtIndex:3] floatValue];
    }
    
    return rect;
}

//根据路径获取的图片
+(UIImage*)getImage:(NSString*)path
{
    //UIImage* _image = [[ImageCache shard] getImageData:path];
    
    return [UIImage imageWithContentsOfFile:path];
}



//字符串a是否包含字符串b

+(BOOL)isContentStr:(NSString * )a b:(NSString *)b{
    
    NSRange  range1 = [a rangeOfString:b];
    if (NSNotFound == range1.location) {
        
        return NO;
        
    }
    
    return YES;
    
}


//转换0,0,0 RGB字符串到 UIColor
+(UIColor*)colorWithRGBString:(NSString*)str_color
{
    if(!str_color) return [UIColor clearColor];
    
    NSArray* array = [str_color componentsSeparatedByString:@","];
    if ([array count] != 3) return [UIColor clearColor];
    
    int r = [[array objectAtIndex:0] intValue];
    int g = [[array objectAtIndex:1] intValue];
    int b = [[array objectAtIndex:2] intValue];
    
    if ((r >= 0 && r <= 255) &&
        (g >= 0 && g <= 255) &&
        (b >= 0 && b <= 255))
    {
        return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0];
    }
    
    return [UIColor clearColor];
}
//取到分 保留两位小数
+(NSString*)fenToyuan:(NSString*)fen
{
    NSString* yuan = [NSString stringWithFormat:@"%.2f",fen.longLongValue*1.0/100];;
    return yuan;
}
//取整 舍角分
+(NSString*)yuan:(NSString*)fen
{
    NSString* yuan = [NSString stringWithFormat:@"%lld",fen.longLongValue/100];
    return yuan;
}

+(NSString*)formatFenToFinanceYuan:(int64_t)amount{
    
    if (amount < 0) {
        amount = 0;
    }
    
    NSString* amount_string = [NSString stringWithFormat:@"%lld",amount];
    NSString* ret_string = @"0.00";
    NSUInteger len = [amount_string length];
    //如果amout_string 小于等于2位
    if (len <= 2)
    {
        //格式化字符串
        ret_string = [NSString stringWithFormat:@"0.%02lld",amount];
    }
    else
    {
        //分割字串
        //小数点前
        NSString* numberDot = [amount_string substringWithRange:NSMakeRange(0, len-2)];
        //小数点后
        NSString* dotNumber = [amount_string substringWithRange:NSMakeRange(len-2, 2)];
        
        
        NSArray *tmp = [numberDot componentsSeparatedByString:@""];
        NSNumberFormatter *numberStyle = [[NSNumberFormatter alloc] init];
        [numberStyle setNumberStyle:NSNumberFormatterDecimalStyle];
        numberDot = [numberStyle stringFromNumber:[NSNumber numberWithDouble:[[tmp objectAtIndex:0] doubleValue]]];
        //格式化字符串
        ret_string = [NSString stringWithFormat:@"%@.%@",numberDot,dotNumber];
        //释放空间
    }
    
    return ret_string;
}

+(NSString*)formatFenToFinanceYuanNoDot:(int64_t)amount{
    
    if (amount < 0) {
        amount = 0;
    }
    
    NSString* amount_string = [NSString stringWithFormat:@"%lld",amount];
    NSString* ret_string = @"0";
    NSUInteger len = [amount_string length];
    //如果amout_string 小于等于2位
    if (len > 2)
    {
        //去掉小数点
        NSString* numberDot = [amount_string substringWithRange:NSMakeRange(0, len-2)];
        ret_string = [NSString stringWithFormat:@"%@",numberDot];
    }
    
    NSArray *tmp = [ret_string componentsSeparatedByString:@""];
    NSNumberFormatter *numberStyle = [[NSNumberFormatter alloc] init];
    [numberStyle setNumberStyle:NSNumberFormatterDecimalStyle];
    ret_string = [numberStyle stringFromNumber:[NSNumber numberWithDouble:[[tmp objectAtIndex:0] doubleValue]]];
    return ret_string;
    
}

//获取模板压缩包目录
+(NSString*)getTemplateZipPathNew:(NSString*)zipName
{
    //判断文件是否存在
    NSFileManager* fileManager = [NSFileManager defaultManager];
    //bundle目录
    NSMutableString* path_1 = [NSMutableString string];
    [path_1 appendFormat:@"%@/%@/%@",[[NSBundle mainBundle] resourcePath],RES_DIR_TEMPLATE_PATH,zipName];
    
    //New目录
    NSString* path = [NSString stringWithFormat:@"%@/%@",[StaticTools decoumentPath],TEMPLATEZIP_DOWNLOAD_PATH_New];
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSMutableString* path_2 = [NSMutableString string];
    [path_2 appendFormat:@"%@/%@",path,zipName];
    
    NSLog(@"path_2: %@",path_2);
    
    //old目录
    NSString* old = [NSString stringWithFormat:@"%@/%@",[StaticTools decoumentPath],TEMPLATEZIP_DOWNLOAD_PATH_Old];
    [fileManager createDirectoryAtPath:old withIntermediateDirectories:YES attributes:nil error:nil];
    NSMutableString* path_3 = [NSMutableString string];
    [path_3 appendFormat:@"%@/%@",old,zipName];
    
    NSLog(@"path_2: %@",path_3);
    
    //判断目录
    if([fileManager fileExistsAtPath:path_2]) return path_2;
    if([fileManager fileExistsAtPath:path_3]) return path_3;
    if([fileManager fileExistsAtPath:path_1]) return path_1;
    
    return nil;
}



//解压缩文件
+(BOOL) uncompressZipFile:(NSString*)src_path toDir:(NSString*)target_dir ;
{
    if (!src_path) return NO;
    
    //实例化
    ZipArchive* zip = [[ZipArchive alloc] init];
    BOOL ret = NO;
    //打开文件
    // unit.templetePassord
    if ([zip UnzipOpenFile:src_path Password:@"123456"])
    {
        //解压文件，当文件解压失败删除模板文件
        ret = [zip UnzipFileTo:target_dir overWrite:YES];
        if (!ret) {
            NSError *err = nil;
            NSFileManager *man = [NSFileManager defaultManager];
            [man removeItemAtPath:src_path error:&err];
            [man removeItemAtPath:target_dir error:&err];
            
        }
        [zip UnzipCloseFile];
    }
    

    return ret;
}

//验证密码复杂度
+ (BOOL)verifyPassWord:(NSString *)password
{
    if([StaticTools isEmptyString:password]){
        return YES;
    }
    if([[password stringByReplacingOccurrencesOfString:[password substringWithRange:NSMakeRange(0, 1)] withString:@""] isEqualToString:@""]){
        return YES;
    }
    else{
        NSString *string1 = @"012345678901234567890123456789";
        NSString *string2 = @"987654321098765432109876543210";
        NSRange range = [string1 rangeOfString:password];
        NSRange range1 = [string2 rangeOfString:password];
        if(range.length > 0 || range1.length > 0){
            return YES;
        }
    }
    return NO;
}

+(NSString*)formatDateWithSourceFormater:(NSString*)sourceFormater
                             desFormater:(NSString*)desFormater
                              sourceTime:(NSString*)dateTime {

    //设置日期格式 yyyy-MM-dd
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:sourceFormater];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    //时间设置为最近1周
    NSDate *beginDate = [dateFormatter dateFromString:dateTime];
    [dateFormatter setDateFormat:desFormater];
    return  [dateFormatter stringFromDate:beginDate];
}
//字符串去空格
+(NSString*)stringTrim:(NSString*)string
{
    NSMutableString *retString = [NSMutableString stringWithString:string];
    CFStringTrimWhitespace((CFMutableStringRef)retString);
    
    return retString;
}


//获取音频相关路径
+(NSString *)getAudioPath:(NSString *)fileName
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    
    return path;
}
//删除系统通知栏里面的信息
+(void)deleteSysNotifications{
    
    
    //处理推送消息，将消息栏的信息全部删除
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    UIApplication* applicationa = [UIApplication sharedApplication];
    NSArray* scheduledNotifications = [NSArray arrayWithArray:applicationa.scheduledLocalNotifications];
    [UIApplication sharedApplication].scheduledLocalNotifications = scheduledNotifications;
    
    
}

//获取当前分辨率
+(NSInteger)getVersion
{
    
    /**
     * 0x | 01 01 0220
     * 分成三部分：01 01 0100，第一部分代表平台，第二部分代表屏幕，第三部分代表软件版本
     */
    
    //屏幕尺寸
    NSInteger height = (NSInteger)[[UIScreen mainScreen] bounds].size.height;
    
    //像素点
    NSInteger scale = (NSInteger)[[UIScreen mainScreen] scale];
    
    // Iphone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)  {
        
        /**
         * 单像素
         * Iphone3
         */
        if (scale == 1) {
            
            return Iphone5Scale;
        }
        /**
         * 双像素
         * Iphone4
         * Iphone5
         */
        else if (scale == 2)
        {
            //iphone5
            if (height == 568) {
                
                return Iphone5Scale;
                
            }
            
            //iphone6
            else if (height == 667)
            {
                return Iphone6Scale;
                
            }
            //Iphone4
            else if (height == 480)
            {
                return Iphone5Scale;
            }
        }
        //Iphone6P
        else if (scale == 3)
        {
            
            //iphone6
            if (height == 667)
            {
                return Iphone6Scale;
                
            }
            return Iphone6PScale;
            
        }
        
    }
    // Ipad
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        /**
         * 单像素
         * Ipad1
         * Ipad2
         * Ipad Mini
         */
        if (scale == 1) {
            
            return Iphone6PScale;
        }
        /**
         * 双像素
         * Ipad3
         * Ipad4
         */
        else if (scale == 2)
        {
            return Iphone6PScale;
        }
    }
    
    
    return Iphone6PScale;
    
}

//旋转动作
+ (BOOL)rotateWithObject:(UIView*)aView rotate:(BOOL)aR
{
    __block BOOL isR = aR;
    if (isR) {
        [UIView animateWithDuration:0.3 animations:^{
            aView.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            
        }];
        isR = NO;
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            aView.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
            
        }];
        isR = YES;
    }
    
    return isR;
}
+(NSString*)transLotteryImageName:(NSString*)lotteryId
{
    NSString *lotteryImageName = @"";
    
    if([lotteryId isEqualToString:TC_SYY]){
        lotteryImageName = @"11选5.png";
    } else if([lotteryId isEqualToString:TC_DLT]){
        lotteryImageName = @"大乐透.png";
    } else if([lotteryId isEqualToString:TC_KLPK]){
        lotteryImageName = @"快乐扑克.png";
    } else if([lotteryId isEqualToString:FC_SSQ]){
        lotteryImageName = @"双色球.png";
    } else if([lotteryId isEqualToString:FC_3D]){
        lotteryImageName = @"3D.png";
    } else if([lotteryId isEqualToString:FC_QLC]){
        lotteryImageName = @"七乐彩.png";
    } else if([lotteryId isEqualToString:FC_SSC]){
        lotteryImageName = @"logo_big_ssc@2x.png";
    } else if([lotteryId isEqualToString:JC_FOOTBAL]){
        lotteryImageName = @"logo_big_tc@2x.png";
    } else if([lotteryId isEqualToString:TC_PL3]){
        lotteryImageName = @"排列3.png";
    } else if([lotteryId isEqualToString:TC_PL5]){
        lotteryImageName = @"排列5.png";
    } else if([lotteryId isEqualToString:TC_QXC]){
        lotteryImageName = @"七星彩.png";
    } else if([lotteryId isEqualToString:FC_QYH]){
        lotteryImageName = @"群英会.png";
    } else if([lotteryId isEqualToString:FC_K3]){
        lotteryImageName = @"快3.png";
    } else if([lotteryId isEqualToString:FC_KLSF]){
        lotteryImageName = @"logo_big_dlt@2x.png";
    } else if([lotteryId isEqualToString:FC_X5]){
        lotteryImageName = @"23选5.png";
    } else if([lotteryId isEqualToString:JCZQ]){
        lotteryImageName = @"竞彩足球.png";
    } else if([lotteryId isEqualToString:JCLQ]){
        lotteryImageName = @"竞彩篮球.png";
    } else {
        lotteryImageName = @"大乐透.png";
    }
    
    return lotteryImageName;
    
}
@end
