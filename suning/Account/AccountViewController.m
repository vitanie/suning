//
//  AccountViewController.m
//  suning
//
//  Created by Bai on 2017/9/22.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountTableViewCell.h"
@interface AccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)SNNavigation* navigationView;
@property(nonatomic,strong)NSMutableArray *items1;
@property(nonatomic,strong)NSMutableArray *items2;
@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _navigationView = [[SNNavigation alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kNavigationHeight) title:@"个人账户" isBack:NO isHelp:NO];
    [self.view addSubview:_navigationView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"AccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountTableViewCell"];
    [_upView setViewY:kNavigationHeight];
    [_tableView setViewY:CGRectGetMaxY(_upView.frame)+10];
    [_tuihuBtn setViewY:CGRectGetMaxY(_tableView.frame)+50];
    
    [_tuihuBtn.layer setMasksToBounds:YES];
    [_tuihuBtn.layer setCornerRadius:5.0];
    
    NSDictionary* item1 = @{@"title":@"提现",@"image":@"icon_ac_tx"};
    NSDictionary* item2 = @{@"title":@"充值",@"image":@"icon_ac_cz"};
    NSDictionary* item3 = @{@"title":@"奖金转投注金",@"image":@"icon_ac_jzt"};
    NSDictionary* item4 = @{@"title":@"账户明细",@"image":@"icon_ac_zhmx"};
    NSDictionary* item5 = @{@"title":@"购买明细",@"image":@"icon_ac_gmmx"};
    
    _items1 = [[NSMutableArray alloc] initWithObjects:item1,item2,item3, nil];
    _items2 = [[NSMutableArray alloc] initWithObjects:item4,item5, nil];
    
    [_tableView reloadData];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    if(!UDValue(@"isLogin"))
    {
        LoginViewController *log = [[LoginViewController alloc] init];
        [self presentViewController:log animated:YES completion:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 5;
    }
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 0){
        return 5;
    }
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if(section == 0)
    {
        return [_items1 count];
    }
    else
    {
        return [_items2 count];
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    static NSString * accountCell = @"AccountTableViewCell";
    
    AccountTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:accountCell];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.section == 0){
        
        NSDictionary *dic = [_items1 objectAtIndex:row];
        
        [cell1.title setText:[dic objectForKey:@"title"]];
        [cell1.img setImage:[UIImage imageNamed:[dic objectForKey:@"image"]]];
        
    } else {
        
        NSDictionary *dic = [_items2 objectAtIndex:row];
        
        [cell1.title setText:[dic objectForKey:@"title"]];
        [cell1.img setImage:[UIImage imageNamed:[dic objectForKey:@"image"]]];
        
    }
    
    return cell1;
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
