//
//  CheckCodeInfoView.m
//  Lottery
//
//  Created by chenhaojie on 15/7/17.
//  Copyright © 2015年 UUZZ. All rights reserved.
//
#import "ICCLabel.h"
#import "CheckCodeInfoView.h"
@interface CheckCodeInfoView ()
{
    
    ICLabel* pCodeValueLabel;//电子票号内容
    ICLabel* checkCodeValueLabel;//防伪码值

}
@end

@implementation CheckCodeInfoView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabelBGColor = colorWithHexString(@"#EEEEEE");
        self.titleLabeTextlColor = colorWithHexString(@"#333333");
        self.titleLabelFont = kFontSizeExplanation_12;
        self.textLabelFont = kFontSizeExplanation_12;
    }

    return self;

}

/**
 *  功能:创建
 *
 *  参数: pcode    电子票号
 *  参数: checkCode 防伪码
 *  参数: startX   验票视图的其实坐标
 */
-(void)createCheckCodeViewWithPcode:(NSString *)pcode
                          checkCode:(NSString *)checkCode
                             startX:(CGFloat)startX
{

    self.userInteractionEnabled = YES;
    
    //-----标题---- 彩票防伪信息
    CGFloat superViewWidth = CGRectGetWidth(self.frame);
    UIView* titleView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, superViewWidth, 24)];
    [titleView setBackgroundColor:self.titleLabelBGColor];
    [self addSubview:titleView];
   
    
    UIView* textLabelbg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame), CGRectGetHeight(titleView.frame))];
    [textLabelbg setBackgroundColor:self.titleLabelBGColor];
    [titleView addSubview:textLabelbg];
    
    
    NSString* titleName = @"彩票防伪信息";
    ICLabel* titleLabel =[[ICLabel alloc]initWithFrame:CGRectMake(0, 0, superViewWidth, CGRectGetHeight(textLabelbg.frame))];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:self.titleLabeTextlColor];
    [titleLabel setText:titleName];
    [titleLabel setTextAlignment:1];
    [titleLabel setFont:self.textLabelFont];
    [textLabelbg addSubview:titleLabel];
   
    
    CGFloat startY = CGRectGetMaxY(titleLabel.frame);
    //----电子票号和防伪码区域------
    
    UIView* codeView = [[UIView alloc]initWithFrame:CGRectMake(0, startY, superViewWidth, 0)];
    codeView.userInteractionEnabled = YES;
    [self addSubview:codeView];
    
    
    //---电子票号 label-----
    
    NSString* pCodeName = @"电子票号:";
    CGSize pCodeNameSize = getStringSize(pCodeName, 300, CGFLOAT_MAX, self.textLabelFont);
    ICLabel* pCodeNameLabel = [[ICLabel alloc]initWithFrame:CGRectMake(10, 10, pCodeNameSize.width, pCodeNameSize.height)];
    [pCodeNameLabel setFont:self.textLabelFont];
    [pCodeNameLabel setText:pCodeName];
    [pCodeNameLabel setTextColor:colorWithHexString(@"#333333")];
    [codeView addSubview:pCodeNameLabel];
    
    
    //---电子票号内容-----
    CGFloat pCodeValueWidth = startX - CGRectGetMaxX(pCodeNameLabel.frame)-5;
//    pcode = @"123456789012345678901234567890123";
    CGSize pCodeValueSize = getStringSize(pcode, pCodeValueWidth, CGFLOAT_MAX, self.textLabelFont);
    
    CGFloat valueStartX = CGRectGetMaxX(pCodeNameLabel.frame)+5;
    pCodeValueLabel = [[ICLabel alloc]initWithFrame:CGRectMake(valueStartX, 10, pCodeValueSize.width, pCodeValueSize.height)];
    pCodeValueLabel.numberOfLines = 0;
    [pCodeValueLabel setFont:self.textLabelFont];
    [pCodeValueLabel setText:pcode];
    [pCodeValueLabel setTextColor:colorWithHexString(@"#333333")];
    [codeView addSubview:pCodeValueLabel];
   

    
    //---防伪码 label-----
    
    
    CGFloat checkCodeNameStartY = CGRectGetMaxY(pCodeValueLabel.frame)+5;
     NSString* checkCodeName = @"防伪码:";
    
    //- (id)initWithFrame:(CGRect)frame font:(UIFont *)afont  text:(NSString *)atext
    
     ICCLabel* checkCodeNameLabel = [[ICCLabel alloc]initWithFrame:CGRectMake(10, checkCodeNameStartY, pCodeNameSize.width, pCodeNameSize.height) font:self.textLabelFont text:checkCodeName textCount:pCodeName textColor:nil];
    
    [codeView addSubview:checkCodeNameLabel];
    
    //---防伪码内容
    
    CGSize  checkCodeValueSize = getStringSize(checkCode, pCodeValueWidth, CGFLOAT_MAX, self.textLabelFont);
    
     checkCodeValueLabel = [[ICLabel alloc]initWithFrame:CGRectMake(valueStartX, checkCodeNameStartY, checkCodeValueSize.width, pCodeNameSize.height)];
    checkCodeValueLabel.numberOfLines = 0;
    [checkCodeValueLabel setFont:self.textLabelFont];
    [checkCodeValueLabel setText:checkCode];
    [checkCodeValueLabel setTextColor:colorWithHexString(@"#333333")];
    [codeView addSubview:checkCodeValueLabel];

    //---验票按钮----（验票按钮和电子票号居中对齐）
    
    CGFloat buttonwidth= 35;
    CGFloat buutonStartX = superViewWidth -  buttonwidth -10;
    CGFloat buttonStartY = CGRectGetMidY(pCodeValueLabel.frame) -18/2; //验票button和电子票号y坐标居中

    ICButton* checkButton = [ICButton buttonWithType:UIButtonTypeCustom];
    [checkButton setFrame:CGRectMake(buutonStartX, buttonStartY, buttonwidth, 18)];
    [checkButton.layer setBorderWidth:1.0];
    [checkButton.layer setCornerRadius:2.0];
    [checkButton setClipsToBounds:YES];
    [checkButton.layer setBorderColor:colorWithHexString(@"#2288d4").CGColor];
    
    
    [checkButton setTitle:@"验票" forState:UIControlStateNormal];
    [checkButton setTitleColor:colorWithHexString(@"#2288d4") forState:UIControlStateNormal];
    checkButton.titleLabel.font = kFontSizeExplanation_10;
    [checkButton addTarget:self
                action:@selector(checkCodeAction:)
      forControlEvents:UIControlEventTouchUpInside];
    [codeView addSubview:checkButton];
    
    [codeView setViewHeight:CGRectGetMaxY(checkCodeValueLabel.frame)+10];
    
     [self setViewHeight:CGRectGetMaxY(codeView.frame)];
    

}


-(void)checkCodeAction:(ICButton*)button
{

    if (self.checkCodeBlock) {
        self.checkCodeBlock();
    }

}


@end
