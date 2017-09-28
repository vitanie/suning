//
//  BaseVC.h
//  Happy
//
//  Created by chenhaojie on 15/7/29.
//  Copyright © 2015年 tsunami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavgationView.h"
@interface BaseVC : UIViewController
@property(nonatomic,strong)BaseNavgationView* navigationView;//基类导航栏





/**
 *  功能:左侧导航栏按钮点击响应回调
 *
 */
-(void)leftButtonAction;


/**
 *  功能:右侧导航栏按钮点击响应回调
 *
 */
-(void)rightButtonAction;

/**
 *  功能:显示提示框
 */
- (void)showAllTextDialogWithText:(NSString *)text ;


/**
*  功能:显示提示框
*/
- (void)showAllNetWorkWait;
@end
