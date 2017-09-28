//
//  NSString+Encrypt.h
//  Lottery
//
//  Created by Lad on 12-11-8.
//  Copyright (c) 2012年 archermind. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSString+Encrypt.h"




@interface NSString(EncryptEx)

/**
 *	@brief	加密模式0加密
 *
 *	@return	密文
 */
-(NSString *)encryptWithMode0;

/**
 *	@brief	解密模式0解密
 *
 *	@return	原文
 */
-(NSString *)decryptWithMode0;

/**
 *	@brief	加密模式1加密
 *
 *	@param 	key 	加密时的key
 *
 *	@return	密文
 */
-(NSString *)encryptWithMode4ByKey:(NSString *)key;

/**
 *	@brief	解密模式1解密
 *
 *	@param 	key 	解密时的key
 *
 *	@return	原文
 */
-(NSString *)decryptWithMode4ByKey:(NSString *)key;




-(NSString *)encryptWithMode3ByKey:(NSString *)key;

-(NSString *)decryptWithMode3ByKey:(NSString *)key;

/**
 *	@brief	RSA加密字符串（本项目中采用证书公钥加密AES中的key传给服务器用私钥解密key）
 *
 *	@param 	cerPath 	加密时的证书绝对路径
 *
 *	@return	加密密文
 */
-(NSString *)rsaEncryptAndBase64Encode:(NSString *)cerPath;


-(NSString *)stringFromHex;


-(NSString *)stringToHex;
@end

