//
//  SNLotteryOpenCell.m
//  suning
//
//  Created by Bai on 2017/9/25.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "SNLotteryOpenCell.h"

@interface SNLotteryOpenCell()

@property(nonatomic,strong)UILabel* lotteryName;
@property(nonatomic,strong)UILabel* issue;
@property(nonatomic,strong)UILabel* drawTime;

//竞彩足球
@property(nonatomic,strong)UIView* jczqBgView;
@property(nonatomic,strong)UZLabel* jczqCodeLabel;
//竞彩篮球
@property(nonatomic,strong)UIView* jclqBgView;
@property(nonatomic,strong)UZLabel* jclqCodeLabel;
@end
@implementation SNLotteryOpenCell
-(id)initWithLotteryId:(NSString*)lotteryId drawCode:(NSString*)drawCode reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.layer.masksToBounds = YES;
        
        [self loadCommonUI];
        //根据类型加载自定义开奖模板图
        if ([lotteryId isEqualToString:@"JCZQ"])
        {
            [self loadJCZQOpenView:drawCode];
        }
        else if ([lotteryId isEqualToString:@"JCLQ"])
        {
            [self loadJCLQOpenView:drawCode];
        }
        else if ([lotteryId isEqualToString:@"DLT"])
        {
            [self loadDLTOpenView:drawCode];
        }
        else if([lotteryId isEqualToString:@"SSQ"])
        {
            [self loadSSQOpenView:drawCode];
        }
        else if([lotteryId isEqualToString:@"QLC"])
        {
            [self loadQLCOpenView:drawCode];
        }
        else if ([lotteryId isEqualToString:@"HN4J1"])
        {
            [self loadHN4J1OpenView:drawCode];
        }
        else if ([lotteryId isEqualToString:@"ZC_SFC"]||
                 [lotteryId isEqualToString:@"ZC_R9"]||
                 [lotteryId isEqualToString:@"ZC_JQ"]||
                 [lotteryId isEqualToString:@"ZC_BQC"])
        {
            [self loadZCOpenView:drawCode];
        }
        else if ([lotteryId isEqualToString:@"PL3"]||
                 [lotteryId isEqualToString:@"PL5"]||
                 [lotteryId isEqualToString:@"QXC"]||
                 [lotteryId isEqualToString:@"FC3D"]||
                 [lotteryId isEqualToString:@"QYH"]||
                 [lotteryId isEqualToString:@"C511"])
        {
            [self loadSzcOpenView:drawCode];
        }
    }
    return self;
}
//加载公共部分
-(void)loadCommonUI
{
    _lotteryName = [[UILabel alloc] init];
    _lotteryName.font = [UIFont boldSystemFontOfSize:15];
    _lotteryName.textColor = kTextFontColor;
    [self addSubview:_lotteryName];
    
    _issue = [[UILabel alloc] init];
    _issue.font = [UIFont boldSystemFontOfSize:12];
    _issue.textColor = kFontGrayColor;
    [self addSubview:_issue];
    
    _drawTime = [[UILabel alloc] init];
    _drawTime.font = [UIFont boldSystemFontOfSize:12];
    _drawTime.textColor = kFontGrayColor;
    _drawTime.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_drawTime];
    
    //分割线
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 75-SINGLE_LINE_ADJUST_OFFSET, kWindowWidth, SINGLE_LINE_WIDTH)];
    line.backgroundColor = kSingleLineColor;
    [self addSubview:line];
    
    UIImage *img = acquireImage(@"bt_jiantou_02");
    self.sanjiaoImg = [[UIImageView alloc]initWithImage:img];
    self.sanjiaoImg.frame = CGRectMake(kWindowWidth - 20 - img.size.width, (75+25 - img.size.height)/2, img.size.width, img.size.height);
    self.sanjiaoImg.backgroundColor = [UIColor clearColor];
    self.sanjiaoImg.hidden = YES;
    [self addSubview:self.sanjiaoImg];
    
}
//竞彩足球开奖图初始化
-(void)loadJCZQOpenView:(NSString*)drawCode
{
    //背景
    _jczqBgView = [[UIView alloc] initWithFrame:CGRectMake(25, 38, 0, 30)];
     _jczqBgView.layer.masksToBounds = YES;
     _jczqBgView.layer.cornerRadius = 15;
    _jczqBgView.backgroundColor = [UIColor colorWithHexString:@"#62CD4B"];
    [self addSubview:_jczqBgView];
    _jczqCodeLabel = [[UZLabel alloc] initWithFrame:CGRectMake(60, 44, 0, 30)];
    _jczqCodeLabel.font = [UIFont boldSystemFontOfSize:14];
    _jczqCodeLabel.textColor = [UIColor whiteColor];
    [self addSubview:_jczqCodeLabel];
    
    UIImageView* bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 40, 40)];
    bgimg.image = [UIImage imageNamed:@"竞彩足球"];
    [self addSubview:bgimg];
}
//竞彩篮球开奖图初始化
-(void)loadJCLQOpenView:(NSString*)drawCode
{
    //背景
    _jclqBgView = [[UIView alloc] initWithFrame:CGRectMake(25, 38, 0, 30)];
    _jclqBgView.layer.masksToBounds = YES;
    _jclqBgView.layer.cornerRadius = 15;
    _jclqBgView.backgroundColor = [UIColor colorWithHexString:@"#F6A544"];
    [self addSubview:_jclqBgView];
    _jclqCodeLabel = [[UZLabel alloc] initWithFrame:CGRectMake(60, 44, 0, 30)];
    _jclqCodeLabel.font = [UIFont boldSystemFontOfSize:14];
    _jclqCodeLabel.textColor = [UIColor whiteColor];
    [self addSubview:_jclqCodeLabel];
    
    UIImageView* bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 40, 40)];
    bgimg.image = [UIImage imageNamed:@"竞彩篮球"];
    [self addSubview:bgimg];
}
//超级大乐透开奖图初始化
-(void)loadDLTOpenView:(NSString*)drawCode
{
    //大乐透开奖图
    UIView* dltOpenView = [[UIView alloc] initWithFrame:CGRectMake(10, 35, kWindowWidth-10, 32)];
    dltOpenView.tag = 2000;
    [self addSubview:dltOpenView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowWidth, 28)];
    label.textAlignment = 1;
    label.backgroundColor = colorWithHexString(@"#F7F7F7");
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"超级大乐透奖池奖";
    label.tag = 2017;
    label.hidden = YES;
    [self addSubview:label];
    
    UIView *dltTwoOpenView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kWindowWidth-10, 32)];
    dltTwoOpenView.tag = 2016;
    dltTwoOpenView.hidden = YES;
    dltTwoOpenView.backgroundColor = [UIColor clearColor];
    [self addSubview:dltTwoOpenView];
    for (int i=0; i<5; i++)
    {
        UIImageView* redBall = [[UIImageView alloc] initWithFrame:CGRectMake(i*(5+32), 0, 32, 32)];
        redBall.image = [UIImage imageNamed:@"redBall"];
        [dltOpenView addSubview:redBall];
        
        UIImageView* redBall1 = [[UIImageView alloc] initWithFrame:CGRectMake(i*(5+32), 0, 32, 32)];
        redBall1.image = [UIImage imageNamed:@"redBall"];
        [dltTwoOpenView addSubview:redBall1];
        
        UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*(5+32), 0, 32, 32)];
        numLabel.tag = 2001+i;//2001--2005 开奖红球1-5位
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.font = [UIFont systemFontOfSize:18];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [dltOpenView addSubview:numLabel];
        
        UILabel* numLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(i*(5+32), 0, 32, 32)];
        numLabel1.tag = 3001+i;//2001--2005 开奖红球1-5位
        numLabel1.backgroundColor = [UIColor clearColor];
        numLabel1.font = [UIFont systemFontOfSize:18];
        numLabel1.textColor = [UIColor whiteColor];
        numLabel1.textAlignment = NSTextAlignmentCenter;
        [dltTwoOpenView addSubview:numLabel1];
        
    }
    
    for (int i=0; i<2; i++)
    {
        UIImageView* blueBall = [[UIImageView alloc] initWithFrame:CGRectMake(5*(32+5)+i*(5+32), 0, 32, 32)];
        blueBall.image = [UIImage imageNamed:@"blueBall"];
        [dltOpenView addSubview:blueBall];
        
        UIImageView* blueBall1 = [[UIImageView alloc] initWithFrame:CGRectMake(5*(32+5)+i*(5+32), 0, 32, 32)];
        blueBall1.image = [UIImage imageNamed:@"blueBall"];
        [dltTwoOpenView addSubview:blueBall1];
        
        UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(5*(32+5)+i*(5+32), 0, 32, 32)];
        numLabel.tag = 2006+i;//2006--2007 开奖蓝球1-2位
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.font = [UIFont systemFontOfSize:18];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [dltOpenView addSubview:numLabel];
        
        UILabel* numLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(5*(32+5)+i*(5+32), 0, 32, 32)];
        numLabel1.tag = 3006+i;//2006--2007 开奖蓝球1-2位
        numLabel1.backgroundColor = [UIColor clearColor];
        numLabel1.font = [UIFont systemFontOfSize:18];
        numLabel1.textColor = [UIColor whiteColor];
        numLabel1.textAlignment = NSTextAlignmentCenter;
        [dltTwoOpenView addSubview:numLabel1];
        
    }
    
}
//双色球开奖图初始化
-(void)loadSSQOpenView:(NSString*)drawCode
{
    //双色球开奖图
    UIView* dltOpenView = [[UIView alloc] initWithFrame:CGRectMake(10, 35, kWindowWidth-10, 32)];
    dltOpenView.tag = 5431;
    [self addSubview:dltOpenView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowWidth, 28)];
    label.textAlignment = 1;
    label.backgroundColor = colorWithHexString(@"#F7F7F7");
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"超级大乐透奖池奖";
    label.tag = 2017;
    label.hidden = YES;
    [self addSubview:label];
    
    UIView *dltTwoOpenView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kWindowWidth-10, 32)];
    dltTwoOpenView.tag = 2018;
    dltTwoOpenView.hidden = YES;
    dltTwoOpenView.backgroundColor = [UIColor clearColor];
    [self addSubview:dltTwoOpenView];
    for (int i=0; i<6; i++)
    {
        UIImageView* redBall = [[UIImageView alloc] initWithFrame:CGRectMake(i*(5+32), 0, 32, 32)];
        redBall.image = [UIImage imageNamed:@"redBall"];
        [dltOpenView addSubview:redBall];
        
        UIImageView* redBall1 = [[UIImageView alloc] initWithFrame:CGRectMake(i*(5+32), 0, 32, 32)];
        redBall1.image = [UIImage imageNamed:@"redBall"];
        [dltTwoOpenView addSubview:redBall1];
        
        UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*(5+32), 0, 32, 32)];
        numLabel.tag = 4001+i;//2001--2005 开奖红球1-5位
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.font = [UIFont systemFontOfSize:18];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [dltOpenView addSubview:numLabel];
        
        UILabel* numLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(i*(5+32), 0, 32, 32)];
        numLabel1.tag = 5001+i;//2001--2005 开奖红球1-5位
        numLabel1.backgroundColor = [UIColor clearColor];
        numLabel1.font = [UIFont systemFontOfSize:18];
        numLabel1.textColor = [UIColor whiteColor];
        numLabel1.textAlignment = NSTextAlignmentCenter;
        [dltTwoOpenView addSubview:numLabel1];
        
    }
    
    for (int i=0; i<1; i++)
    {
        UIImageView* blueBall = [[UIImageView alloc] initWithFrame:CGRectMake(6*(32+5)+i*(5+32), 0, 32, 32)];
        blueBall.image = [UIImage imageNamed:@"blueBall"];
        [dltOpenView addSubview:blueBall];
        
        UIImageView* blueBall1 = [[UIImageView alloc] initWithFrame:CGRectMake(6*(32+5)+i*(5+32), 0, 32, 32)];
        blueBall1.image = [UIImage imageNamed:@"blueBall"];
        [dltTwoOpenView addSubview:blueBall1];
        
        UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(6*(32+5)+i*(5+32), 0, 32, 32)];
        numLabel.tag = 4007+i;//2006--2007 开奖蓝球1-2位
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.font = [UIFont systemFontOfSize:18];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [dltOpenView addSubview:numLabel];
        
        UILabel* numLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(6*(32+5)+i*(5+32), 0, 32, 32)];
        numLabel1.tag = 5006+i;//2006--2007 开奖蓝球1-2位
        numLabel1.backgroundColor = [UIColor clearColor];
        numLabel1.font = [UIFont systemFontOfSize:18];
        numLabel1.textColor = [UIColor whiteColor];
        numLabel1.textAlignment = NSTextAlignmentCenter;
        [dltTwoOpenView addSubview:numLabel1];
        
    }
    
}
//七乐彩开奖图初始化
-(void)loadQLCOpenView:(NSString*)drawCode
{
    //七乐彩开奖图
    UIView* dltOpenView = [[UIView alloc] initWithFrame:CGRectMake(10, 35, kWindowWidth-10, 32)];
    dltOpenView.tag = 9111;
    [self addSubview:dltOpenView];

    for (int i=0; i<7; i++)
    {
        UIImageView* redBall = [[UIImageView alloc] initWithFrame:CGRectMake(i*(5+32), 0, 32, 32)];
        redBall.image = [UIImage imageNamed:@"redBall"];
        [dltOpenView addSubview:redBall];
        
        
        UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*(5+32), 0, 32, 32)];
        numLabel.tag = 7001+i;//2001--2005 开奖红球1-5位
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.font = [UIFont systemFontOfSize:18];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [dltOpenView addSubview:numLabel];
        
        
        
    }
    
    for (int i=0; i<1; i++)
    {
        UIImageView* blueBall = [[UIImageView alloc] initWithFrame:CGRectMake(7*(32+5)+i*(5+32), 0, 32, 32)];
        blueBall.image = [UIImage imageNamed:@"blueBall"];
        [dltOpenView addSubview:blueBall];
        
        
        
        UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(7*(32+5)+i*(5+32), 0, 32, 32)];
        numLabel.tag = 7008+i;//2006--2007 开奖蓝球1-2位
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.font = [UIFont systemFontOfSize:18];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [dltOpenView addSubview:numLabel];
        
        
        
    }
    
}
//海南4+1开奖图初始化
-(void)loadHN4J1OpenView:(NSString*)drawCode
{
    //大乐透开奖图
    UIView* dltOpenView = [[UIView alloc] initWithFrame:CGRectMake(10, 35, kWindowWidth, 32)];
    dltOpenView.tag = 2000;
    [self addSubview:dltOpenView];
    
    for (int i=0; i<4; i++)
    {
        UIImageView* redBall = [[UIImageView alloc] initWithFrame:CGRectMake(i*(5+32), 0, 32, 32)];
        redBall.image = [UIImage imageNamed:@"redBall"];
        [dltOpenView addSubview:redBall];
        
        UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*(5+32), 0, 32, 32)];
        numLabel.tag = 2001+i;//2001--2004 开奖红球1-4位
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.font = [UIFont systemFontOfSize:18];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [dltOpenView addSubview:numLabel];
        
    }
    
    UIImageView* blueBall = [[UIImageView alloc] initWithFrame:CGRectMake(4*(32+5), 0, 32, 32)];
    blueBall.image = [UIImage imageNamed:@"blueBall"];
    [dltOpenView addSubview:blueBall];
    
    UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(4*(32+5), 0, 32, 32)];
    numLabel.tag = 2005;//蓝球
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.font = [UIFont systemFontOfSize:18];
    numLabel.textColor = [UIColor whiteColor];
    numLabel.textAlignment = NSTextAlignmentCenter;
    [dltOpenView addSubview:numLabel];
    
    
}
//传统足彩开奖图初始化
-(void)loadZCOpenView:(NSString*)drawCode
{
    //传统足彩开奖图
    UIView* zcOpenView = [[UIView alloc] initWithFrame:CGRectMake(10, 35, kWindowWidth, 35)];
    zcOpenView.tag = 3000;
    [self addSubview:zcOpenView];
    
    NSArray* numberArr = [drawCode componentsSeparatedByString:@","];
    for (int i=0; i<numberArr.count; i++)
    {
        UIImageView* greenBall = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 17, 35)];
        greenBall.tag = 3101+i;
        [zcOpenView addSubview:greenBall];
        
        UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 17, 35)];
        numLabel.tag = 3001+i;
        //numLabel.backgroundColor = kGreenBallColor;
        numLabel.font = [UIFont systemFontOfSize:15];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        //numLabel.layer.cornerRadius = 3;
        //numLabel.layer.masksToBounds = YES;
        [zcOpenView addSubview:numLabel];
        
    }
}
//七星彩 排列3 排列5开奖图初始化
-(void)loadSzcOpenView:(NSString*)drawCode
{
    //数字彩开奖图
    UIView* szcOpenView = [[UIView alloc] initWithFrame:CGRectMake(10, 35, kWindowWidth, 32)];
    szcOpenView.tag = 4000;
    [self addSubview:szcOpenView];
    
    NSArray* numberArr = [drawCode componentsSeparatedByString:@","];
    for (int i=0; i<numberArr.count; i++)
    {
        UIImageView* redBall = [[UIImageView alloc] initWithFrame:CGRectMake(i*(5+32), 0, 32, 32)];
        redBall.image = [UIImage imageNamed:@"redBall"];
        [szcOpenView addSubview:redBall];
        
        UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*(5+32), 0, 32, 32)];
        numLabel.tag = 4001+i;
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.font = [UIFont systemFontOfSize:18];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [szcOpenView addSubview:numLabel];
    }
    
}

-(void)setItem:(NSDictionary *)item hasDetail:(BOOL)hasDetail
{
    float y = 0;
    CGSize size = CGSizeMake(kWindowWidth,kWindowHeight);
    
    CGSize lotteryNameSize = [[item objectForKey:@"lotteryName"] sizeWithFont:_lotteryName.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    [_lotteryName setFrame:CGRectMake(10,10, lotteryNameSize.width, lotteryNameSize.height)];
    
    NSString* issue = [item objectForKey:@"issue"];
    CGSize issueSize = [[NSString stringWithFormat:@"第%@期",issue] sizeWithFont:_issue.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    [_issue setFrame:CGRectMake(CGRectGetMaxX(_lotteryName.frame)+10, 12, issueSize.width, issueSize.height)];

    //CGSize drawTime = [item.drawTime sizeWithFont:_drawTime.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    [_drawTime setFrame:CGRectMake(CGRectGetMaxX(_issue.frame)+10, 13, 200, 12)];
    
    //玩法标题
    _lotteryName.text = [item objectForKey:@"lotteryName"];
    //开奖期号
    _issue.text = [NSString stringWithFormat:@"第%@期",[item objectForKey:@"issue"]];
    if(hasDetail){
        _issue.textColor = [UIColor blackColor];
    }
    NSString* drawTime = @"";
    NSString* year = @"";
    NSString* month = @"";
    NSString* day = @"";
    //开奖时间
    if (![[item objectForKey:@"drawTime"] isEqualToString:@""]) {
        drawTime = [[item objectForKey:@"drawTime"] substringToIndex:8];
        year = [drawTime substringToIndex:4];
        month = [[drawTime substringFromIndex:4] substringToIndex:2];
        day = [[drawTime substringFromIndex:4] substringFromIndex:2];
    }
    
    //week计算
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *weekDate = [dateFormatter dateFromString:drawTime];
    NSString* week = [UZStaticTools weekdayStringFromDate:weekDate];
    
    //开奖时间 格式化
    _drawTime.text = [NSString stringWithFormat:@"%@-%@ (%@)",month,day,week];
    
    
    //开奖图数据源
    NSString* lotteryId = _lotteryId;
    NSString* drawCode = [item objectForKey:@"drawCode"];
    NSString* drawCodeExt = [item objectForKey:@"drawCodeExt"];
    
    if ([lotteryId isEqualToString:@"JCZQ"])
    {
        _issue.text = @"";
        [_drawTime setViewX:CGRectGetMaxX(_lotteryName.frame) + 10];
        NSArray* arr = [drawCode componentsSeparatedByString:@";"];
        NSArray* teamArr = [arr[0] componentsSeparatedByString:@":"];
        
        NSString* team1 = teamArr[0];
        NSString* team2 = teamArr[1];
        
        NSString* score = arr[1];
        
        _jczqCodeLabel.uzText = [NSString stringWithFormat:@"%@ %@ %@",team1,score,team2];
        
        CGFloat maxX = kWindowWidth - 40;
        if (maxX < CGRectGetMaxX(_jczqCodeLabel.frame))
        {
            [_jczqCodeLabel setViewWidth:kWindowWidth-110];
            _jczqCodeLabel.adjustsFontSizeToFitWidth = YES;
        }
        [_jczqBgView setViewWidth:CGRectGetMaxX(_jczqCodeLabel.frame)-10];
    }
    else if ([lotteryId isEqualToString:@"JCLQ"])
    {
        _issue.text = @"";
        [_drawTime setViewX:CGRectGetMaxX(_lotteryName.frame) + 10];
        NSArray* arr = [drawCode componentsSeparatedByString:@";"];
        NSArray* teamArr = [arr[0] componentsSeparatedByString:@":"];
        
        NSString* team1 = teamArr[0];
        NSString* team2 = teamArr[1];
        
        NSString* score = arr[1];
        
        _jclqCodeLabel.uzText = [NSString stringWithFormat:@"%@ %@ %@",team1,score,team2];
        
        CGFloat maxX = kWindowWidth - 40;
        if (maxX < CGRectGetMaxX(_jclqCodeLabel.frame))
        {
            [_jclqCodeLabel setViewWidth:kWindowWidth-110];
            _jclqCodeLabel.adjustsFontSizeToFitWidth = YES;
        }
        [_jclqBgView setViewWidth:CGRectGetMaxX(_jclqCodeLabel.frame)-10];
    }
    else if([lotteryId isEqualToString:@"DLT"])
    {
        
        NSRange range = [drawCode rangeOfString:@"|"];
        NSString* redCode = [drawCode substringToIndex:range.location];
        NSString* blueCode = [drawCode substringFromIndex:range.location+range.length];
        
        NSArray* redArr = [redCode componentsSeparatedByString:@","];
        NSArray* blueArr = [blueCode componentsSeparatedByString:@","];
        
        UIView* dltOpenView = [self viewWithTag:2000];
        UIView* dltOpenView1 = [self viewWithTag:2016];
        UILabel *label = [self viewWithTag:2017];
        dltOpenView1.hidden = YES;
        label.hidden = YES;
        for (int i=0; i<7; i++)
        {
            UILabel* numLabel = (UILabel*)[dltOpenView viewWithTag:2001+i];
            if (i<=[redArr count]-1)//红球Label
            {
                numLabel.text = redArr[i];
            }
            else//蓝球Label
            {
                numLabel.text = blueArr[i-[redArr count]];
            }
        }
        if([drawCodeExt length]>0){
            
            NSRange range1 = [drawCodeExt rangeOfString:@"|"];
            NSString* redCode1 = [drawCodeExt substringToIndex:range1.location];
            NSString* blueCode1 = [drawCodeExt substringFromIndex:range1.location+range1.length];
            
            NSArray* redArr1 = [redCode1 componentsSeparatedByString:@","];
            NSArray* blueArr1 = [blueCode1 componentsSeparatedByString:@","];
            
            dltOpenView1.hidden = NO;
            label.hidden = NO;
            for (int i=0; i<7; i++)
            {
                UILabel* numLabel = (UILabel*)[dltOpenView1 viewWithTag:3001+i];
                if (i<=4)//红球Label
                {
                    numLabel.text = redArr1[i];
                }
                else//蓝球Label
                {
                    numLabel.text = blueArr1[i-5];
                }
            }
        }
        
    }
    else if([lotteryId isEqualToString:@"SSQ"])
    {
        
        NSRange range = [drawCode rangeOfString:@"|"];
        NSString* redCode = [drawCode substringToIndex:range.location];
        NSString* blueCode = [drawCode substringFromIndex:range.location+range.length];
        
        NSArray* redArr = [redCode componentsSeparatedByString:@","];
        NSArray* blueArr = [blueCode componentsSeparatedByString:@","];
        
        UIView* dltOpenView = [self viewWithTag:5431];
        UIView* dltOpenView1 = [self viewWithTag:2018];
        UILabel *label = [self viewWithTag:2017];
        dltOpenView1.hidden = YES;
        label.hidden = YES;
        for (int i=0; i<7; i++)
        {
            UILabel* numLabel = (UILabel*)[dltOpenView viewWithTag:4001+i];
            if (i<=5)//红球Label
            {
                numLabel.text = redArr[i];
            }
            else//蓝球Label
            {
                numLabel.text = blueArr[i-6];
            }
        }

        
    }
    else if([lotteryId isEqualToString:@"QLC"])
    {
        
        NSRange range = [drawCode rangeOfString:@"|"];
        NSString* redCode = [drawCode substringToIndex:range.location];
        NSString* blueCode = [drawCode substringFromIndex:range.location+range.length];
        
        NSArray* redArr = [redCode componentsSeparatedByString:@","];
        NSArray* blueArr = [blueCode componentsSeparatedByString:@","];
        
        UIView* dltOpenView = [self viewWithTag:9111];
        
        for (int i=0; i<8; i++)
        {
            UILabel* numLabel = (UILabel*)[dltOpenView viewWithTag:7001+i];
            if (i<=6)//红球Label
            {
                numLabel.text = redArr[i];
            }
            else//蓝球Label
            {
                numLabel.text = blueArr[i-7];
            }
        }
        
        
    }
    else if([lotteryId isEqualToString:@"HN4J1"])
    {
        
        NSRange range = [drawCode rangeOfString:@"|"];
        NSString* redCode = [drawCode substringToIndex:range.location];
        NSString* blue = [drawCode substringFromIndex:range.location+range.length];//蓝球
        
        NSArray* redArr = [redCode componentsSeparatedByString:@","];
        
        UIView* dltOpenView = [self viewWithTag:2000];
        for (int i=0; i<5; i++)
        {
            UILabel* numLabel = (UILabel*)[dltOpenView viewWithTag:2001+i];
            if (i<4)//红球Label
            {
                numLabel.text = redArr[i];
            }
            else//蓝球Label
            {
                numLabel.text = blue;
            }
        }
        
    }
    else if ([lotteryId isEqualToString:@"ZC_SFC"]||
             [lotteryId isEqualToString:@"ZC_R9"]||
             [lotteryId isEqualToString:@"ZC_JQ"]||
             [lotteryId isEqualToString:@"ZC_BQC"])
    {
        NSArray* numberArr = [drawCode componentsSeparatedByString:@","];
        
        UIView* zcOpenView = [self viewWithTag:3000];
        
        CGFloat maxX = 0;
        for (int i=0; i<numberArr.count; i++)
        {
            int width = 17;
            if ([numberArr[i] length]>1)
            {
                width = 30;//兼容3+
            }
            UIImageView* greenBall = (UIImageView*)[zcOpenView viewWithTag:3101+i];
            greenBall.frame = CGRectMake(maxX, 0, width, 35);
            
            UIImage* image =[UIImage imageNamed:@"open_green"];
            image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
            greenBall.image = image;
            
            UILabel* numLabel = (UILabel*)[zcOpenView viewWithTag:3001+i];
            numLabel.frame = CGRectMake(maxX, 0, width, 35);
            numLabel.text = numberArr[i];
            maxX = CGRectGetMaxX(numLabel.frame)+5;
        }
        
    }
    else if ([lotteryId isEqualToString:@"PL3"]||
             [lotteryId isEqualToString:@"PL5"]||
             [lotteryId isEqualToString:@"QXC"]||
             [lotteryId isEqualToString:@"FC3D"]||
             [lotteryId isEqualToString:@"QYH"]||
             [lotteryId isEqualToString:@"C511"])
    {
        NSArray* numberArr = [drawCode componentsSeparatedByString:@","];
        
        UIView* szcOpenView = [self viewWithTag:4000];
        for (int i=0; i<numberArr.count; i++)
        {
            UILabel* numLabel = (UILabel*)[szcOpenView viewWithTag:4001+i];
            numLabel.text = numberArr[i];
        }
        
    }
    //是否包含详细列表
    if (hasDetail)
    {
        //移除非复用控件
        UIView* removView = [self viewWithTag:1000];
        [removView removeFromSuperview];
        
        UIView* detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 75, kWindowWidth, 0)];
        detailView.tag = 1000;
        [self addSubview:detailView];
        
        //开奖详情图
        NSInteger labelWidth = kWindowWidth/2;
        UILabel* benqiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, labelWidth, 12)];
        benqiLabel.text = @"本期销量(元)";
        benqiLabel.textAlignment = NSTextAlignmentCenter;
        benqiLabel.font = [UIFont systemFontOfSize:12];
        benqiLabel.textColor = kFontGrayColor;
        [detailView addSubview:benqiLabel];
        
        NSString* saleTotal = [item objectForKey:@"saleTotal"];
        UILabel* xiaoliang = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, labelWidth, 12)];
        xiaoliang.text = [StaticTools fenToyuan:saleTotal];
        xiaoliang.textColor = kRedBallColor;
        xiaoliang.textAlignment = NSTextAlignmentCenter;
        xiaoliang.font = [UIFont systemFontOfSize:12];
        [detailView addSubview:xiaoliang];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth, 0, 1, 47)];
        [line setBackgroundColor:[UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1]];
        [detailView addSubview:line];
        
        UILabel* jiangchiLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth, 5, labelWidth, 12)];
        jiangchiLabel.text = @"累计奖池(元)";
        jiangchiLabel.textAlignment = NSTextAlignmentCenter;
        jiangchiLabel.font = [UIFont systemFontOfSize:12];
        jiangchiLabel.textColor = kFontGrayColor;
        [detailView addSubview:jiangchiLabel];
        
        NSString* remainTotal = [item objectForKey:@"remainTotal"];
        UILabel* leiji = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth, 25, labelWidth, 12)];
        leiji.text = [StaticTools fenToyuan:remainTotal];
        leiji.textColor = kRedBallColor;
        leiji.textAlignment = NSTextAlignmentCenter;
        leiji.font = [UIFont systemFontOfSize:12];
        [detailView addSubview:leiji];
        
        UILabel *lineabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(xiaoliang.frame)+5, kWindowWidth, 10)];
        [lineabel setBackgroundColor:cF1F0F1];
        [detailView addSubview:lineabel];
        
        
        UILabel* winLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineabel.frame), kWindowWidth, 30)];
        [winLabel setBackgroundColor:cFFFFFF];
        [winLabel setTextAlignment:NSTextAlignmentCenter];
        [winLabel setText:@"中奖情况"];
        [winLabel setFont:kFontSizeExplanation_15];
        [detailView addSubview:winLabel];
        
        for (int j = 0; j<3; j++)
        {
            UILabel* label = [[UILabel alloc] init];
            label.backgroundColor = cF7F7F7;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = c333333;
            label.font = [UIFont systemFontOfSize:12];
            label.frame = CGRectMake(j*((kWindowWidth-4)/3+1), CGRectGetMaxY(winLabel.frame), (kWindowWidth-4)/3, 30);
            [detailView addSubview:label];
            if (j == 0)
            {
                label.text = @"奖项";
            }
            if (j == 1)
            {
                label.text = @"注数";
            }
            if (j == 2)
            {
                label.text = @"奖金";
            }
            y = CGRectGetMaxY(label.frame);
        }
        
        CGFloat startY = CGRectGetMaxY(winLabel.frame)+30;
        NSArray* items = [item objectForKey:@"items"];
        //开奖等级图标
        for (int i = 0; i<[items count]; i++)
        {
            for (int j=0; j<3; j++)
            {
                UILabel* label = [[UILabel alloc] init];
                label.tag = 1000;
                //label.backgroundColor = [UIColor redColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.adjustsFontSizeToFitWidth = YES;
                label.font = [UIFont systemFontOfSize:12];
                label.frame = CGRectMake(j*((kWindowWidth-4)/3+1), startY+40*i, (kWindowWidth-4)/3, 40);
                [detailView addSubview:label];
                if (j == 0)
                {
                    label.text = [items[i] objectForKey:@"name"];
                    label.textColor = kFontGrayColor;
                }
                if (j == 1)
                {
                    label.text = [items[i] objectForKey:@"count"];
                    label.textColor = kRedBallColor;
                }
                if (j == 2)
                {
                    label.text = [NSString stringWithFormat:@"%@元",[StaticTools fenToyuan:[items[i] objectForKey:@"money"]]];
                    label.textColor = kRedBallColor;
                }
                y = CGRectGetMaxY(label.frame);
                
            }
            
        }
        
        //绘制表格
        for (int i=0; i<[items count]+2; i++)
        {
            for (int j=0; j<3; j++)
            {
                UILabel* label = [[UILabel alloc] init];
                label.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
                label.frame = CGRectMake(0, startY+40*i, kWindowWidth, 1);
                [detailView addSubview:label];
            }
            
        }
        for (int i=0; i<2; i++) {
            UILabel* label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
            label.frame = CGRectMake((kWindowWidth)/3*(i+1), startY, 1, [items count]*40);
            [detailView addSubview:label];
        }
        
        
        startY += [items count]*40;
        
        
        
        
        //赛事对阵
        if ([lotteryId isEqualToString:@"ZC_SFC"]||
            [lotteryId isEqualToString:@"ZC_R9"]||
            [lotteryId isEqualToString:@"ZC_JQ"]||
            [lotteryId isEqualToString:@"ZC_BQC"])
        {
            
            UILabel *lineabel1  = [[UILabel alloc] initWithFrame:CGRectMake(0, startY, kWindowWidth, 10)];
            [lineabel1 setBackgroundColor:cF1F0F1];
            [detailView addSubview:lineabel1];
            startY = CGRectGetMaxY(lineabel1.frame);
            UILabel* vsDetailLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, startY, kWindowWidth, 30)];
            [vsDetailLabel setBackgroundColor:cFFFFFF];
            [vsDetailLabel setTextAlignment:NSTextAlignmentCenter];
            [vsDetailLabel setText:@"对阵详情"];
            [vsDetailLabel setFont:kFontSizeExplanation_15];
            [detailView addSubview:vsDetailLabel];
            
            startY = CGRectGetMaxY(vsDetailLabel.frame);
            UILabel *lineabel2  = [[UILabel alloc] initWithFrame:CGRectMake(0, startY, kWindowWidth, 5)];
            [lineabel2 setBackgroundColor:cF1F0F1];
            [detailView addSubview:lineabel2];
            
            startY = CGRectGetMaxY(lineabel2.frame);
            
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, startY+80, kWindowWidth, 0)];
            bgView.backgroundColor = [UIColor clearColor];
            [self addSubview:bgView];
            NSArray *arr = [NSArray arrayWithObjects:@"编号",@"主队",@"客队",@"赛果", nil];
            if ([lotteryId isEqualToString:@"ZC_JQ"]) {
                
                arr = [NSArray arrayWithObjects:@"编号",@"主队",@"客队",@"主客",@"赛果", nil];
                
            }else if ([lotteryId isEqualToString:@"ZC_BQC"]){
                
                arr = [NSArray arrayWithObjects:@"编号",@"主队",@"客队",@"半全",@"赛果", nil];
            }
            
            UILabel* label = nil;
            float x = 0;
            float width = (CGRectGetWidth(bgView.frame)+arr.count)/arr.count;
            for(int j=0;j<arr.count;j++){
                label = [[UILabel alloc] initWithFrame:CGRectMake(x, -5, width, 40)];
                label.textAlignment = NSTextAlignmentCenter;
                [label setBackgroundColor:cF7F7F7];
                label.textColor = c333333;
                label.adjustsFontSizeToFitWidth = YES;
                label.font = [UIFont systemFontOfSize:12];
                label.text = [arr objectAtIndex:j];
                label.layer.borderWidth = 0.8;
                label.layer.borderColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1].CGColor;
                [bgView addSubview:label];
                x = CGRectGetMaxX(label.frame)-1;
            }
            
            
            
            NSArray *vsInfos = [_raceAgainst objectForKey:@"vsInfos"];
            
            if([vsInfos count]>0){
                for(int i=0;i<[vsInfos count];i++){
                    
                    NSDictionary *dic = [vsInfos objectAtIndex:i];
                    
                    if ([lotteryId isEqualToString:@"ZC_JQ"] || [lotteryId isEqualToString:@"ZC_BQC"]) {
                        
                        
                        
                        
                        x = 0;
                        y = CGRectGetMaxY(label.frame);
                        for(int j=0;j<5;j++){
                            
                            label = [[UILabel alloc] initWithFrame:CGRectMake(x, y-1, width, 40)];
                            label.textAlignment = NSTextAlignmentCenter;
                            label.textColor = kFontGrayColor;
                            label.adjustsFontSizeToFitWidth = YES;
                            label.font = [UIFont systemFontOfSize:12];
                            label.layer.borderWidth = 0.8;
                            label.layer.borderColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1].CGColor;
                            
                            
                            NSString *homeTeam =[[[dic objectForKey:@"teamInfo"] componentsSeparatedByString:@":"] objectAtIndex:0];
                            NSString *visitingTeam =[[[dic objectForKey:@"teamInfo"] componentsSeparatedByString:@":"] objectAtIndex:1];
                            NSArray *temArr = [[dic objectForKey:@"result"] componentsSeparatedByString:@","];
                            
                            
                            
                            if (j == 3 || j == 4) {
                                
                                UILabel *tmpLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0, width, 19.5)];
                                tmpLabel1.textColor = kFontGrayColor;
                                tmpLabel1.textAlignment = NSTextAlignmentCenter;
                                tmpLabel1.adjustsFontSizeToFitWidth = YES;
                                tmpLabel1.font = [UIFont systemFontOfSize:12];
                                UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 19.5, width, 1)];
                                [line setBackgroundColor:[UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1]];
                                UILabel *tmpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20.5, width, 19.5)];
                                tmpLabel2.textColor = kFontGrayColor;
                                tmpLabel2.textAlignment = NSTextAlignmentCenter;
                                tmpLabel2.adjustsFontSizeToFitWidth = YES;
                                tmpLabel2.font = [UIFont systemFontOfSize:12];
                                [label addSubview:tmpLabel1];
                                [label addSubview:line];
                                [label addSubview:tmpLabel2];
                                
                                if ([lotteryId isEqualToString:@"ZC_JQ"]) {
                                    
                                    if (j == 3) {
                                        tmpLabel1.text = @"主";
                                        tmpLabel2.text = @"客";
                                    }
                                }
                                
                                if ([lotteryId isEqualToString:@"ZC_BQC"]) {
                                    
                                    if (j == 3) {
                                        tmpLabel1.text = @"半";
                                        tmpLabel2.text = @"全";
                                    }
                                }
                                
                                if (j ==4) {
                                    
                                    tmpLabel1.text = temArr[0];
                                    tmpLabel2.text = temArr[1];
                                }
                                
                            }
                            [bgView addSubview:label];
                            x = CGRectGetMaxX(label.frame)-1;
                            
                            
                            
                            
                            switch (j) {
                                case 0:
                                    label.text = [NSString stringWithFormat:@"%d",i+1];
                                    break;
                                case 1:
                                    label.text = homeTeam;
                                    break;
                                case 2:
                                    label.text = visitingTeam;
                                    break;
                            }
                        }
                        
                        
                    }else{
                        
                        
                        x = 0;
                        y = CGRectGetMaxY(label.frame);
                        for(int j=0;j<4;j++){
                            label = [[UILabel alloc] initWithFrame:CGRectMake(x, y-1, width, 40)];
                            label.textAlignment = NSTextAlignmentCenter;
                            label.textColor = kFontGrayColor;
                            label.adjustsFontSizeToFitWidth = YES;
                            label.font = [UIFont systemFontOfSize:12];
                            label.layer.borderWidth = 0.8;
                            label.layer.borderColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1].CGColor;
                            [bgView addSubview:label];
                            x = CGRectGetMaxX(label.frame)-1;
                            
                            NSString *homeTeam =[[[dic objectForKey:@"teamInfo"] componentsSeparatedByString:@":"] objectAtIndex:0];
                            NSString *visitingTeam =[[[dic objectForKey:@"teamInfo"] componentsSeparatedByString:@":"] objectAtIndex:1];
                            
                            NSString *scro = [dic objectForKey:@"result"] ;
                            
                            
                            switch (j) {
                                case 0:
                                    label.text = [NSString stringWithFormat:@"%d",i+1];
                                    break;
                                case 1:
                                    label.text = homeTeam;
                                    break;
                                case 2:
                                    label.text = visitingTeam;
                                    break;
                                case 3:
                                    label.text = scro;
                                    break;
                                    
                                default:
                                    break;
                            }
                        }
                    }
                    
                }
            }
            [bgView setViewHeight:CGRectGetMaxY(label.frame)];
        }
    }
    UIView* dltOpenView1 = [self viewWithTag:2016];
    UILabel *label = [self viewWithTag:2017];
    [label setViewY:y+80];
    [dltOpenView1 setViewY:CGRectGetMaxY(label.frame)+5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
    // Configure the view for the selected state
}

@end
