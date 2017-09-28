//
//  AppDelegate.m
//  suning
//
//  Created by Bai on 2017/9/18.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "AppDelegate.h"
#import "KeychainItemWrapper.h"
#import "NSString+Encrypt.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    if([self.window.rootViewController isKindOfClass:[UITabBarController class]]){
        
        self.tabBarController = (UITabBarController*) self.window.rootViewController;
        UITabBar *tabBar = [self.tabBarController tabBar];
        
        tabBar.backgroundColor = [UIColor whiteColor];
        //设定Tabbar的点击后的颜色
        [[UITabBar appearance] setTintColor:[UIColor colorWithHexString:@"#E6313A"]];
        //设定Tabbar的颜色
        [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];//7.0
        //去掉黑线
        UIImage *maskline = [UIImage imageWithColor:[UIColor whiteColor]];
        [tabBar setBackgroundImage:maskline];
        [tabBar setShadowImage:maskline];
        
        
        
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, 1)];
        line.backgroundColor = kSingleLineColor;
        [tabBar addSubview:line];
        
        
        UIEdgeInsets insets = UIEdgeInsetsMake(-2, 0, 2, 0);
        for(UITabBarItem *item in [tabBar items]){
            item.imageInsets = insets;
        }
        NSLog(@"---------------%@",[tabBar items]);
        
    }
    
    
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"imeiTungKong" accessGroup:nil];
    self.uuid = [wrapper objectForKey:(id)kSecAttrAccount];
    if([self.uuid isEqualToString:@""] || self.uuid == nil){
        
        NSString *imei = [[NSUUID UUID] UUIDString];
        
        [wrapper setObject:imei forKey:(id)kSecAttrAccount];
        self.uuid = [wrapper objectForKey:(id)kSecAttrAccount];
    } else {
        self.uuid = [wrapper objectForKey:(id)kSecAttrAccount];
    }
    
    SETUDValue(self.uuid, @"deviceId");
    [[NSUserDefaults  standardUserDefaults] synchronize];
    self.versionStr = client_version;
    [self clientInit];
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isAutoLogin"]){
        [self autoLogin];
    }
    [self registerRemoteNotification];
    return YES;
}
/** 注册远程通知 */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8的需要手动开启“TARGETS -> Capabilities -> Push Notifications”
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据APP支持的iOS系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的iOS系统都能获取到DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
    
    
}
#pragma 客户端初始化
-(void)clientInit{
    //客户端安装初始化
    NSDictionary *reqbody = @{@"productId": Client_Num,
                              @"productVersion":client_version,
                              @"channelId":Channel_Num
                              };
    
    [[SNNetwork shard] reqWithCommand:@"SYS1002" body:reqbody mode:@"3" success:^(id res) {
        //安装状态
        [[NSUserDefaults  standardUserDefaults] setBool:YES forKey:@"Install"];
        [[NSUserDefaults  standardUserDefaults] synchronize];
        NSArray *advAry = [res objectForKey:@"adv"];
        NSDictionary *upDic = [res objectForKey:@"update"];
        SETUDValue(advAry, @"adv");
        SETUDValue(upDic, @"update");
        [[NSUserDefaults  standardUserDefaults] synchronize];
 
    } failure:^(NSError *errors) {
        NSLog(@"------------APP安装失败-------------");
        
    }];
}


-(void)autoLogin{
    NSString *sid = UDValue(@"sid");
    NSString *skey = UDValue(@"skey");
    
    NSDictionary *reqbody = @{@"sid": sid,
                              @"skey":skey
                              };
    
    [[SNNetwork shard] reqWithCommand:@"USR1012" body:reqbody mode:@"3" success:^(id res) {
        //安装状态
        [[NSUserDefaults  standardUserDefaults] setBool:YES forKey:@"isLogin"];
        [[NSUserDefaults  standardUserDefaults] synchronize];
        [[SNUser shard] setBody:res];
        NSLog(@"res:%@",res);
        
    } failure:^(NSError *errors) {
        [[NSUserDefaults  standardUserDefaults] setBool:NO forKey:@"isLogin"];
        [[NSUserDefaults  standardUserDefaults] synchronize];
        NSLog(@"------------session登录失败-------------");
        
    }];
}
/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    self.pushToken = token;
    
    //    [self sendServerToken];
    // [ GTSdk ]：向个推服务器注册deviceToken
//    [GeTuiSdk registerDeviceToken:token];
}

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
}
#pragma mark---服务器发送请求发送device_token----

-(void)sendServerToken {
    
    //上传token的网络请求
    if (self.pushToken == nil) {
        
        return;
    }
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"imeiTungKong" accessGroup:nil];
    
    NSString *deviceid = [wrapper objectForKey:(id)kSecAttrAccount];
    NSDictionary *reqbody = @{@"deviceId": deviceid,
                              @"productId":Client_Num,
                              @"productVersion":client_version,
                              @"channelId":Channel_Num,
                              @"pushChannel":@"GeTui",
                              @"pushToken":self.pushToken
                              };
    
    [[SNNetwork shard] reqWithCommand:@"PSH1000" body:reqbody mode:@"1" success:^(id body) {
        NSLog(@"上传token成功回调---%@",body);
    } failure:^(NSError *errors) {
        NSLog(@"------------上传token失败-------------");
    }];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
