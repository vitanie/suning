//
//  SNZiJinAllVC.m
//  suning
//
//  Created by 白云皓 on 2017/11/10.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "SNZiJinAllVC.h"
#import "SNZiJinAllCell.h"

@interface SNZiJinAllVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSString* sn;
@property(nonatomic,strong)SNNoData* nodata;
@end

@implementation SNZiJinAllVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //记录sn
    _sn = [[_items lastObject] objectForKey:@"sn"];
    
//    self.view.backgroundColor = kBackGroundColor;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight - kNavigationHeight - 32) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    _nodata = [[SNNoData alloc] initWithFrame:_tableView.bounds];
    [_tableView addSubview:_nodata];
    //刷新控件
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置header
    _tableView.header = header;
    
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    [self loadNewData];
}

-(void)loadNewData
{
    NSDictionary* req_body = @{@"startSn":@"",@"group":_type};
    [[SNNetwork shard] reqWithCommand:@"ACT1001" body:req_body mode:@"3" success:^(id body) {
        NSLog(@"资金明细:%@",body);
        _items = [[body objectForKey:@"items"] mutableCopy];
        if (_items.count==0) {
            _nodata.hidden = NO;
        }
        else
        {
            _nodata.hidden = YES;
        }
        _sn = [[_items lastObject] objectForKey:@"sn"];
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        [_tableView.footer resetNoMoreData];
        
    } failure:^(NSError *errors) {
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
    }];
    
}
-(void)loadMoreData
{
    NSDictionary* req_body = @{@"startSn":_sn,@"group":_type};
    [[SNNetwork shard] reqWithCommand:@"ACT1001" body:req_body mode:@"3" success:^(id body) {
        NSLog(@"资金明细:%@",body);
        NSArray* mores = [body objectForKey:@"items"];
        if (mores.count == 0)
        {
            [_tableView.footer noticeNoMoreData];
        }
        else
        {
            for (int i=0; i<mores.count; i++)
            {
                [_items addObject:mores[i]];
            }
            _sn = [[_items lastObject] objectForKey:@"sn"];
            [_tableView reloadData];
            [_tableView.footer endRefreshing];
        }
    } failure:^(NSError *errors) {
        [_tableView.footer endRefreshing];
    }];
    
}
#pragma mark UITableView 代理方法实现

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [_items count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    UIFont* theFont = [UIFont boldSystemFontOfSize:11];
    CGSize size = [[_items[row] objectForKey:@"desc"] sizeWithFont:theFont
                                                 constrainedToSize:CGSizeMake(kWindowWidth-20, MAXFLOAT)
                                                     lineBreakMode:NSLineBreakByWordWrapping];
    return size.height+51;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cashCell = @"SNZiJinAllCell";
    NSInteger row = indexPath.row;
    SNZiJinAllCell * cell = [tableView dequeueReusableCellWithIdentifier:cashCell];
    
    if (cell == nil) {
        cell = [[SNZiJinAllCell alloc] initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier: cashCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.item = _items[row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
