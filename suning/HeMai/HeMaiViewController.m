//
//  HeMaiViewController.m
//  suning
//
//  Created by Bai on 2017/9/25.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "HeMaiViewController.h"

@interface HeMaiViewController ()
@property(nonatomic,strong)SNNavigation* navigationView;
@end

@implementation HeMaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _navigationView = [[SNNavigation alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kNavigationHeight) title:@"合买" isBack:NO isHelp:NO];
    [self.view addSubview:_navigationView];
    
    // Do any additional setup after loading the view.
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
