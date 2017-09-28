//
//  BaseVC.m
//  Happy
//
//  Created by chenhaojie on 15/7/29.
//  Copyright © 2015年 tsunami. All rights reserved.
//

#import "BaseVC.h"

#define BLOCK(bself) __block typeof(self) bself = self
@interface BaseVC ()

@end

@implementation BaseVC
@synthesize navigationView;



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:cEEEEEE];
    
    
    //---创建导航栏-------
    [self createNavigationView];
    // Do any additional setup after loading the view.
}

-(void)createNavigationView
{
    
    UIView* statusBgView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, kWindowWidth, 20)];
    [statusBgView setBackgroundColor:c2D88D4];
    

    
    BLOCK(bself);
    BaseNavgationView*  tmpNavigationView = [[BaseNavgationView alloc]init];
    tmpNavigationView.leftButtonBlock = ^(){
    
        [self leftButtonAction];
    
    };
    
    
    tmpNavigationView.rightButtonBlock = ^(){
    
        [bself rightButtonAction];
    
    };
    [tmpNavigationView createMainViewWithFrame:CGRectMake(0, 20, kWindowWidth, 44)];
    navigationView = tmpNavigationView;
    [navigationView addSubview:statusBgView];
    [self.view addSubview:tmpNavigationView];
}



/**
 *  功能:左侧导航栏按钮点击响应回调
 *
 */
-(void)leftButtonAction{


}


/**
 *  功能:右侧导航栏按钮点击响应回调
 *
 */
-(void)rightButtonAction{



}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  功能:显示提示框
 */
- (void)showAllTextDialogWithText:(NSString *)text{
    
//   MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.labelText = text;
//    HUD.mode = MBProgressHUDModeText;
//    
//    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
//    //    HUD.yOffset = 150.0f;
//    //    HUD.xOffset = 100.0f;
//    
//    [HUD showAnimated:YES whileExecutingBlock:^{
//        
//        sleep(1);
//    } completionBlock:^{
//        
//        [HUD removeFromSuperview];
//    }];
}


/**
 *  功能:显示提示框
 */
- (void)showAllNetWorkWait{

//    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.labelText = kNavigationTitle84;
//    HUD.mode = MBProgressHUDModeAnnularDeterminate;
//    
//    [HUD showAnimated:YES whileExecutingBlock:^{
//        
//        float progress = 0.0f;
//        while (progress < 1.0f) {
//            progress += 0.01f;
//            HUD.progress = progress;
//            usleep(50000);
//        }
//    }completionBlock:^{
//        
//        [HUD removeFromSuperview];
//    }];
    
}
@end
