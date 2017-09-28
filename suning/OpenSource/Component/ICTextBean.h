//
//  UZTextBean.h
//  test
//
//  Created by chenhaojie on 14/12/3.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICTextBean : NSObject
@property(nonatomic,retain)UIColor *textColor;//颜色
@property(nonatomic,retain)UIFont *textFont;//字体
@property(nonatomic,assign)NSRange range;//显示范围
@property(nonatomic,copy)NSString *textString;//文字
@end
