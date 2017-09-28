//
//  ICCLabel.m
//  Lottery
//
//  Created by chenhaojie on 13-8-16.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//

#import "ICCLabel.h"

@implementation ICCLabel

@synthesize text;
@synthesize font;

- (id)initWithFrame:(CGRect)frame font:(UIFont *)afont  text:(NSString *)atext
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.text = atext;
        self.textColor = [UIColor blackColor];
        if (afont) {
            
            self.font = afont;
        }else{
        
            self.font = kFontSizeExplanation_15;
            
            
        }
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, self.font.pointSize *4, self.font.pointSize +1);
        [self setNeedsDisplay];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



- (id)initWithFrame:(CGRect)frame font:(UIFont *)afont  text:(NSString *)atext textCount:(NSString *)tmpBaseText textColor:(UIColor*)tmpTextColor
{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.text = atext;
        self.baseText = tmpBaseText;
        
        if (tmpTextColor) {
            self.textColor =tmpTextColor;
        }else{
            self.textColor = [UIColor blackColor];
        
        }
        if (afont) {
            
            self.font = afont;
        }else{
            
            self.font = kFontSizeExplanation_15;
            
        }
        //self.frame = CGRectMake(frame.origin.x, frame.origin.y, self.font.pointSize *count, self.font.pointSize +1);
        [self setNeedsDisplay];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//使用nsstring的绘制文本功能
- (void) drawText:(NSString *)atext x:(float)x y:(float)y {
    
    
    [atext drawAtPoint:CGPointMake(x, y) withFont:self.font];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.textColor.CGColor);
    
    //----最后一个数字的位置需要居左，（有“：”号的需要和最后一个汉字一块放在最左边）-----
    NSRange range = [self.text rangeOfString:@":"];
    CGFloat width = CGRectGetWidth(self.frame);
    
     NSUInteger count = [self.text length];//计算要画的汉子的长度
    CGFloat pointSizeHeight = self.font.pointSize;
    float space = (width -pointSizeHeight * count) /(count -1); //计算每个汉字之间的间隔
    
    if (range.location !=NSNotFound) {
        
        NSString* tmpStr = [self.baseText substringToIndex:self.baseText.length-1];
        
        width = getStringSize(tmpStr, width, 20, self.font).width;
        
        space = (width -pointSizeHeight * (count-1)) /(count -1-1);
    }

    
    //----

    CGFloat startY = (CGRectGetHeight(self.frame)- pointSizeHeight)/2-1;

    for (int i =0 ; i < count; i++) {
        
        NSString * title = [self.text substringWithRange:NSMakeRange(i, 1)];
        
        if ([title isEqualToString:@":"] && i ==count-1) {
            
            CGFloat  tmpWidth = getStringSize(title, width, 20, self.font).width;
            [self drawText:title x:CGRectGetWidth(self.frame)-tmpWidth y:startY];
            
        }else{
       
            [self drawText:title x:(pointSizeHeight+space)*i y:startY];
        
        }
        
        
    }
}

-(NSString *)text{


    return text;
}

-(void)setText:(NSString *)atext{
    
    if (![text isEqualToString:atext]) {
        
    
        text = [atext copy];
        [self setNeedsDisplay];
    }
    
}

@end
