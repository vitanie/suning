//
//  AccountViewController.h
//  suning
//
//  Created by Bai on 2017/9/22.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *cash;
@property (weak, nonatomic) IBOutlet UILabel *bonus;
@property (weak, nonatomic) IBOutlet UILabel *hongBao;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *tuihuBtn;
@property (weak, nonatomic) IBOutlet UIView *upView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
