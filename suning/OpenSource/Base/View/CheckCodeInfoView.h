//
//  CheckCodeInfoView.h
//  Lottery
//
//  Created by chenhaojie on 15/7/17.
//  Copyright © 2015年 UUZZ. All rights reserved.
//

#import "ICView.h"

@interface CheckCodeInfoView : UIView
@property(nonatomic,retain)UIFont* titleLabelFont;
@property(nonatomic,retain)UIColor* titleLabeTextlColor;
@property(nonatomic,retain)UIColor* titleLabelBGColor;
@property(nonatomic,retain)UIFont* textLabelFont;
@property(nonatomic,copy)void (^checkCodeBlock)();//验票按钮回调




/**
 *  功能:打马赛克
 */
-(void)createMask;

/**
 *  功能:删除马赛克
 */
-(void)removeMask;
/**
 *  功能:创建
 *
 *  参数: pcode    电子票号
 *  参数: checkCode 防伪码
 *  参数: startX   验票视图的其实坐标
 */
-(void)createCheckCodeViewWithPcode:(NSString *)pcode
                          checkCode:(NSString *)checkCode
                             startX:(CGFloat)startX;
@end
