//
//  NSString+Encrypt.m
//  Lottery
//
//  Created by Lad on 12-11-8.
//  Copyright (c) 2012年 archermind. All rights reserved.
//

#import "NSString+Encrypt.h"
//#import "NSData+AES128.h"
//#import "NSData+Base64.h"
//
//#import "NSData+CommonCrypto.h"

@implementation NSString(EncryptEx)

//-(NSString *)encryptWithMode0
//{
//    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
//    //zip
//    NSData *zipData = [ZipManager zlibDeflate:data];
//    //base64 encode
//    return [zipData base64EncodedString];
//}
//
//-(NSString *)decryptWithMode0
//{
//    //base64 decode
//    NSData * data = [NSData dataFromBase64String:self];
//    //unzip
//    NSData * unzipData = [ZipManager zlibInflate:data];
//    return [[[NSString alloc] initWithData:unzipData encoding:NSUTF8StringEncoding] autorelease];
//}
//
//-(NSString *)encryptWithMode4ByKey:(NSString *)key
//{
//    //zip
//    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *zipData = [ZipManager zlibDeflate:data];
//    //AES
//    NSData *eData = [zipData AES128EncryptWithKey:key];
//    //base64 encode
//    NSString *secretString = [eData base64EncodedString];
//    return secretString;
//}
//
//-(NSString *)decryptWithMode4ByKey:(NSString *)key
//{
//    //base64 decode
//    NSData *base64Data = [NSData dataFromBase64String:self];
//    //AES dec
//    NSData *bDecrypt = [base64Data AES128DecryptWithKey:key];
//    //unzip
//    NSData *unzipData = [ZipManager zlibInflate:bDecrypt];
//    NSString *str = [[[NSString alloc] initWithData:unzipData encoding:NSUTF8StringEncoding] autorelease];
//    return str;
//}
//
//-(NSString *)encryptWithMode3ByKey:(NSString *)key
//{
////    CCCryptorStatus status = kCCSuccess;
////
////    NSData* result = [[self dataUsingEncoding:NSUTF8StringEncoding] dataEncryptedUsingAlgorithm:kCCAlgorithmAES128
////                      key:key
////                      initializationVector:nil   // ECB加密不会用到iv
////                      options:(kCCOptionPKCS7Padding|kCCOptionECBMode)
////                      error:&status];
////    if (status != kCCSuccess) {
////        NSLog(@"加密失败:%d", status);
////        return nil;
////    }
////    NSString *secretString = [result base64EncodedString];
////    return secretString;
////    NSError *error = [[NSError alloc] init];
////    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
////    NSData *eData = [data AES256EncryptedDataUsingKey:key error:&error];
//
//    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
//    //AES
//    NSData *eData = [data AES128EncryptWithKey:key];
//
//    NSString *aStr = [[NSString alloc] initWithData:eData encoding:NSASCIIStringEncoding];
//    //base64 encode
//    NSString *secretString = [eData base64EncodedString];
//    return secretString;
//}
//
//-(NSString *)decryptWithMode3ByKey:(NSString *)key
//{
//    NSData *base64Data = [NSData dataFromBase64String:self];
////    CCCryptorStatus status = kCCSuccess;
////    NSData* result = [base64Data
////                      decryptedDataUsingAlgorithm:kCCAlgorithmAES128
////                      key:key initializationVector:nil   // ECB解密不会用到iv
////                           options:(kCCOptionPKCS7Padding|kCCOptionECBMode)
////                           error:&status];
////    if (status != kCCSuccess) {
////        NSLog(@"加密失败:%d", status);
////        return nil;
////    }
////    NSError *error = [[NSError alloc] init];
////    NSData* result = [base64Data decryptedAES256DataUsingKey:key error:&error];
//
////    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
//    //base64 decode
//
//    //AES dec
//    NSData *bDecrypt = [base64Data AES128DecryptWithKey:key];
//    NSString *str = [[[NSString alloc] initWithData:bDecrypt encoding:NSUTF8StringEncoding] autorelease];
//    return str;
//}
////获取证书公钥采用RSA加密方式给数据加密
//-(NSString *)rsaEncryptAndBase64Encode:(NSString *)cerPath;
//{
//    RSA *rsa = [[RSA alloc] init];
//    NSString *str = [rsa encryptWithStringAndBase64Encode:self];
//
//    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    [rsa release];
//    return str;
//}


-(NSString *)stringFromHex
{
    NSMutableData *stringData = [[[NSMutableData alloc] init] autorelease];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [stringData appendBytes:&whole_byte length:1];
    }
    
    return [[[NSString alloc] initWithData:stringData encoding:NSASCIIStringEncoding] autorelease];
}

-(NSString *)stringToHex
{
    NSUInteger len = [self length];
    unichar *chars = malloc(len * sizeof(unichar));
    [self getCharacters:chars];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
    {
        [hexString appendString:[NSString stringWithFormat:@"%x", chars[i]]];
    }
    free(chars);
    
    return [hexString autorelease];
}
@end
