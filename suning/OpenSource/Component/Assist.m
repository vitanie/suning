//
//  Assist.m
//  UZLottery
//
//  Created by chenhaojie on 15/10/26.
//  Copyright © 2015年 kevin. All rights reserved.
//



UIImageView * createImageViewforImage(id parents,int tag,CGRect rect, UIImage * strImageName)
{
    UIImageView * view = [[UIImageView alloc] initWithFrame:rect];
    view.tag = tag;
    view.image = strImageName;
    [parents addSubview:view];
    return view;
}

UILabel * createLabelWithAgu(id parents,NSInteger tag,CGRect rect, NSString * strTitle, UIColor * TextColor,UIFont * textFont,UITextAlignment Alignment)
{
    UILabel * label = [[UILabel alloc] initWithFrame:rect];
    label.text  = strTitle;
    label.textColor = TextColor;
    label.font = textFont;
    label.tag = tag;
    label.textAlignment = (int)Alignment;
    
#ifdef DEBUG_UI_POS
    label.backgroundColor = createRandomColor();
#else
    label.backgroundColor = [UIColor clearColor];
#endif
    
    [parents addSubview:label];
    
    return label;
}


ICTextField * createTextFiled(id parents,int tag,CGRect rect,id delegate,NSString * strtext,NSString *strplaceholder,UITextAlignment textAlignment)
{
    ICTextField * inputField = [[ICTextField alloc]init];
    inputField.tag = tag;
    inputField.text = strtext;
    inputField.placeholder = strplaceholder;
    inputField.delegate = delegate;
    inputField.textAlignment = textAlignment;
    inputField.frame = rect;
    inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
#ifdef DEBUG_UI_POS
    inputField.backgroundColor = createRandomColor();
#endif
    
    [parents addSubview:inputField];
    
    return inputField;
}


UIView * createView(id parents,int tag,CGRect rect,UIColor * backColor)
{
    UIView * view  = [[UIView alloc] initWithFrame:rect];
#ifdef DEBUG_UI_POS
    view.backgroundColor = createRandomColor();
#else
    view.backgroundColor = backColor;
#endif
    view.tag = tag;
    [parents addSubview:view];
    return view;
}





/**
 *  功能:获取图片
 *
 *  参数: colorStr颜色
 *
 *  返回值:返回图片
 */
 UIImage * getColorImage(UIColor *colorStr)
{
    
    
    
        
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [colorStr CGColor]);
        CGContextFillRect(context, rect);
        UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    
       
    return theImage;
}





/*
 * 功能:获取一段字符串的占用的宽度及高度
 */
CGSize getStringSize(NSString *str,float witdh,float height,UIFont *font)
{
    
    
    
    CGSize commentTextSize;
    if (kUZversion >=7.0)
    {
        commentTextSize = [str boundingRectWithSize:CGSizeMake(witdh, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:font}
                                            context:nil].size;
    }
    else
    {
        commentTextSize = [str sizeWithFont:font
                          constrainedToSize:CGSizeMake(witdh, MAXFLOAT)];
    }
    
    return commentTextSize;
    
    
    //[str sizeWithFont:font constrainedToSize:CGSizeMake(witdh,height) lineBreakMode:kUZversion>= 6?NSLineBreakByWordWrapping:kLineBreakModeCharacterWrap];
}


NSString* getResolution(){
    //分辨率
    float width = [UIScreen mainScreen].currentMode.size.width;
    float height = [UIScreen mainScreen].currentMode.size.height;
    NSString *resolution = [NSString stringWithFormat:@"%0.0fx%0.0f",width,height];
    return resolution;

}

NSString* getJKCLogicCode(NSString* saleId){

    
    /*
     81001                     年年有余
     81002                     俱乐部台球
     81003                     俱乐部保龄球
     81004                     俱乐部飞镖
     81005                     心心相印
     81006                     乐翻番
     81007                     百宝箱
     81008                     财神到
     81009                     精彩奇妙
     81010                     黄金时代
     */
    
 
    
    NSDictionary* dictionary =  [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"81001",@"NNYY",
                                 @"81002",@"JLBTQ",
                                 @"81003",@"JLBBLQ",
                                 @"81004",@"JLBFB",
                                 @"81005",@"XXXY",
                                 @"81006",@"LFF",
                                 @"81007",@"BBX",
                                 @"81008",@"CSD",
                                 @"81009",@"JCQM5",
                                 @"81010",@"HJSD", nil] ;
    
    
    
    
    return [dictionary objectForKey:saleId];

}