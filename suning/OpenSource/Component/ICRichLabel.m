//
//  UZRichLabel.m
//  Lottery
//
//  Created by chenhaojie on 14/12/2.
//  Copyright (c) 2014年 UUZZ. All rights reserved.
//

#import "ICRichLabel.h"
#import "ICTextBean.h"

@interface ICRichLabel ()
{
    BOOL isSetTextChange;

}
@property(nonatomic,retain)NSMutableString    *richText; //htmlText
@property(nonatomic,copy)NSString           *htmlText ; //htmlText
@property(nonatomic,retain)NSMutableArray   *textBeans ; //富文本显示数组
@property(nonatomic,assign)float             startX;
@property(nonatomic,assign)ICTextAlignment richTextAligment;


@end

@implementation ICRichLabel

@synthesize textFont;
@synthesize textBeans;
@synthesize htmlText;
@synthesize richText;
@synthesize startX;
@synthesize richTextAligment;
@synthesize richTextColor;



/**
 *  功能:重写设置文本方法
 */
-(void)setText:(NSString *)text{
    [self initData];
    self.htmlText = text;
    isSetTextChange = YES;
    [self parseHTMLText:self.htmlText];
    
    
    
    
    
    
    
    [self setNeedsDisplay];
}


/**
 *  功能:设置数据
 */
-(void)initData{
    
    NSMutableString * tmprichText =[[NSMutableString alloc]initWithString:@""];
    self.richText =tmprichText;
    self.htmlText = @"";
    if (textBeans.count) {
        [textBeans removeAllObjects];
    }
    textBeans = [[NSMutableArray alloc]init];
    
}

/**
 *  功能:设置文本对齐方式
 *
 *  参数: arichTextAligment 对齐方式枚举
 */
- (void)setRichTextAligment:(ICTextAlignment)arichTextAligment{
    
    richTextAligment  = arichTextAligment;
    
    
}


-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor = [UIColor clearColor];
        self.richTextColor = [UIColor blackColor];
        self.textFont = [UIFont systemFontOfSize:13.0];//设置默认的属性
    }
    return self;
}
/**
 *  功能:初始化富文本显示lebal
 *
 *  参数: frame   label的frame
 *  参数: HtmlText 富文本->htmltext
 *
 *  返回值:label自身
 */
-(id)initWithFrame:(CGRect)frame HtmlText:(NSString *)ahtmlText{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.htmlText = ahtmlText;
        NSMutableString * tmprichText =[[NSMutableString alloc]initWithString:@""];
        self.richText =tmprichText;
        self.richTextColor = [UIColor blackColor];
        self.textFont = [UIFont systemFontOfSize:13.0];//设置默认的属性
        NSMutableArray  * tmptextBeans =[[NSMutableArray alloc]init];
        
        self.textBeans = tmptextBeans;
        [self setText:ahtmlText];
    }
    
    return self;
    
    
}


/**
 *  功能:重写父类的绘制文本方法
 *
 *  参数: rect绘制文本区域
 */
-(void)drawTextInRect:(CGRect)rect{
    
//    if (!isSetTextChange) {
//        return;
//    }
//    isSetTextChange = NO;

    
    //解析html文本
   
    
    
    //********************自动缩放功能，计算文字大小*********************
    CGSize richTextSize = getStringSize(self.richText, MAXFLOAT, MAXFLOAT, self.textFont);
    CGFloat point =self.textFont.pointSize;
    
    float front = CGRectGetWidth(self.frame);
    float back  = richTextSize.width;
    
    float newPoint =point;
    if ((front/back)<1) {
        
        newPoint =point *(front/back);
    }
    //***************设置最终显示的文本的字体大小******************
    
    
    self.textFont = [UIFont systemFontOfSize:newPoint];

    //********************设置文本的设置文本的显示位置********************
    switch (self.richTextAligment) {
        case ICTextAlignmentRight:
            
            self.startX = CGRectGetWidth(self.frame)-richTextSize.width;
            
            break;
            
        case ICTextAlignmentLeft:
            
            self.startX = 0;
            break;
            
            
        case ICTextAlignmentCenter:
            self.startX = (CGRectGetWidth(self.frame)-richTextSize.width)/2;
            break;
            
            
        default:
            break;
    }
    
    //***************************开始绘制富文本**********************
   
    //创建 NSMutableAttributedString 实例对象
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.richText];
    CTFontRef  ctfont = CTFontCreateWithName((CFStringRef)self.textFont.fontName,self.textFont.pointSize,NULL);
    [attributedText addAttribute: (NSString*)(kCTFontAttributeName) value:(__bridge id)ctfont range:NSMakeRange(0,self.richText.length)];
    CFRelease(ctfont);
    
    for (ICTextBean *textBean in textBeans) {
        
        [attributedText addAttribute:(NSString*)(kCTForegroundColorAttributeName) value:(id)[textBean.textColor CGColor] range:textBean.range];
       
        if (self.isMarquee) {
             CTFontRef  ctfont1 = CTFontCreateWithName((CFStringRef)textBean.textFont.fontName,textBean.textFont.pointSize,NULL);
            [attributedText addAttribute: (NSString*)(kCTFontAttributeName) value:(__bridge id)ctfont1 range:textBean.range];
        }
        
    }
    
    //调整试图坐标系
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context,CGAffineTransformIdentity);//重置
    
    CGContextTranslateCTM(context,0,self.bounds.size.height); //y轴高度
    
    CGContextScaleCTM(context,1.0,-1.0);//y轴翻转
    
    //绘制文本
    
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attributedText);
    if (self.isMarquee) {
        
        CGFloat startY = 3+(CGRectGetHeight(self.frame) - self.richTextFont.pointSize)/2;
        
        CGContextSetTextPosition(context,self.startX,startY);
    }else{
        
        CGContextSetTextPosition(context,self.startX,(CGRectGetHeight(self.frame) - self.textFont.pointSize)/2);
    }
    
    
    CTLineDraw(line,context);
    
    CFRelease(line);
    
}



-(void)parseHTMLText:(NSString * )ahtmlText{
    
    
    
    if ([textBeans count]>0) {
        
        [textBeans removeAllObjects];
    }
    self.richText = [[NSMutableString alloc]init];
    
    
    //-----设置索引，textBeans使用------------
    int  index = 0;
    NSArray * array   = [[NSArray alloc]initWithArray:[ahtmlText componentsSeparatedByString:@"</font>"]];
    for (NSString *str in array) {
        
        // NSLog(@"%@",str);
        
        NSArray * array1   = [[NSArray alloc]initWithArray:[str componentsSeparatedByString:@"<font"]];
        
        for (NSString * str2 in array1) {
            
            if(str2.length <1) {
                continue;
            }
            //数组里面的元素有以color=开头的 是要设置富文本的需要取出数据
            NSRange range =[str2 rangeOfString:@"color="];
            
            //开始处理富文本
            ICTextBean * textBean = [ICTextBean alloc];
            textBean.textFont = self.textFont;
            if (range.location ==NSNotFound) {
                
                textBean.textString=str2;
                textBean.textColor = richTextColor;
            }else{
                
                NSArray * array   = [[NSArray alloc]initWithArray:[str2 componentsSeparatedByString:@">"]];
                
                //如果找到color开头的说明是富文本
                
                NSString * colorStr   = [array objectAtIndex:0];//富文本的修饰文字样式字符串（目前只包含颜色）
                NSString * textString = [array objectAtIndex:1];//富文本的文字字符串
                textBean.textString =textString;//
                
                //解析16进制颜色字符串并转换成UIColor
                NSString *hexColorStr = @"";
                if (!self.isMarquee) {
                
                hexColorStr = [colorStr substringFromIndex:@"color=\"#".length];
                
                }else{
                
                  hexColorStr = [colorStr substringFromIndex:@"color=\"#".length];
                    
                    hexColorStr = [hexColorStr substringToIndex:hexColorStr.length-1];
                    
                }
               
                UIColor  *textColor = colorWithHexString(hexColorStr);
                textBean.textColor =textColor;
                textBean.textFont = self.richTextFont;
            }
            //设置富文本字符串的range
            if ([textBeans count]==0) {
                
                textBean.range = NSMakeRange(0, textBean.textString.length);
            }else{
                
                ICTextBean * tmpTextBean = [textBeans objectAtIndex:index];
                index++;
                textBean.range =  NSMakeRange(tmpTextBean.range.location+tmpTextBean.range.length, textBean.textString.length);
                
            }
            if (textBean.textString.length > 0) {
                
//               if ([self.richText rangeOfString:textBean.textString].location ==NSNotFound) {
                
                    [self.richText appendString:textBean.textString];
                    [self.textBeans addObject:textBean];
                //}
                
            }
            
        }
    }
    
}
@end
