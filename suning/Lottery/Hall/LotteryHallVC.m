//
//  LotteryHallVC.m
//  suning
//
//  Created by 白云皓 on 2017/12/13.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "LotteryHallVC.h"
#import "DMScrollingTicker.h"

@interface LotteryHallVC ()<SNNavigationDelegate>
@property(nonatomic,strong)SNNavigation* navigationView;
@property(nonatomic,strong)NSMutableArray* labelArr;
@property(nonatomic,strong)DMScrollingTicker* scrollingTicker;
@property(nonatomic,strong)NSMutableArray* items;
@property(nonatomic,strong)NSArray* halls;
@property(nonatomic,strong)NSArray* advs;
@property(nonatomic,strong)NSMutableArray* imageURLs;
@property(nonatomic,strong)NSMutableArray* actions;
@property(nonatomic,strong)NSArray* messages;
@property(nonatomic,strong)NSMutableArray* messageLabels;
@property(nonatomic,strong)UIView* paomaView;
@property(nonatomic,strong)UILabel* paomaLabel;
@property(nonatomic,strong)NSTimer* timer;
@property(nonatomic,strong)UITableView* tableView;
@property (nonatomic, strong) UIButton *qianDaoBtn;
@end

@implementation LotteryHallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _navigationView = [[SNNavigation alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kNavigationHeight) title:@"购彩大厅" isBack:NO isHelp:NO];
    [self.view addSubview:_navigationView];
    
    [self loadNewData];
    
    [self loadMsgView];
}
//刷新新数据
-(void)loadNewData
{
    _items = nil;
    _items = [[NSMutableArray alloc] init];
    
    //加载广告
//    [self loadAdView];
    //加载首页
//    [self loadHallView];
//    [_tableView.header endRefreshing];
    
}
-(void)loadAdView
{
    
    NSDictionary* reqDic = @{@"id":@"1"};
    _imageURLs = [[NSMutableArray alloc] init];
    _actions = [[NSMutableArray alloc] init];
    [[SNNetwork shard] reqWithCommand:@"ADV1000" body:reqDic mode:@"1" success:^(id res) {

        _advs = [res objectForKey:@"adv"];
        NSLog(@"广告:%@",_advs);
        
    } failure:^(NSError *errors) {
        
    }];
    
}

//中奖播报请求
-(void)loadMsgView
{
    //重置清除
    UIView* shanchu = [self.view viewWithTag:3000];
    [shanchu removeFromSuperview];
    NSDictionary* reqDic = @{@"lotteryId":@""};
    //中奖播报请求
    [[SNNetwork shard] reqWithCommand:@"LTY9001" body:reqDic mode:@"1" success:^(id res) {
        _messages = [res objectForKey:@"items"];
        
        [self creatPaoma];
    }failure:^(NSError *errors) {
    }];
    
}
//生成跑马灯
-(void)creatPaoma
{
    UIView* background = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kWindowWidth, 30)];
    background.backgroundColor = kBackGroundColor;
    background.tag = 3000;
    [self.view addSubview:background];
    //跑马灯
    UILabel* paomaLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWindowWidth,0, kWindowWidth, 30)];
    [background addSubview:paomaLabel];
    UIView* mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    mask.backgroundColor = kBackGroundColor;
    [background addSubview:mask];
    UIImageView* laba = [[UIImageView alloc] initWithFrame:CGRectMake(10,8, 15, 15)];
    laba.image = [UIImage imageNamed:@"hall_xiaolaba"];
    [background addSubview:laba];
    
    UIView* qingchu = [self.view viewWithTag:3001];
    [qingchu removeFromSuperview];
    
    if (!_messages.count) {
        
        paomaLabel.font = kFontSizeExplanation_12;
        paomaLabel.textColor = colorWithHexString(@"#333333");
        
        [paomaLabel setText:@"欢迎使用！"];
        [paomaLabel setFrame:CGRectMake(CGRectGetMaxX(laba.frame)+5, 5, kWindowWidth - CGRectGetMaxX(laba.frame)-5, 20)];
        paomaLabel.textAlignment = 1;
        return;
        
    }
    else
    {
        paomaLabel.text = @"";
    }
    
    _scrollingTicker = nil;
    _scrollingTicker = [[DMScrollingTicker alloc] initWithFrame:CGRectMake(30,kNavigationHeight + 8, kWindowWidth-30, 20)];
    _scrollingTicker.tag = 3001;
    //scrollingTicker.backgroundColor = [UIColor redColor];
    [self.view addSubview:_scrollingTicker];
    _messageLabels = [[NSMutableArray alloc] init];
    NSMutableArray *sizes = [[NSMutableArray alloc] init];
    for (NSUInteger k = 0; k < _messages.count; k++)
    {
        NSString* msg = [_messages[k] objectForKey:@"winMsg"];
        
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[msg dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        LPScrollingTickerLabelItem *label = [[LPScrollingTickerLabelItem alloc] initWithTitle:attrStr
                                                                                  description:attrStr];
        [label layoutSubviews];
        [sizes addObject:[NSValue valueWithCGSize:label.frame.size]];
        [_messageLabels addObject:label];
        
    }
    [_scrollingTicker beginAnimationWithViews:_messageLabels
                                    direction:LPScrollingDirection_FromRight
                                        speed:0
                                        loops:0
                                 completition:^(NSUInteger loopsDone, BOOL isFinished) {
                                     //NSLog(@"loop %d, finished? %d",loopsDone,isFinished);
                                 }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
