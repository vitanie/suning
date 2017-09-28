/*
 *  OutLog.h
 *  LotteryClient
 *
 *  Created by Fish on 11-5-19.
 *  Copyright 2011 9thq.com. All rights reserved.
 *
 */

//---------------------------------------------------------------

/**
     用于网络调试，发送的包头包体及接收到的包头和包体
 */
#define OUT_LOG   //正式版本可以删除该宏


#ifdef OUT_LOG
#define NSLog(what, ...) printf("[文件名:%s%s]%s\n[函数名称:%s]\n",[[[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] stringByPaddingToLength:30 withString:@" " startingAtIndex:0] substringToIndex:30] UTF8String],[[[[NSString stringWithFormat:@"行数:%d",__LINE__] stringByPaddingToLength:4 withString:@" " startingAtIndex:0] substringToIndex:4] UTF8String],[[NSString stringWithFormat:(what), ##__VA_ARGS__] UTF8String],__FUNCTION__)
#else
#define NSLog(format,...)
#endif





