//
//  SNUser.m
//  suning
//
//  Created by Bai on 2017/9/21.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "SNUser.h"

@implementation SNUser
+(instancetype)shard
{
    static SNUser* _shard = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        _shard = [[self alloc] init];
    });
    return _shard;
}
-(void)setBody:(id)body
{
    [self setKeyValues:body];
}
-(void)remove
{
    _uid = nil;
    _sid = nil;
    _skey = nil;
    _userName = nil;
    _userType = nil;
    _headImageId = nil;
    _cash = nil;
    _score = nil;
    _present = nil;
    _bonus = nil;
    _bonusFlag = nil;
}
@end
