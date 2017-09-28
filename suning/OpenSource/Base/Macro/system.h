//
//  Image.h
//  Happy
//
//  Created by chenhaojie on 15/7/31.
//  Copyright © 2015年 tsunami. All rights reserved.
//

#ifndef Image_h
#define Image_h







#define arrowImageViewTag 0x4444
#define sectionHeaderViewTag 0x111

#define BLOCK(bself) __block typeof(self) bself = self
#define  acquireImage(name)   [UIImage imageNamed:name]      //获取本地图片
#define DESCLABEL_LENGTH  192
#define TEMPLATEZIP_DOWNLOAD_PATH_New           @"TemplatesZip/New"     //当前使用中的模板目录
#define TEMPLATEZIP_DOWNLOAD_PATH_Old           @"TemplatesZip/Old"     //保存旧的模板目录
#define TEMPLATE_CONFIG_FILENAME                @"config.uz"   //模板配置文件名
#define RES_DIR_TEMPLATE_PATH                   @"Templates"    //即开彩票模板目录
#define RES_DIR_DOWNLOAD_PATH                   @"Download"     //资源下载所在目录

#define CHECKCODEURL @"https://ticket.lottery.gov.cn/"
#define AFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES

#define saveUserName(userName) [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"]

#define getUserName  [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]
#define kCommomSpace  10
#define kDoubleCommomSpace  20


#endif /* Image_h */
