//
//  lCButton.h
//  Lottery
//
//  Created by hao chentao on 13-5-15.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

//阴影类型
typedef enum{
	ICButtontop = 0,
	ICButtondown,
} ShadowType;


@interface ICButton : UIButton
@property (nonatomic) NSInteger m_touchDown;            //记录按钮点击的次数
@property (nonatomic) BOOL     selectBool;              //当前按钮是否选中

- (void)setTitle:(NSString *)title forState:(UIControlState)state Shadow:(ShadowType) type Font:(NSInteger)fontnumber Bold:(BOOL) bold Color:(UIColor *)color;
@end
