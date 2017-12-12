//
//  ZiJinMingXiVC.m
//  suning
//
//  Created by 白云皓 on 2017/11/10.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "ZiJinMingXiVC.h"
#import "HMSegmentedControl.h"
#import "UZPagesView.h"
#import "SNZiJinAllVC.h"

@interface ZiJinMingXiVC ()<SNNavigationDelegate>
@property(nonatomic,strong)SNNavigation* navigationView;
@property(nonatomic,strong)SNZiJinAllVC* tvc1;
@property(nonatomic,strong)SNZiJinAllVC* tvc2;
@property(nonatomic,strong)SNZiJinAllVC* tvc3;
@property(nonatomic,strong)SNZiJinAllVC* tvc4;
@property(nonatomic,strong)SNZiJinAllVC* tvc5;
@property(nonatomic,strong)SNZiJinAllVC* tvc6;

@end

@implementation ZiJinMingXiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _navigationView = [[SNNavigation alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kNavigationHeight) title:@"资金明细" isBack:YES isHelp:NO];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
    
    
    
    _tvc1 = [[SNZiJinAllVC alloc] init];//全部
    _tvc1.type = @"";
    
    _tvc2 = [[SNZiJinAllVC alloc] init];//充值
    _tvc2.type = @"0";
    
    _tvc3 = [[SNZiJinAllVC alloc] init];//投注
    _tvc3.type = @"1";
    
    _tvc4 = [[SNZiJinAllVC alloc] init];//中奖
    _tvc4.type = @"2";
    
    _tvc5 = [[SNZiJinAllVC alloc] init];//提现
    _tvc5.type = @"4";
    
    _tvc6 = [[SNZiJinAllVC alloc] init];//红包
    _tvc6.type = @"5";
    
    //pageView
    UZPageModel *model1=[UZPageModel model:_tvc1 pageBarName:@"全部"];
    UZPageModel *model2=[UZPageModel model:_tvc2 pageBarName:@"充值"];
    UZPageModel *model3=[UZPageModel model:_tvc3 pageBarName:@"投注"];
    UZPageModel *model4=[UZPageModel model:_tvc4 pageBarName:@"中奖"];
    UZPageModel *model5=[UZPageModel model:_tvc5 pageBarName:@"提现"];
    UZPageModel *model6=[UZPageModel model:_tvc6 pageBarName:@"红包"];
    
    NSArray *pageModels=@[model1,model2,model3,model4,model5,model6];
    
    
    //自定义配置
    UZPagesViewConfig *config = [[UZPagesViewConfig alloc] init];
    config.isBarBtnUseCustomWidth = YES;
    config.barViewH = 30;
    config.barBtnMargin = 0;
    config.barBtnWidth = kWindowWidth/6;
    config.barLineViewPadding = 0;
    config.barScrollMargin = 0;
    
    UZPagesView* pagesView=[UZPagesView viewWithOwnerVC:self pageModels:pageModels config:config];
    pagesView.tag = 0x2921;
    pagesView.frame = CGRectMake(0, kNavigationHeight, kWindowWidth, kWindowHeight - kNavigationHeight);
    [self.view addSubview:pagesView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_page)
    {
        __weak typeof(UZPagesView *)base = (UZPagesView *)[self.view viewWithTag:0x2921];
        [base jumpToPage:_page];
    }
    
}
-(void)navigationBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
