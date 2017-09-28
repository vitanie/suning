//
//  AppDelegate.h
//  suning
//
//  Created by Bai on 2017/9/18.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain,nonatomic) NSString *uuid;
@property (retain,nonatomic) NSString *versionStr;
@property (nonatomic,strong) NSString *pushToken;       //推送token
@property (nonatomic,strong) UITabBarController *tabBarController;
@end

