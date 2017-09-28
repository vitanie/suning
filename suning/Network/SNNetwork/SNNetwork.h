//
//  SNNetwork.h
//  suning
//
//  Created by Bai on 2017/9/19.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNNetwork : NSObject
//单例方法
+(SNNetwork*)shard;
//网络请求发起 command:命令字 body:报文
-(void)reqWithCommand:(NSString*)req_command
                 body:(NSDictionary*)req_body
                 mode:(NSString*)req_mode
              success:(void(^)(id body))success
              failure:(void(^)(NSError* errors))failure;
@end
