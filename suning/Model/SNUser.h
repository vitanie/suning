//
//  SNUser.h
//  suning
//
//  Created by Bai on 2017/9/21.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNUser : NSObject
@property(nonatomic,strong)NSString* sid;//会话编号
@property(nonatomic,strong)NSString* skey;//会话密匙
@property(nonatomic,strong)NSString* uid;//用户编号
@property(nonatomic,strong)NSString* userType;//用户类型（0自注册用户，1代理商用户）
@property(nonatomic,strong)NSString* userName;//用户名
@property(nonatomic,strong)NSString* headImageId;//头像编号
@property(nonatomic,strong)NSString* score;//用户积分
@property(nonatomic,strong)NSString* cash;//投注金余额
@property(nonatomic,strong)NSString* present;//赠款余额
@property(nonatomic,strong)NSString* bonus;//奖金余额
@property(nonatomic,strong)NSString* bonusFlag;//能否使用奖金支付


//获取单例
+(instancetype)shard;
//创建模型
-(void)setBody:(id)body;
//清空模型 用于注销 超时
-(void)remove;
@end
