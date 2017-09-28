//
//  NSString+Base64.h
//  Gurpartap Singh
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh. All rights reserved.
//

#import <Foundation/NSString.h>

@interface NSString (Base64Additions)
//base64加密
+ (NSString *)base64StringFromData:(NSData *)data length:(int)length;
//base64解密
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

@end
