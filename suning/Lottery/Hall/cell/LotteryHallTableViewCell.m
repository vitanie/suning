//
//  LotteryHallTableViewCell.m
//  suning
//
//  Created by Bai on 2017/9/21.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "LotteryHallTableViewCell.h"
#import "LotteryHallView.h"
#import "DMScrollingTicker.h"

@interface LotteryHallTableViewCell()

@property (nonatomic, strong) LotteryHallView *hallView1;
@property (nonatomic, strong) LotteryHallView *hallView2;


@end

@implementation LotteryHallTableViewCell
@synthesize hallView1;
@synthesize hallView2;


-(id)initWithAdvs:(NSArray*)advs reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initAdvs:advs];
    }
    return self;
}
-(void)initAdvs:(NSArray*)advs
{
    //NSLog(@"haha:%@",advs);
    NSMutableArray* imageURLs = [NSMutableArray array];
    NSMutableArray* actions = [NSMutableArray array];
    for (int i=0; i<advs.count; i++)
    {
        [imageURLs addObject:[advs[i] objectForKey:@"imageUrl"]];
        [actions addObject:[advs[i] objectForKey:@"action"]];
    }
    DJPageView *pageView = nil;
    if ([advs count] > 0) {
        
        pageView = [[DJPageView alloc] initPageViewFrame:CGRectMake(0, 0, kWindowWidth, 240*kWindowWidth/640) webImageStr:imageURLs didSelectPageViewAction:^(NSInteger index) {
            
            [_delegate advCellSelected:actions[index] imageUrl:imageURLs[index]];
        }];
        pageView.tag = 1000;
        //停留时间
        pageView.duration = 7.0;
        pageView.pageBackgroundColor = [UIColor clearColor];
        pageView.pageIndicatorTintColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.4];
        pageView.currentPageColor = [UIColor whiteColor];
        [self addSubview:pageView];
    }
    
}

- (void)btnOnClick:(UIButton *)btn
{
    [_delegate contentCellSelected:btn.tag];
}

-(id)initWithItemsReuseIdentifier:(NSString *)reuseIdentifier delegate:(id <SNLotteryHallCellDelegate>) dele{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.delegate = dele;
        [self initLotteryHallCell];
    }
    return self;
}

/**
 *  更新列表数据
 *
 *  @param item 数据源
 *
 */
-(void)updateInitWithItems:(NSMutableArray*)item
{
    
    
    if ([item count] >1) {
        
        hallView1.hidden = NO;
        hallView2.hidden = NO;
        
        
        [hallView1 updateInitWithItems:[item objectAtIndex:0]];
        [hallView2 updateInitWithItems:[item objectAtIndex:1]];
    }else
    {
        [hallView1 updateInitWithItems:[item objectAtIndex:0]];
        hallView2.hidden = YES;
        
        
    }
    
}
-(void)initLotteryHallCell
{
    
    //    self.backgroundColor = kBackGroundColor;
    
    CGFloat width = kWindowWidth / 2;
    
    hallView1 = [[LotteryHallView alloc] initWithFrame:CGRectMake(0, 0, width, 64)];
    hallView1.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(id) bdeldgate =  _delegate;
    hallView1.callback = ^(NSDictionary *dic)
    {
        [bdeldgate lotteryCellSelected:dic];
    };
    [self addSubview:hallView1];
    
    hallView2 = [[LotteryHallView alloc] initWithFrame:CGRectMake(width, 0, width, 64)];
    hallView2.backgroundColor = [UIColor whiteColor];
    hallView2.callback = ^(NSDictionary *dic)
    {
        NSLog(@"%@",dic);
        [bdeldgate lotteryCellSelected:dic];
        
        
    };
    [self addSubview:hallView2];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
