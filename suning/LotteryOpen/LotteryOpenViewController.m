//
//  LotteryOpenViewController.m
//  suning
//
//  Created by Bai on 2017/9/25.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "LotteryOpenViewController.h"
#import "SNLotteryOpenCell.h"

@interface LotteryOpenViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)SNNavigation* navigationView;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSArray* items;
@property(nonatomic,strong)NSDictionary* item;
@property(nonatomic,strong)SNNoData* nodata;
@end

@implementation LotteryOpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _navigationView = [[SNNavigation alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kNavigationHeight) title:@"开奖信息" isBack:NO isHelp:NO];
    [self.view addSubview:_navigationView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kWindowWidth, kWindowHeight - kNavigationHeight - kTabbarHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = kBackGroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = FALSE;
    [self.view addSubview:_tableView];
    
    _nodata = [[SNNoData alloc] initWithFrame:_tableView.bounds];
    [_tableView addSubview:_nodata];
    //刷新控件
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;    _tableView.header = header;
    
    _items = [[NSArray alloc] init];
    
    
    [self loadNewData];
    
    // Do any additional setup after loading the view.
}


-(void)loadNewData
{
    NSDictionary *reqbody = @{@"lotteryIds": @""
                              };
    
    [[SNNetwork shard] reqWithCommand:@"LTY1002" body:reqbody mode:@"3" success:^(id res) {
        
        _items = [res objectForKey:@"items"];
        if (_items.count==0) {
            _nodata.hidden = NO;
        }
        else
        {
            _nodata.hidden = YES;
        }
        [_tableView.header endRefreshing];
        //_body = [LTY1001 objectWithKeyValues:body];
        [_tableView reloadData];
        
    } failure:^(NSError *errors) {
        
        [_tableView.header endRefreshing];
        NSLog(@"errors:%@",errors);
        
    }];
}
#pragma mark UITableView 代理方法实现

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [_items count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSString* lotteryId = [_items[row] objectForKey:@"lotteryId"];
    NSString* drawCode = [_items[row] objectForKey:@"drawCode"];
    NSString * openCell = [NSString stringWithFormat:@"%@",lotteryId];
    
    SNLotteryOpenCell*cell = [tableView dequeueReusableCellWithIdentifier:
                              openCell];
    if (cell == nil)
    {
        cell = [[SNLotteryOpenCell alloc] initWithLotteryId:lotteryId
                                                   drawCode:drawCode
                                            reuseIdentifier:openCell];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.lotteryId = [_items[row] objectForKey:@"lotteryId"];
    [cell setItem:_items[row] hasDetail:NO];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    _item = _items[row];
    
    if ([[_item objectForKey:@"lotteryId"] isEqualToString:@"JCZQ"]) {
        NSLog(@"竞彩足球");
        
    }else
    {
        
    }
    
    
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
