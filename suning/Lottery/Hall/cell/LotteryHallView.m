//
//  LotteryHallView.m
//  UZLottery
//
//  Created by haochentao on 16/4/15.
//  Copyright © 2016年 kevin. All rights reserved.
//

#import "LotteryHallView.h"


@interface LotteryHallView()
@property (nonatomic, strong) UIImageView* stateView;
@property (nonatomic, strong) UIImageView* iconView;
@property (nonatomic, strong) UIImageView* todayView;
@property (nonatomic, strong) UZLabel* title1;
@property (nonatomic, strong) UILabel* title2;
@property (nonatomic, strong) UILabel* title3;
@property (nonatomic, strong) NSDictionary * dicItem;
@end

@implementation LotteryHallView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width = CGRectGetWidth(frame);
        
        CGFloat startX = 0;

        
        [self createSubView:CGRectMake(startX, 0, width, CGRectGetHeight(frame))];



    }
    
    return self;
}

/**
 *  封装函数创建视图
 *
 *  @param frame 视图
 *  @param item  数据
 */
- (void)createSubView:(CGRect)frame
{
    
    CGFloat width = CGRectGetWidth(frame);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    //图片等高宽
    CGFloat imageWitdh = 40;
    CGFloat cellHeight = 70;
    UIFont *title1Fount = [UIFont systemFontOfSize:14];
    UIFont *title2Fount = [UIFont systemFontOfSize:10];

    if ([StaticTools getVersion] == Iphone5Scale)
    {
        imageWitdh = 40;
        cellHeight = 70;
        title1Fount = [UIFont systemFontOfSize:14];
        title2Fount = [UIFont systemFontOfSize:10];
        
        
    }else if ([StaticTools getVersion] == Iphone6Scale)
    {
        imageWitdh = 48;
        cellHeight = 83;
        title1Fount = [UIFont systemFontOfSize:16];
        title2Fount = [UIFont systemFontOfSize:12];
        
    }else
    {
        imageWitdh = 54;
        cellHeight = 91;
        title1Fount = [UIFont systemFontOfSize:18];
        title2Fount = [UIFont systemFontOfSize:14];
        
    }
    
    
    _iconView = [[UIImageView alloc] init];
    _iconView.frame = CGRectMake(10, (cellHeight-imageWitdh)/2, imageWitdh, imageWitdh);
    [btn addSubview:_iconView];
    
    _title1 = [[UZLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconView.frame) + 10, (cellHeight-20)/2 - 8, width - CGRectGetMaxX(_iconView.frame) - 10, 20)];
    _title1.textColor = kTextFontColor;
    _title1.backgroundColor = [UIColor clearColor];
    _title1.adjustsFontSizeToFitWidth = YES;
    _title1.font = title1Fount;
    [btn addSubview:_title1];

    
    _title2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_title1.frame), _title1.frame.size.height+_title1.frame.origin.y, CGRectGetWidth(_title1.frame) - 10, 80)];
    _title2.textColor = kTextOrangeColor;
    _title2.numberOfLines = 2;
    _title2.adjustsFontSizeToFitWidth = YES;
    _title2.backgroundColor = [UIColor clearColor];
    _title2.font = title2Fount;
    [btn addSubview:_title2];

    
    
    _stateView = [[UIImageView alloc] init];
    _stateView.frame = CGRectMake(width - 20, 0, 20, 10);
    [btn addSubview:_stateView];
    
    
    _todayView = [[UIImageView alloc] init];
    _todayView.frame = CGRectMake(0, 0, width, 60);
    [btn addSubview:_todayView];

    
    CGFloat startHeight = 70;
    if ([StaticTools getVersion] == Iphone5Scale)
    {
        startHeight = 70;
        
        
    }else if ([StaticTools getVersion] == Iphone6Scale)
    {
        startHeight = 83;
        
    }else
    {
        startHeight = 91;
        
    }
    
    //分割线
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, startHeight-SINGLE_LINE_ADJUST_OFFSET, kWindowWidth/2, SINGLE_LINE_WIDTH)];
    line.backgroundColor = kSingleLineColor;
    [self addSubview:line];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(kWindowWidth/2-SINGLE_LINE_ADJUST_OFFSET, 0, SINGLE_LINE_WIDTH, startHeight)];
    line.backgroundColor = kSingleLineColor;
    [self addSubview:line];
    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, startHeight - 1, kWindowWidth/2, 1)];
//    line.backgroundColor = kBackGroundColor;
//    [self addSubview:line];
    
   
    

    
    

}

/**
 *  更新数据
 *
 *  @param item 数据源
 */
-(void)updateInitWithItems:(NSDictionary*)item
{
    
    _dicItem = item;
    //玩法名称;
    NSString* lotteryName = [item objectForKey:@"lotteryName"];
    _title1.text = lotteryName;
    
    
    //更新图标
    
    NSString* lotteryId = [item objectForKey:@"lotteryId"];
    NSString* logo = [StaticTools transLotteryImageName:lotteryId];
    [_iconView setImage:[UIImage imageNamed:logo]];
    
    //今日开奖
    NSString* isToday = [item objectForKey:@"isToday"];
    
    UIImage * tadayImage = [UIImage imageNamed:@"n_kj"];
    if ([isToday isEqualToString:@"1"]) {
        CGSize size = tadayImage.size;
        
        CGFloat widthS = size.width/1.5;
        CGFloat heightS = size.height/1.5;
        if ([StaticTools getVersion] == Iphone5Scale)
        {
            widthS = size.width/2;
            heightS = size.height/2;
            
        }else if ([StaticTools getVersion] == Iphone6Scale)
        {
            widthS = size.width/1.6;
            heightS = size.height/1.6;
            
        }else
        {
            widthS = size.width/1.5;
            heightS = size.height/1.5;
            
        }
        _todayView.frame = CGRectMake(CGRectGetWidth(self.frame) - widthS - 5, 5, widthS, heightS);
        _stateView.hidden = YES;
    }else
    {
        _todayView.hidden = YES;
        _stateView.hidden = NO;

    }
    [_todayView setImage:tadayImage];
    
    
    //加奖 火爆 夜场 最新
    NSString* icon = [item objectForKey:@"icon"];
    NSString* image = nil;
    if ([icon isEqualToString:@"1"]) {
        image = @"n_jj";
    }
    else if([icon isEqualToString:@"2"]) {
        image = @"n_hb";
    }
    else if([icon isEqualToString:@"3"]) {
        image = @"n_zx";
    }
    else if([icon isEqualToString:@"4"]) {
        image = @"n_yc";
    }
    else if([icon isEqualToString:@"4"]) {
        image = @"n_ts";
    }
    else {
        image = @"n_ts";
        _stateView.hidden = YES;
    }
    CGSize size = [UIImage imageNamed:image].size;
    CGFloat widthS = size.width/1.5;
    CGFloat heightS = size.height/1.5;
    if ([StaticTools getVersion] == Iphone5Scale)
    {
        widthS = size.width/2;
        heightS = size.height/2;

    }else if ([StaticTools getVersion] == Iphone6Scale)
    {
        widthS = size.width/1.6;
        heightS = size.height/1.6;

    }else
    {
        widthS = size.width/1.5;
        heightS = size.height/1.5;

    }
    _stateView.frame = CGRectMake(CGRectGetWidth(self.frame) - widthS - 5, 5, widthS, heightS);
    
    [_stateView setImage:[UIImage imageNamed:image]];
    
    
    //描述信息
    NSString* descColor = [item objectForKey:@"descColor"];
    NSString* desc = [item objectForKey:@"desc"];
    size = [desc sizeWithFont:_title2.font constrainedToSize:CGSizeMake(CGRectGetWidth(_title2.frame), 50) lineBreakMode:NSLineBreakByWordWrapping];
    _title2.text = desc;
    _title2.textColor = colorWithHexString(descColor);
    [_title2 setViewHeight:size.height];

    
}

- (void)btnClick:(UIButton *)btn
{
    self.callback(_dicItem);
}
@end
