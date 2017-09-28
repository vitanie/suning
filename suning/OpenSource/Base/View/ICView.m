//
//  UIView.m
//  Lottery
//
//  Created by hao chentao on 13-5-15.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//

#import "ICView.h"

@implementation ICView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
    }
    return self;
}



/**
 @功能: 创建公共的单元格
 @参数: frame 表格坐标系
 @参数: aflag 改变背景颜色
 @参数: parentView 父类视图
 @返回值: 斑马线单元格
 */
- (UIView *)createCellWidthFrame:(CGRect)frame flag:(BOOL)aflag parentView:(UIView *)parentView

{
    //绘制斑马线单元格
    UIView * subsView = [[UIView alloc] init];
    subsView.frame = frame;
    
    if (!aflag) {
        subsView.backgroundColor = colorWithHexString(@"#F6FCFF");
        
    }else{
        
        subsView.backgroundColor = [UIColor whiteColor];
        
    }
    
    //每个单元个的横线
    UIView *sline = [[UIView alloc] initWithFrame:CGRectMake(0.0, CGRectGetHeight(subsView.frame)-1, CGRectGetWidth(subsView.frame), 1)];
    //sline.backgroundColor = cellHeaderAndLineColor;
    [subsView addSubview:sline];
   
    [parentView addSubview:subsView];
    
    return subsView ;
    
    
}



/**
 @功能: 创建label
 @参数: viewParent 父类
 @参数: rect 坐标
 @参数: text 文本内容
 @参数: color 背景颜色
 @参数: font 显示字体
 @参数: alignment 显示位置
 @返回值: label
 */
-(ICLabel *)createLable:(UIView *)viewParent
                  Frame:(CGRect)rect
                   Text:(NSString *)text
                  Color:(UIColor *)color
                   Font:(CGFloat)font
              Alignment:(UITextAlignment)alignment
{
    ICLabel *label = [[ICLabel alloc] initWithFrame:rect ];
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    label.textAlignment = 1;
    label.numberOfLines = 0;
    label.lineBreakMode = UILineBreakModeMiddleTruncation;
    label.font = kFontSizeExplanation_15;
    [viewParent addSubview:label];
    
    return label;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
