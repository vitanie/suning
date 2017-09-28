//
//  SNNavigation.h
//  suning
//
//  Created by Bai on 2017/9/21.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SNNavigationDelegate
@optional
//返回按钮点击
-(void)navigationBackClick;
//帮助按钮点击
-(void)navigationHelpClick;
- (void)navigationRigthClick;
@end
@interface SNNavigation : UIView<SNNavigationDelegate>
@property(nonatomic,strong)UILabel* title;
@property(nonatomic,strong)UIButton* rightBtn;
@property(nonatomic,weak)id<SNNavigationDelegate> delegate;
-(id)initWithFrame:(CGRect)frame title:(NSString*)title isBack:(BOOL)isBack isHelp:(BOOL)isHelp;

-(id)initWithFrame:(CGRect)frame title:(NSString*)title  rightBtnTitle:(NSString*)titles;


- (void)setRightBtnImg:(NSString *)rightBtnimgName;
@end
