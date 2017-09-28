//
//  UZRichLabel.h
//  Lottery
//
//  Created by chenhaojie on 14/12/2.
//  Copyright (c) 2014年 UUZZ. All rights reserved.
//
//  =====================================================
//  视图:自定义富文本label
//  功能:创建自定义显示富文本label:
//  =====================================================


//以下是使用说明：使用时可以打开注释。。。
/*
 
 
 
 //创建html文本
 NSString * htmlText1= @"<font color=#944200>1000</font>倍×<font color=#944200>9</font>注×<font color=#944200>2</font>元 总计<font color=#944200>22345342524352345234534253425345345345</font>元";
 //创建富文本label
 
 ICRichLabel  * uzlabel = [[ICRichLabel alloc]initWithFrame:CGRectMake(10.0, 40.0, kWindowWidth-20, 30) HtmlText:htmlText];//创建
 //设置富文本的对齐方式，默认居中
 
 [uzlabel setRichTextAligment:ICTextAlignmentLeft];
 //设置字体。非必须字段，默认是13号字体
 [uzlabel setTextFont:[UIFont systemFontOfSize:15.0]];
 //设置文本的颜色,非必须默认是black
 [uzlabel setRichTextColor:[UIColor redColor]];
 [uzlabel setBackgroundColor:[UIColor grayColor]];
 [self.view addSubview:uzlabel];
 
 
 
 
 NSString * htmlText1= @"<font color=#944200>1000</font>倍×<font color=#944200>9</font>注×<font color=#944200>2</font>元 总计<font color=#944200>22345342524352345234534253425345345345</font>元";
 
 NSString * htmlText2 = @"<font color=#944200>19</font>倍×<font color=#944200>89</font>注×<font color=#944200>2235423423</font>元 总计<font color=#944200>2008</font>元";
 NSString * htmlText3 = @"";
 
 [htmlstrs addObject:htmlText];
 [htmlstrs addObject:htmlText1];
 [htmlstrs addObject:htmlText2];
 [htmlstrs addObject:htmlText3];
 [htmlstrs addObject:htmlText3];
 
 [uzlabel setText:htmlText2]//重新设置富文本内容
 
 */



#import <CoreText/CoreText.h>

//  富文本显示位置
typedef enum
{
    ICTextAlignmentLeft,
    ICTextAlignmentRight,
    ICTextAlignmentCenter
} ICTextAlignment;


@interface ICRichLabel : UILabel
@property(nonatomic,retain)UIFont *textFont;//富文本显示的字体
@property(nonatomic,retain)UIFont *richTextFont;//富文本显示的字体
@property(nonatomic,retain)UIColor *richTextColor;//富文本颜色
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)BOOL             isMarquee;


/**
 *  功能:初始化富文本显示lebal
 *
 *  参数: frame   label的frame
 *  参数: HtmlText 富文本->htmltext
 *
 *  返回值:label自身
 */
-(id)initWithFrame:(CGRect)frame HtmlText:(NSString *)richText;
/**
 *  功能:设置文本对齐方式
 *
 *  参数: arichTextAligment 对齐方式枚举
 */
- (void)setRichTextAligment:(ICTextAlignment)arichTextAligment;

/**
 *  功能:解析原始文字
 *
 *  参数: ahtmlTexthtml文字
 */
-(void)parseHTMLText:(NSString * )ahtmlText;

@end
