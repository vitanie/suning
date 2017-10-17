//
//  LoginViewController.h
//  suning
//
//  Created by Bai on 2017/9/26.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)confirm:(id)sender;

@end
