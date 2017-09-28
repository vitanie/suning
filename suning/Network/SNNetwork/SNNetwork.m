//
//  SNNetwork.m
//  suning
//
//  Created by Bai on 2017/9/19.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "SNNetwork.h"
#import "AppDelegate.h"
@implementation SNNetwork
+(instancetype)shard
{
    //    static dispatch_once_t predicate;
    //    dispatch_once(&predicate, ^{
    SNNetwork* shard = [[SNNetwork alloc] init];
    //    });
    return shard;
}
//网络请求发起
-(void)reqWithCommand:(NSString*)req_command
                 body:(NSDictionary*)req_body
                 mode:(NSString*)req_mode
              success:(void(^)(id body))success
              failure:(void(^)(NSError* errors))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //manager.securityPolicy.allowInvalidCertificates = YES;
    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //返回的数据json类型 (默认 设不设置都可)
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    //请求字段
    /*****
     客户端请求消息头
     {
     "cmd": "接口编号",
     "deviceId": "设备编号",
     "productId": "产品编号",
     "productVersion": "产品版本",
     "channelId": "渠道编号",
     "keyId": "密钥编号",
     "sid": "会话编号",
     "sign": "会话签名"
     "mode": "数据模式",
     "body": "加密报文",
     "digest": "报文摘要"
     }
     
     *****/
    
    NSString* keyId = KEYID;
    NSString* deviceId = UDValue(@"deviceId");;
    NSString* session = @"";
    NSString* mode = req_mode;
    NSString* body = @"";
    NSString* digest = @"";
    
    
    //请求数据加密
    if ([req_mode isEqualToString:@"1"]) {
        
        //数据模式1 body的base64
        body = req_body?[[NSJSONSerialization dataWithJSONObject:req_body
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:nil] base64Encoding]:@"";
        
        //数据模式2 digest摘要=32位MD5(body加密报文)
        digest = (![body isEqual:@""])?[MyMD5 md5:body]:@"";
    }
    if ([req_mode isEqualToString:@"2"]) {
        //数据模式2 密文 = Base64(ZIP(明文))
        NSData* bodyData = [NSJSONSerialization dataWithJSONObject:req_body
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];
        bodyData = [LFCGzipUtillity gzipData:bodyData];
        body = req_body?[bodyData base64Encoding]:@"";
        //数据模式2 digest摘要=32位MD5(body加密报文)
        digest = (![body isEqual:@""])?[MyMD5 md5:body]:@"";
    }
    if ([req_mode isEqualToString:@"3"]) {
        //数据模式3 密文 = Base64(AES(明文),AES _KEY)
        NSData* bodyData = req_body?[NSJSONSerialization dataWithJSONObject:req_body
                                                                    options:NSJSONWritingPrettyPrinted
                                                                      error:nil]:nil;
        
        bodyData = req_body?[bodyData AES128EncryptWithKey:KEY]:nil;
        
        body = req_body?[bodyData base64Encoding]:@"";
        
        digest = (![body isEqual:@""])?[MyMD5 md5:body]:@"";
        
    }
    
    //deviceId
//    if([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceId"])
//    {
//        deviceId = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceId"];
//    }
    
    //需要验证session的协议 session = sid (会话编号)+ $ + ssign(会话签名)
    //会话签名 = 32字节MD5(命令字(cmd) + 设备编号 + 会话编号(sid) + 会话密钥(skey) + 密文摘要(digest))
    //会话签名 = 32字节MD5(命令字(cmd) + 会话编号(sid) + 会话密钥(skey) + 密文摘要)
//    NSString* sid = @"";
//    NSString* skey = @"";
    NSString* sid = [SNUser shard].sid;
    NSString* skey = [SNUser shard].skey;
    NSString* ssign = [MyMD5 md5:[NSString stringWithFormat:@"%@%@%@%@",req_command,sid,skey,digest]];
    session = [NSString stringWithFormat:@"%@$%@",sid,ssign];
    
    static long nRepeatCount = 0;
    
    NSMutableString *newMd5Str = [[NSMutableString alloc]init];
    NSString *strMsgID =  [NSString stringWithFormat:@"%ld%ld", time(nil),nRepeatCount ++];
    
    NSString *md5 = [[MyMD5 md5:strMsgID] uppercaseString];
    [newMd5Str appendString: md5];
    [newMd5Str appendString:[[MyMD5 md5:md5] uppercaseString]];
    
    //NSLog(@"随机值:%@",newMd5Str);
    //网络请求消息头
    /*****
     客户端请求消息头
     {
     "cmd": "接口编号",
     "deviceId": "设备编号",
     "productId": "产品编号",
     "productVersion": "产品版本",
     "channelId": "渠道编号",
     "keyId": "密钥编号",
     "sid": "会话编号",
     "sign": "会话签名"
     "mode": "数据模式",
     "body": "加密报文",
     "digest": "报文摘要"
     }
     
     *****/
    if(sid == nil){
        sid = @"";
    }
    NSDictionary *parameters = @{@"cmd":req_command,
                                 @"deviceId":deviceId,
                                 @"productId":Client_Num,
                                 @"productVersion":client_version,
                                 @"channelId":Channel_Num,
                                 @"sid": sid,
                                 @"keyId": keyId,
                                 @"sign":ssign,
                                 @"mode":mode,
                                 @"body":body,
                                 @"digest":digest
                                 };
    
    
    NSString * http = @"http:";
    
    if (HTTPSWITCH == 1) {
        
        http = @"https:";
        
    }
    
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
//    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSString* url = [NSString stringWithFormat:@"%@//%@/client/%@/%@/%@",http,Server_Url,Client_Num,Channel_Num,req_command];
    
    //限制loading指示器的协议
    if (![req_command isEqualToString:@"JKC2002"])
    {
        [[WaitView share] showDalog];
    }
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[WaitView share] closeDalog];
        
        NSString* result = [responseObject objectForKey:@"result"];
        if(![result isEqualToString:@"0"])
        {
            failure(nil);
            if ([result isEqualToString:@"-6"]) {   //登录超时
                
                //进入登陆页面改变初始值
//                [[NSUserDefaults  standardUserDefaults] setBool:NO forKey:@"getdata"];
//                [[NSUserDefaults  standardUserDefaults] synchronize];
//                
//                UZLoginVC* loginVC = [[UZLoginVC alloc] init];
//                UZLoginNavigationVC* loginNavVC = [[UZLoginNavigationVC alloc] initWithRootViewController:loginVC];
//                loginNavVC.navigationBarHidden = YES;
//                
//                
//                NSLog(@"%lu",(unsigned long)kAppDelegate.tabbarVC.selectedIndex);
//                NSLog(@"%@",[kAppDelegate.tabbarVC.viewControllers objectAtIndex:kAppDelegate.tabbarVC.selectedIndex]);
//                
//                
//                if ([[kAppDelegate.tabbarVC.viewControllers objectAtIndex:kAppDelegate.tabbarVC.selectedIndex] isKindOfClass:[UZAccountNavigationVC class]]) {
//                    
//                    NSLog(@"进入");
//                    loginVC.m_backType = 1;
//                    
//                }
//                if ([[kAppDelegate.tabbarVC.viewControllers objectAtIndex:kAppDelegate.tabbarVC.selectedIndex] isKindOfClass:[UZIMNavigation class]]) {
//                    
//                    NSLog(@"进入");
//                    loginVC.m_backType = 2;
//                    
//                }
//                
//                [kAppDelegate hideUnreadCount];
//                [[UZUser shard] remove];
//                [kAppDelegate.tabbarVC presentViewController:loginNavVC animated:YES completion:^{
//                    if (![[kAppDelegate.tabbarVC.viewControllers objectAtIndex:kAppDelegate.tabbarVC.selectedIndex] isKindOfClass:[UZIMNavigation class]]) {
//                        [[[iToast makeText:@"登录超时请重新登录"]
//                          setGravity:iToastGravityCenter] show];
//                    }
//                    
//                }];
                return;
            }
            if ([result isEqualToString:@"-8"]) {
                [[[iToast makeText:@"未开通国家投注功能,请开通!"]
                  setGravity:iToastGravityCenter] show];
//                UZInvestOpenVC* account = [[UZInvestOpenVC alloc] init];
//                UZLoginNavigationVC* loginNavVC = [[UZLoginNavigationVC alloc] initWithRootViewController:account];
//                loginNavVC.navigationBarHidden = YES;
//                [kAppDelegate.tabbarVC presentViewController:loginNavVC animated:YES completion:^{
//                    
//                }];
                
            }
            if ([result isEqualToString:@"-7"]) {
                [[[iToast makeText:@"未开通投注账户,请开通投注账户!"]
                  setGravity:iToastGravityCenter] show];
//                UZAccountOpenVC* account = [[UZAccountOpenVC alloc] init];
//                UZLoginNavigationVC* loginNavVC = [[UZLoginNavigationVC alloc] initWithRootViewController:account];
//                loginNavVC.navigationBarHidden = YES;
//                [kAppDelegate.tabbarVC presentViewController:loginNavVC animated:YES completion:^{
//                    
//                }];
                
            }
            if ([result isEqualToString:@"-5"]) {
                [[[iToast makeText:@"系统忙，努力加载呦"]
                  setGravity:iToastGravityCenter] show];
            }
            if ([result isEqualToString:@"-4"]) {
                [[[iToast makeText:@"系统维护中,请稍后再试"]
                  setGravity:iToastGravityCenter] show];
                NSLog(@"系统维护中,请稍后再试");
            }
            if ([result isEqualToString:@"-3"]) {
                [[[iToast makeText:@"系统维护中,请稍后再试"]
                  setGravity:iToastGravityCenter] show];
                NSLog(@"请求参数无效");
            }
            if ([result isEqualToString:@"-2"]) {
                [[[iToast makeText:@"系统维护中,请稍后再试"]
                  setGravity:iToastGravityCenter] show];
                NSLog(@"数据加密错误");
            }
            if ([result isEqualToString:@"-1"]) {
                [[[iToast makeText:@"系统维护中,请稍后再试"]
                  setGravity:iToastGravityCenter] show];
            }
            return ;
        }
        //请求数据解密
        if ([[responseObject objectForKey:@"mode"] isEqualToString:@"1"])
        {
            //Base64解密 密文 = Base64(明文)
            NSData* body = [GTMBase64 decodeString:[responseObject objectForKey:@"body"]];
            //处理后的明文
            NSDictionary* bodyDic = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            NSLog(@"返回的协议:%@",req_command);
            NSLog(@"成功返回消息体:%@",bodyDic);
            NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            
            //解决数据源某些字段需要排序（竞猜型：所有用户选的结果都要根据场次匹配，排好序才可用）
            if ([req_command isEqualToString:@"JJC3002"])
            {
                //整体对象可编辑
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:bodyDic];
                //子对象可编辑
                NSMutableDictionary *subDict = [[NSMutableDictionary alloc]initWithDictionary:[dict objectForKey:@"codeInfo"]];
                
                [dict setObject:subDict forKey:@"codeInfo"];
                
                //子对象可编辑（ticketInfo）
                NSMutableDictionary *ticketInfoDict = [[NSMutableDictionary alloc]initWithDictionary:[dict objectForKey:@"ticketInfo"]];
                
                [dict setObject:ticketInfoDict forKey:@"ticketInfo"];
                
                
                //重新设置ticketInfo-------------------------------------
                NSMutableString *stringOdds = [[NSMutableString alloc]init];
                
                NSString *odds = [[dict objectForKey:@"ticketInfo"] objectForKey:@"odds"];
                NSArray *newOdds = [odds componentsSeparatedByString:@"^"];
                
                NSArray *dataArr = [dict objectForKey:@"vsInfos"];
                if (dataArr.count) {
                    for (int i=0; i<dataArr.count; i++) {
                        NSString *strId = [[dataArr objectAtIndex:i] objectForKey:@"id"];
                        
                        for (int j=0; j<newOdds.count; j++)
                        {
                            NSString *substr = newOdds[j];
                            if ([substr rangeOfString:strId].location != NSNotFound) {
                                
                                [stringOdds appendString:substr];
                                [stringOdds appendString:@"^"];
                                break;
                            }
                        }
                    }
                }
                if (stringOdds.length)
                {
                    stringOdds = (NSMutableString*)[stringOdds substringToIndex:stringOdds.length -1];
                    //子对象可编辑
                    [[dict objectForKey:@"ticketInfo"] setValue:stringOdds forKey:@"odds"];
                }
                
                
                //重新设置codeInfo-------------------------------------
                NSMutableString *string = [[NSMutableString alloc]init];
                
                NSString *code = [[dict objectForKey:@"codeInfo"] objectForKey:@"code"];
                NSArray *newCode = [code componentsSeparatedByString:@"^"];
                
                if (dataArr.count) {
                    for (int i=0; i<dataArr.count; i++) {
                        NSString *strId = [[dataArr objectAtIndex:i] objectForKey:@"id"];
                        
                        for (int j=0; j<newCode.count; j++)
                        {
                            NSString *substr = newCode[j];
                            if ([substr rangeOfString:strId].location != NSNotFound) {
                                
                                [string appendString:substr];
                                [string appendString:@"^"];
                                break;
                            }
                        }
                    }
                }
                if (string.length) {
                    string = (NSMutableString*)[string substringToIndex:string.length -1];
                    //子对象可编辑
                    [[dict objectForKey:@"codeInfo"] setValue:string forKey:@"code"];
                }
                
                
                bodyDic = dict;
                
            }
            
            success(bodyDic);
            
        }
        else if([[responseObject objectForKey:@"mode"] isEqualToString:@"2"])
        {
            //Base64解密 zip解压 密文 = Base64(ZIP(明文))
            NSData* body = [GTMBase64 decodeString:[responseObject objectForKey:@"body"]];
            body = [LFCGzipUtillity uncompressZippedData:body];
            //处理后的明文
            NSDictionary* bodyDic = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingMutableLeaves error:nil];
            
            NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            NSLog(@"返回的协议:%@",req_command);
            NSLog(@"成功返回消息体:%@",bodyDic);
            NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            
            //解决数据源某些字段需要排序（竞猜型：所有用户选的结果都要根据场次匹配，排好序才可用）
            if ([req_command isEqualToString:@"JJC3002"])
            {
                //整体对象可编辑
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:bodyDic];
                //子对象可编辑
                NSMutableDictionary *subDict = [[NSMutableDictionary alloc]initWithDictionary:[dict objectForKey:@"codeInfo"]];
                
                [dict setObject:subDict forKey:@"codeInfo"];
                
                //子对象可编辑（ticketInfo）
                NSMutableDictionary *ticketInfoDict = [[NSMutableDictionary alloc]initWithDictionary:[dict objectForKey:@"ticketInfo"]];
                
                [dict setObject:ticketInfoDict forKey:@"ticketInfo"];
                
                
                //重新设置ticketInfo-------------------------------------
                NSMutableString *stringOdds = [[NSMutableString alloc]init];
                
                NSString *odds = [[dict objectForKey:@"ticketInfo"] objectForKey:@"odds"];
                NSArray *newOdds = [odds componentsSeparatedByString:@"^"];
                
                NSArray *dataArr = [dict objectForKey:@"vsInfos"];
                if (dataArr.count) {
                    for (int i=0; i<dataArr.count; i++) {
                        NSString *strId = [[dataArr objectAtIndex:i] objectForKey:@"id"];
                        
                        for (int j=0; j<newOdds.count; j++)
                        {
                            NSString *substr = newOdds[j];
                            if ([substr rangeOfString:strId].location != NSNotFound) {
                                
                                [stringOdds appendString:substr];
                                [stringOdds appendString:@"^"];
                                break;
                            }
                        }
                    }
                }
                if (stringOdds.length)
                {
                    stringOdds = (NSMutableString*)[stringOdds substringToIndex:stringOdds.length -1];
                    //子对象可编辑
                    [[dict objectForKey:@"ticketInfo"] setValue:stringOdds forKey:@"odds"];
                }
                
                
                //重新设置codeInfo-------------------------------------
                NSMutableString *string = [[NSMutableString alloc]init];
                
                NSString *code = [[dict objectForKey:@"codeInfo"] objectForKey:@"code"];
                NSArray *newCode = [code componentsSeparatedByString:@"^"];
                
                if (dataArr.count) {
                    for (int i=0; i<dataArr.count; i++) {
                        NSString *strId = [[dataArr objectAtIndex:i] objectForKey:@"id"];
                        
                        for (int j=0; j<newCode.count; j++)
                        {
                            NSString *substr = newCode[j];
                            if ([substr rangeOfString:strId].location != NSNotFound) {
                                
                                [string appendString:substr];
                                [string appendString:@"^"];
                                break;
                            }
                        }
                    }
                }
                if (string.length) {
                    string = (NSMutableString*)[string substringToIndex:string.length -1];
                    //子对象可编辑
                    [[dict objectForKey:@"codeInfo"] setValue:string forKey:@"code"];
                }
                
                
                bodyDic = dict;
                
            }
            
            
            success(bodyDic);
            
        }
        else if([[responseObject objectForKey:@"mode"] isEqualToString:@"3"])
        {
            //密文 = Base64(AES(明文),AES _KEY)
            NSData* body = [GTMBase64 decodeString:[responseObject objectForKey:@"body"]];
            body = [body AES128DecryptWithKey:KEY];
            //处理后的明文
            NSDictionary* bodyDic = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingMutableLeaves error:nil];
            
            NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            NSLog(@"返回的协议:%@",req_command);
            NSLog(@"成功返回消息体:%@",bodyDic);
            NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            //解决数据源某些字段需要排序（竞猜型：所有用户选的结果都要根据场次匹配，排好序才可用）
            if ([req_command isEqualToString:@"JJC3002"])
            {
                //整体对象可编辑
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:bodyDic];
                //子对象可编辑
                NSMutableDictionary *subDict = [[NSMutableDictionary alloc]initWithDictionary:[dict objectForKey:@"codeInfo"]];
                
                [dict setObject:subDict forKey:@"codeInfo"];
                
                //子对象可编辑（ticketInfo）
                NSMutableDictionary *ticketInfoDict = [[NSMutableDictionary alloc]initWithDictionary:[dict objectForKey:@"ticketInfo"]];
                
                [dict setObject:ticketInfoDict forKey:@"ticketInfo"];
                
                
                //重新设置ticketInfo-------------------------------------
                NSMutableString *stringOdds = [[NSMutableString alloc]init];
                
                NSString *odds = [[dict objectForKey:@"ticketInfo"] objectForKey:@"odds"];
                NSArray *newOdds = [odds componentsSeparatedByString:@"^"];
                
                NSArray *dataArr = [dict objectForKey:@"vsInfos"];
                if (dataArr.count) {
                    for (int i=0; i<dataArr.count; i++) {
                        NSString *strId = [[dataArr objectAtIndex:i] objectForKey:@"id"];
                        
                        for (int j=0; j<newOdds.count; j++)
                        {
                            NSString *substr = newOdds[j];
                            if ([substr rangeOfString:strId].location != NSNotFound) {
                                
                                [stringOdds appendString:substr];
                                [stringOdds appendString:@"^"];
                                break;
                            }
                        }
                    }
                }
                NSLog(@"%@",stringOdds);
                if ([stringOdds length]) {
                    
                    stringOdds = (NSMutableString*)[stringOdds substringToIndex:stringOdds.length -1];
                    //子对象可编辑
                    [[dict objectForKey:@"ticketInfo"] setValue:stringOdds forKey:@"odds"];
                    
                }
                
                
                //重新设置codeInfo-------------------------------------
                NSMutableString *string = [[NSMutableString alloc]init];
                
                NSString *code = [[dict objectForKey:@"codeInfo"] objectForKey:@"code"];
                NSArray *newCode = [code componentsSeparatedByString:@"^"];
                
                if (dataArr.count) {
                    for (int i=0; i<dataArr.count; i++) {
                        NSString *strId = [[dataArr objectAtIndex:i] objectForKey:@"id"];
                        
                        for (int j=0; j<newCode.count; j++)
                        {
                            NSString *substr = newCode[j];
                            if ([substr rangeOfString:strId].location != NSNotFound) {
                                
                                [string appendString:substr];
                                [string appendString:@"^"];
                                break;
                            }
                        }
                    }
                }
                if (string.length) {
                    string = (NSMutableString*)[string substringToIndex:string.length -1];
                    //子对象可编辑
                    [[dict objectForKey:@"codeInfo"] setValue:string forKey:@"code"];
                }
                
                
                
                bodyDic = dict;
                
            }
            
            success(bodyDic);
            
            
        }
        else if([[responseObject objectForKey:@"mode"] isEqualToString:@"4"])
        {
            //密文 = Base64(AES(ZIP(明文),AES _KEY))
            NSData* body = [GTMBase64 decodeString:[responseObject objectForKey:@"body"]];
            body = [body AES128DecryptWithKey:KEY];
            body = [LFCGzipUtillity uncompressZippedData:body];
            //处理后的明文
            NSDictionary* bodyDic = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingMutableLeaves error:nil];
            
            
            //解决数据源某些字段需要排序（竞猜型：所有用户选的结果都要根据场次匹配，排好序才可用）
            if ([req_command isEqualToString:@"JJC3002"])
            {
                //整体对象可编辑
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:bodyDic];
                //子对象可编辑
                NSMutableDictionary *subDict = [[NSMutableDictionary alloc]initWithDictionary:[dict objectForKey:@"codeInfo"]];
                
                [dict setObject:subDict forKey:@"codeInfo"];
                
                //子对象可编辑（ticketInfo）
                NSMutableDictionary *ticketInfoDict = [[NSMutableDictionary alloc]initWithDictionary:[dict objectForKey:@"ticketInfo"]];
                
                [dict setObject:ticketInfoDict forKey:@"ticketInfo"];
                
                
                //重新设置ticketInfo-------------------------------------
                NSMutableString *stringOdds = [[NSMutableString alloc]init];
                
                NSString *odds = [[dict objectForKey:@"ticketInfo"] objectForKey:@"odds"];
                NSArray *newOdds = [odds componentsSeparatedByString:@"^"];
                
                NSArray *dataArr = [dict objectForKey:@"vsInfos"];
                if (dataArr.count) {
                    for (int i=0; i<dataArr.count; i++) {
                        NSString *strId = [[dataArr objectAtIndex:i] objectForKey:@"id"];
                        
                        for (int j=0; j<newOdds.count; j++)
                        {
                            NSString *substr = newOdds[j];
                            if ([substr rangeOfString:strId].location != NSNotFound) {
                                
                                [stringOdds appendString:substr];
                                [stringOdds appendString:@"^"];
                                break;
                            }
                        }
                    }
                }
                if (stringOdds.length) {
                    stringOdds = (NSMutableString*)[stringOdds substringToIndex:stringOdds.length -1];
                    //子对象可编辑
                    [[dict objectForKey:@"ticketInfo"] setValue:stringOdds forKey:@"odds"];
                }
                
                
                //重新设置codeInfo-------------------------------------
                NSMutableString *string = [[NSMutableString alloc]init];
                
                NSString *code = [[dict objectForKey:@"codeInfo"] objectForKey:@"code"];
                NSArray *newCode = [code componentsSeparatedByString:@"^"];
                
                if (dataArr.count) {
                    for (int i=0; i<dataArr.count; i++) {
                        NSString *strId = [[dataArr objectAtIndex:i] objectForKey:@"id"];
                        
                        for (int j=0; j<newCode.count; j++)
                        {
                            NSString *substr = newCode[j];
                            if ([substr rangeOfString:strId].location != NSNotFound) {
                                
                                [string appendString:substr];
                                [string appendString:@"^"];
                                break;
                            }
                        }
                    }
                }
                if (string.length) {
                    string = (NSMutableString*)[string substringToIndex:string.length -1];
                    //子对象可编辑
                    [[dict objectForKey:@"codeInfo"] setValue:string forKey:@"code"];
                }
                
                
                bodyDic = dict;
                
            }
            
            
            
            success(bodyDic);
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[WaitView share] closeDalog];
        [[[iToast makeText:@"服务或网络异常!"]
          setGravity:iToastGravityCenter] show];
        failure(error);
    }];
    
}
@end
