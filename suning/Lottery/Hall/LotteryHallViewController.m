//
//  LotteryHallViewController.m
//  suning
//
//  Created by Bai on 2017/9/19.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "LotteryHallViewController.h"
#import "LotteryHallTableViewCell.h"

@interface LotteryHallViewController ()<SNNavigationDelegate,UITableViewDataSource,UITableViewDelegate,SNLotteryHallCellDelegate>
@property(nonatomic,strong)SNNavigation* navigationView;
@property(nonatomic,strong)NSMutableArray* items;
@property(nonatomic,strong)NSArray* halls;
@property(nonatomic,strong)NSArray* advs;
@property(nonatomic,strong)NSMutableArray* imageURLs;
@property(nonatomic,strong)NSMutableArray* actions;
@end

@implementation LotteryHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _navigationView = [[SNNavigation alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kNavigationHeight) title:@"购彩大厅" isBack:NO isHelp:NO];
    [self.view addSubview:_navigationView];
    
    
//    [_tableView setFrame:CGRectMake(0, kNavigationHeight-20, kWindowWidth, kWindowHeight - kNavigationHeight -kTabbarHeight)];
    
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //刷新控件
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置header
    _tableView.header = header;
    
    [self loadNewData];
    // Do any additional setup after loading the view.
}
#pragma mark UITableView 代理方法实现

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if ([_halls count] == 0 && [_advs count] == 0) {
        
        return 0;
    }
    if (_halls.count > 0) {
        
        return _halls.count%2 + _halls.count/2 + 1;
        
        
    }
    else if (_halls.count == 0){
        
        return 1;
        
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
        if (_advs.count == 0)
        {
            return 0;
        }
        else
        {
            return 240*kWindowWidth/640;
        }
    }
    
    
    
    
    if ([StaticTools getVersion] == Iphone5Scale)
    {
        return 70;
        
        
    }else if ([StaticTools getVersion] == Iphone6Scale)
    {
        return 83;
        
    }else
    {
        return 91;
        
    }
    
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    static NSString * hallCELL1 = @"hallCELL1";
    
    static NSString * hallCELL2 = @"hallCELL2";
    
    
    LotteryHallTableViewCell* cell1 = [tableView dequeueReusableCellWithIdentifier:hallCELL1];
    
    LotteryHallTableViewCell* cell2 = [tableView dequeueReusableCellWithIdentifier:hallCELL2];
    if (row == 0)
    {
        
        cell1 = [tableView dequeueReusableCellWithIdentifier:hallCELL1];
        for (UIView* v in cell1.subviews)
        {
            [v removeFromSuperview];
        }
        
        if (cell1 == nil) {
            cell1 =[[LotteryHallTableViewCell alloc] initWithAdvs:_advs reuseIdentifier:hallCELL1];
            cell1.delegate = self;
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell1;
        
    }
    else
    {
        
        
        if (cell2 == nil) {
            
            cell2 = [[LotteryHallTableViewCell alloc] initWithItemsReuseIdentifier:hallCELL2 delegate:self];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSInteger rr = row - 1;
        
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        [array addObject:_halls[rr + rr]];
        
        if (rr + rr+1 < _halls.count) {
            
            [array addObject:_halls[rr + rr+1]];
            
        }
        [cell2 updateInitWithItems:array];
        
        return cell2;
        
        
        
    }
    return cell1;
}
//刷新新数据
-(void)loadNewData
{
    _items = nil;
    _items = [[NSMutableArray alloc] init];
    
    //加载广告
    [self loadAdView];
    //加载首页
    [self loadHallView];
    [_tableView.header endRefreshing];
    
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
        NSLog(@"玩法1004:%@",_halls);
        
        [_items addObject:_halls];
        
        [_tableView reloadData];
        
        
    } failure:^(NSError *errors) {
        
        NSLog(@"%@",errors);
    }];
 
}
-(void)loadAdView
{
    
    NSDictionary* reqDic = @{@"id":@"1"};
    _imageURLs = [[NSMutableArray alloc] init];
    _actions = [[NSMutableArray alloc] init];
    if ([_items containsObject:_advs]) {
        
        [_items removeObject:_advs];
    }
    _advs = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"adv"]];
    
    [_items addObject:_advs];
    
//    [[SNNetwork shard] reqWithCommand:@"ADV1000" body:reqDic mode:@"1" success:^(id res) {
//
//        if ([_items containsObject:_advs]) {
//
//            [_items removeObject:_advs];
//        }
//
//
//        _advs = [res objectForKey:@"adv"];
//        NSLog(@"广告:%@",_advs);
//
//        [_items addObject:_advs];
//    } failure:^(NSError *errors) {
//
//    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
