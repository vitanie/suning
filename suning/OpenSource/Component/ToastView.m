//
//  UIView+UIView_Toast.m
//  Lottery
//
//  Created by chenhaojie on 15/7/16.
//  Copyright © 2015年 UUZZ. All rights reserved.
//

#import "ToastView.h"
@implementation ToastView


-(id)init{

    self = [super init];
    if (self) {
        self.textFont = kFontSizeExplanation_12;
    }

    return self;
}

/**
 *  功能:显示带文字的toast
 *
 *  参数: string文本内容
 *  参数: width 显示宽度
 *  参数: parentView 父视图
 */
-(void)showToastWithStr:(NSString*)string  toastViewWidth:(CGFloat)width parentView:(UIView*)parentView
{

    CGSize checkCodeSzie = getStringSize(string, width, CGFLOAT_MAX, self.textFont);
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, parentView.frame.size.width,parentView.frame.size.height)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    UIView* labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, checkCodeSzie.width+20,checkCodeSzie.height+20)];
    labelView.center = CGPointMake(kWindowWidth/2, kWindowHeight/2);
    [labelView setBackgroundColor:[UIColor blackColor]];
    labelView.alpha = 0.9;
    [labelView.layer setCornerRadius:3];
    [labelView setClipsToBounds:YES];
    [view addSubview:labelView];
    
    
    UILabel*checkCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, checkCodeSzie.width, checkCodeSzie.height)];
    [checkCodeLabel setBackgroundColor:[UIColor clearColor]];
    [checkCodeLabel setText:string];
    checkCodeLabel.numberOfLines =0;
    [checkCodeLabel setTextAlignment:1];
    [checkCodeLabel setTextColor:[UIColor whiteColor]];
    [checkCodeLabel setFont:self.textFont];
    [labelView addSubview:checkCodeLabel];
   
    view.alpha = 0;
    [parentView addSubview:view];
    
    [UIView animateWithDuration:0.6 animations:^{
        
        view.alpha = 1;
        
    } completion:^(BOOL flag){
        
        
        [self performSelector:@selector(removeToast:) withObject:view afterDelay:1.5];
        
    }];

}









/**
 *  功能:防伪码显示弹框
 *
 *  参数: checkCode 防伪码
 *  参数: startY 防伪码弹框起始y坐标
 *  参数: centerX  箭头中心点显示位置（相对坐标，需要转换）
 *  参数: parentView 父视图
 *  参数: maxwidth 最大宽度
 */
-(void)showPopView:(NSString*)checkCode   startY:(CGFloat)startY centerX:(CGFloat)centerX parentView:(UIView*)parentView toastViewMaxWidth:(CGFloat)maxwidth;
{
    
    
    CGSize checkCodeSzie = getStringSize(checkCode, maxwidth, CGFLOAT_MAX, kFontSizeExplanation_12);
    CGFloat startX = kWindowWidth -checkCodeSzie.width-10-5;
    
    UIImage* arrow = [UIImage imageNamed:@"bg_ma_arrow.png"];
    
    CGFloat arrowStartX = centerX - startX;
    
    
    UIView* popView = [[UIView alloc]initWithFrame:CGRectMake(startX, startY-(checkCodeSzie.height +arrow.size.height+10), checkCodeSzie.width+10, checkCodeSzie.height +arrow.size.height+10)];
    popView.tag = 0x660;
    [parentView addSubview:popView];
     [popView setBackgroundColor:[UIColor clearColor]];
                                                            
    UIView* labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, checkCodeSzie.width+10, checkCodeSzie.height +10)];
   
    
    
    [labelView setBackgroundColor:[UIColor whiteColor]];
    [labelView.layer setCornerRadius:3];
    [labelView setClipsToBounds:YES];
     [popView addSubview:labelView];
    
    UILabel*checkCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, checkCodeSzie.width, checkCodeSzie.height)];
    [checkCodeLabel setText:checkCode];
    checkCodeLabel.numberOfLines =0;
    [checkCodeLabel setTextAlignment:1];
    [checkCodeLabel setTextColor:[UIColor blackColor]];
    [checkCodeLabel setFont:kFontSizeExplanation_12];
    [labelView addSubview:checkCodeLabel];
    
    UIImageView* arrrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(arrowStartX -arrow.size.width/2 , CGRectGetMaxY(labelView.frame)-1, arrow.size.width, arrow.size.height)];
    [arrrowImageView setImage:arrow];
    [popView addSubview:arrrowImageView];
    
    popView.alpha = 0;
    [UIView animateWithDuration:1.0 animations:^{
        
        popView.alpha = 1;
        
    } completion:^(BOOL flag){
        
        
        [self performSelector:@selector(removeToast:) withObject:popView afterDelay:2.0];
        
    }];

}



/**
 *  功能:超出2万提示框
 *
 *  参数: string文本内容
 *  参数: width 显示宽度
 *  参数: parentView 父视图
 */
-(void)showToastViewWithStr:(NSString*)string  toastViewWidth:(CGFloat)width parentView:(UIView*)parentView
{
    
    CGSize checkCodeSzie = getStringSize(string, width, CGFLOAT_MAX, kFontSizeExplanation_15);
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, parentView.frame.size.width,parentView.frame.size.height)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    UIView* labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, checkCodeSzie.width+40,checkCodeSzie.height+40)];
    labelView.center = CGPointMake(kWindowWidth/2, kWindowHeight/2);
    [labelView setBackgroundColor:[UIColor blackColor]];
    labelView.alpha = 0.8;
    [labelView.layer setCornerRadius:4];
    [labelView setClipsToBounds:YES];
    [view addSubview:labelView];
    
    
    UILabel*checkCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, checkCodeSzie.width, checkCodeSzie.height)];
    [checkCodeLabel setBackgroundColor:[UIColor clearColor]];
    [checkCodeLabel setText:string];
    checkCodeLabel.numberOfLines =10;
    [checkCodeLabel setTextAlignment:1];
    [checkCodeLabel setTextColor:[UIColor whiteColor]];
    [checkCodeLabel setFont:kFontSizeExplanation_15];
    [labelView addSubview:checkCodeLabel];
    view.alpha = 0;
    [parentView addSubview:view];
    [UIView animateWithDuration:1.0 animations:^{
        
        view.alpha = 1;
        
    } completion:^(BOOL flag){
        
        
        [self performSelector:@selector(removeToast:) withObject:view afterDelay:0.5];
        
    }];
    
}

-(void)removeToast:(id)sender{
    
    UIView*view =   (UIView*)sender;
    
    [UIView animateWithDuration:1.0 animations:^{
        
        view.alpha = 0;
        
        
    } completion:^(BOOL flag){
        
        if (self.finishBlock) {
            
            self.finishBlock();
        }
        
        
        [view removeFromSuperview];
    
    }];
    
}

@end
