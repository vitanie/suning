//
//  SNLotteryOpenCell.h
//  suning
//
//  Created by Bai on 2017/9/25.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNLotteryOpenCell : UITableViewCell
@property(nonatomic,strong)NSString* _Nullable lotteryId;
-(id _Nullable )initWithLotteryId:(NSString*_Nullable)lotteryId drawCode:(NSString*_Nullable)drawCode reuseIdentifier:(NSString *_Nullable)reuseIdentifier;
-(void)setItem:(NSDictionary *_Nullable)item hasDetail:(BOOL)hasDetail;
@property (strong, nonatomic) NSDictionary * _Nullable raceAgainst; //赛事对阵
@property (strong, nonnull) UIImageView *sanjiaoImg;    //三角
@end
