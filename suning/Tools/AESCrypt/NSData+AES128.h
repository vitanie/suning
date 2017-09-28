//
//  NSData+AES128.h
//  AES
//
//  Created by lad on 2012/11/12.
//  Copyright 2010 archermind Technology Co., Ltd.
//  All rights reserved.
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (AES128)

/**
 *	@brief	128位AES加密
 *
 *	@param 	key 	加密key
 *
 *	@return	密文
 */
- (NSData *)AES128EncryptWithKey:(NSString *)key;



/**
 *	@brief	128位AES解密
 *
 *	@param 	key 	解密key
 *
 *	@return	原文
 */
- (NSData *)AES128DecryptWithKey: (NSString *)key;


- (NSData *)AES256EncryptWithKey:(NSString *)key;   //加密

- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密
@end
