//
//  LoginViewController.m
//  suning
//
//  Created by Bai on 2017/9/26.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
{
    
    
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (IBAction)confirm:(id)sender {
    
    NSString *pwdStr = [MyMD5 md5:_password.text];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:_username.text,@"loginName",pwdStr,@"password", nil];
    [[SNNetwork shard] reqWithCommand:@"USR1003" body:dic mode:@"3" success:^(id res) {
        //加载数据源
        [[SNUser shard] setBody:res];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isAutoLogin"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
        SETUDValue([res objectForKey:@"sid"], @"sid");
        SETUDValue([res objectForKey:@"skey"], @"skey");
        NSLog(@"登录1003:%@",res);
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    } failure:^(NSError *errors) {
        
        NSLog(@"%@",errors);
    }];
    
}
@end
