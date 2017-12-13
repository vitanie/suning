//
//  LotteryHallVC.m
//  suning
//
//  Created by 白云皓 on 2017/12/13.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "LotteryHallVC.h"
#import "DMScrollingTicker.h"
#import "XLsn0wLoop.h"
#import "XLsn0wTextCarousel.h"
#import "DataSourceModel.h"
#import "LotteryHallCollectionCell.h"


#define CellWidthSpace   0
#define CellWidth       kWindowWidth/3
#define CellHeight      95
#define CellLineSpace   0

@interface LotteryHallVC ()<SNNavigationDelegate,XLsn0wLoopDelegate,TextInfoViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
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
@property (nonatomic, strong) XLsn0wLoop *loop;
@property (nonatomic,strong) UIScrollView *mainScroll;

@end

@implementation LotteryHallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _navigationView = [[SNNavigation alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kNavigationHeight) title:@"购彩大厅" isBack:NO isHelp:NO];
    [self.view addSubview:_navigationView];
    
    self.mainScroll = [[UIScrollView alloc] init];
    [self.mainScroll setFrame:CGRectMake(0, kNavigationHeight, kWindowWidth, kWindowHeight-kNavigationHeight)];
    [self.mainScroll setContentSize:CGSizeMake(kWindowWidth, 1000)];
    [self.mainScroll setBackgroundColor:[UIColor clearColor]];
    [self.mainScroll setShowsVerticalScrollIndicator:NO];
    [self.mainScroll setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:self.mainScroll];
    
    _lotteryCollection.delegate = self;
    _lotteryCollection.dataSource = self;
    
    [_lotteryCollection registerNib:[UINib nibWithNibName:@"LotteryHallCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"Collection"];
    
    //刷新控件
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置header
    self.mainScroll.header = header;
    
    [self loadNewData];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(refreshPaoma)
//                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
}
//刷新新数据
-(void)loadNewData
{
    _items = nil;
    _items = [[NSMutableArray alloc] init];
    
    //加载广告
    [self loadAdView];
    //加载首页
//    [self loadHallView];
    [_mainScroll.header endRefreshing];
    
}
-(void)loadAdView
{
    
    NSDictionary* reqDic = @{@"id":@"1"};
    _imageURLs = [[NSMutableArray alloc] init];
    _actions = [[NSMutableArray alloc] init];
    [[SNNetwork shard] reqWithCommand:@"ADV1000" body:reqDic mode:@"1" success:^(id res) {

        _advs = [res objectForKey:@"adv"];
        NSLog(@"广告:%@",_advs);
        [self addLoop];
    } failure:^(NSError *errors) {
        
    }];
    
}
- (void)addLoop {
    NSMutableArray* imageURLs = [NSMutableArray array];
    NSMutableArray* actions = [NSMutableArray array];
    for (int i=0; i<_advs.count; i++)
    {
        [imageURLs addObject:[_advs[i] objectForKey:@"imageUrl"]];
        [actions addObject:[_advs[i] objectForKey:@"action"]];
    }
    if ([_advs count] > 0) {
        if(self.loop){
            
            //支持gif动态图
            [self.loop setImageArray:imageURLs];
            //            self.loop.imageArray = imageURLs;
        } else {
            self.loop = [[XLsn0wLoop alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, 270*kWindowWidth/640)];
            [self.mainScroll addSubview:self.loop];
            self.loop.xlsn0wDelegate = self;
            self.loop.time = 7;
            [self.loop setPageColor:[UIColor lightGrayColor] andCurrentPageColor:[UIColor darkGrayColor]];
            //支持gif动态图
            
            self.loop.imageArray = imageURLs;
        }
        
    }
    [self loadHallView];
}
-(void)loadHallView
{
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"",@"lotteryId", nil];
    //在售玩法请求
    [[SNNetwork shard] reqWithCommand:@"LTY1000" body:dic mode:@"1" success:^(id res) {
        //加载数据源
        if ([_items containsObject:_halls]) {
            
            [_items removeObject:_halls];
        }
        
        _halls = [res objectForKey:@"items"];
        
        
        [_items addObject:_halls];
        
        [self createCollectionView];
        
        
    } failure:^(NSError *errors) {
        
        NSLog(@"%@",errors);
    }];

}
-(void)createCollectionView
{
    [_lotteryCollection removeFromSuperview];
    [_mainScroll addSubview:_lotteryCollection];
    
    if([_advs count] > 0){
        
    } else {
        [_lotteryCollection setViewY:5];
    }
    
    
    if(_lotteryCollection){
        [_lotteryCollection reloadData];
    } else {
        
        
        
        
        
        
        
        
        
        [_lotteryCollection reloadData];
        
    }
}
#pragma mark XRCarouselViewDelegate
- (void)loopView:(XLsn0wLoop *)loopView clickImageAtIndex:(NSInteger)index {
    NSDictionary *dic = [_advs objectAtIndex:index];
    NSString *imgurl = [dic objectForKey:@"imageUrl"];
    NSString *action = [dic objectForKey:@"action"];
    NSLog(@"action:%@,url:%@",action,imgurl);
    
    NSDictionary *cmdDic = [action JSONObject];
    
    if([[cmdDic objectForKey:@"cmd"] isEqualToString:@"specialurl"]){
        
        
        
    } else if([[cmdDic objectForKey:@"cmd"] isEqualToString:@"url"]){
        
        
        
    } else {
        
    }
    
    
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
        
        if ([_messages count] != 0) {
            [self createToplineView];
        } else {
            
        }
    }failure:^(NSError *errors) {
    }];
    
}
//生成跑马灯
- (void)createToplineView{
    
    NSMutableArray *dataSourceArray = [[NSMutableArray alloc] init];
    
    
    for (int i = 0; i < _messages.count; i++) {
        NSDictionary *dic = [_messages objectAtIndex:i];
        NSString *full = [dic objectForKey:@"winMsg"];
        NSRange range = [full rangeOfString:@":"];
        if(range.location != NSNotFound){
            NSString *beforeStr = [[full componentsSeparatedByString:@":"] objectAtIndex:0];
            NSString *afterStr = [[full componentsSeparatedByString:@":"] objectAtIndex:1];
            
            DataSourceModel *model = [DataSourceModel dataSourceModelWithType:afterStr title:beforeStr URLString:@"" subString:full];
            [dataSourceArray addObject:model];
        } else {
            
            
            DataSourceModel *model = [DataSourceModel dataSourceModelWithType:full title:@"" URLString:@"" subString:full];
            [dataSourceArray addObject:model];
        }
        
        
    }
    XLsn0wTextCarousel *view = [[XLsn0wTextCarousel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_loop.frame)+6, kWindowWidth, 30)];
    view.dataSourceArray = dataSourceArray;
    view.currentTextInfoView.xlsn0wDelegate = self;
    view.hiddenTextInfoView.xlsn0wDelegate = self;
    view.backgroundColor = [UIColor whiteColor];
    [self.mainScroll addSubview:view];
    
    UIImageView *logo = [UIImageView new];
    [self.mainScroll addSubview:logo];
    [logo setFrame:(CGRectMake(10,CGRectGetMaxY(_loop.frame)+11, 20, 20))];
    [logo setImage:[UIImage imageNamed:@"icon_broadcasting"]];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDelegateFlowLayout
//设置每个Cell 的宽高
- (CGSize)collectionView:(UICollectionView *)collectionView  layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake(CellWidth, CellHeight);
}
//设置Cell 之间的间距 （上，左，下，右）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(CellLineSpace, CellWidthSpace, CellLineSpace, CellWidthSpace);
}

#pragma mark UICollectionViewDataSource
//设置九宫格Cell 的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //    return 6 + [_btnList count];
    return _halls.count;
}
//设置Cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LotteryHallCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Collection" forIndexPath:indexPath];

    NSDictionary *dic = [_halls objectAtIndex:indexPath.row];
    
    cell.name.text = [dic objectForKey:@"lotteryName"];
    NSString* lotteryId = [dic objectForKey:@"lotteryId"];
    NSString* logo = [StaticTools transLotteryImageName:lotteryId];
    [cell.img setImage:[UIImage imageNamed:logo]];
    
    //今日开奖
    NSString* isToday = [dic objectForKey:@"isToday"];
    
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
//        cell.jiao.frame = CGRectMake(CGRectGetWidth(cell.jiao.frame) - widthS - 5, 5, widthS, heightS);
        
    }else
    {
        
        
        
    }
    [cell.jiao setImage:tadayImage];
    
    
    //加奖 火爆 夜场 最新
    NSString* icon = [dic objectForKey:@"icon"];
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
    else if([icon isEqualToString:@"5"]) {
        image = @"n_ts";
    }
    else {
        image = @"n_ts";
        cell.jiao.hidden = YES;
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
//    cell.jiao.frame = CGRectMake(CGRectGetWidth(cell.jiao.frame) - widthS - 5, 5, widthS, heightS);
    
    [cell.jiao setImage:[UIImage imageNamed:image]];
    
    return cell;
}
#pragma mark UICollectionViewDelegate
//设置点击 Cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];//取消选中
    
    NSLog(@"点击的是%ld",indexPath.row);

}

@end
