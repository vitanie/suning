//
//  LotteryHallTableViewCell.h
//  suning
//
//  Created by Bai on 2017/9/21.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    MatchType = 1,      //赛事直播
    RecommendType,  //推荐分析
    NewsType,       //新闻资讯
    PlayHelpType   //玩法帮助
} ContentType;
@protocol SNLotteryHallCellDelegate

// 轮播图事件
- (void)advCellSelected:(NSString*)action imageUrl:(NSString*)url;

// 赛事、推荐、新闻、玩法 回调
- (void)contentCellSelected:(ContentType)type;

// 各个彩种回调
- (void)lotteryCellSelected:(NSDictionary *)dic;
@end

@interface LotteryHallTableViewCell : UITableViewCell<SNLotteryHallCellDelegate>
@property(nonatomic,strong)id <SNLotteryHallCellDelegate>delegate;
@property(nonatomic,strong)NSDictionary* item;
@property(nonatomic,strong)NSArray* advs;
@property(nonatomic,strong)NSArray* msgs;
-(id)initWithAdvs:(NSArray*)advs reuseIdentifier:(NSString *)reuseIdentifier;
-(id)initWithItemsReuseIdentifier:(NSString *)reuseIdentifier delegate:(id <SNLotteryHallCellDelegate>) dele;

/**
 *  更新列表数据
 *
 *  @param item 数据源
 *
 */
-(void)updateInitWithItems:(NSMutableArray*)item;
@end
