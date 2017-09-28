//
//  UZRefreshHeader.m
//  UZLottery
//
//  Created by kevin on 31/8/15.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "UZRefreshHeader.h"

@implementation UZRefreshHeader

- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"gif_big_%ld", i]];
        if (image)
        {
            [idleImages addObject:image];
        }
        
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"gif_%ld", i]];
        if (image)
        {
            [refreshingImages addObject:image];
        }
        
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
