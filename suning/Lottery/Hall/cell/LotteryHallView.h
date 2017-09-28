//
//  LotteryHallView.h
//  UZLottery
//
//  Created by haochentao on 16/4/15.
//  Copyright © 2016年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LotteryHallView : UIView

@property (nonatomic,copy) void (^callback)();    //回调

/**
 *  更新数据
 *
 *  @param item 数据源
 */
-(void)updateInitWithItems:(NSDictionary*)item;

@end
