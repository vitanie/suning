//
//  MainAndSubtitleCell.m
//  Lottery
//
//  Created by chenhaojie on 15/7/23.
//  Copyright © 2015年 UUZZ. All rights reserved.
//

#import "MainAndSubTitleCell.h"
@interface MainAndSubTitleCell ()
@property(nonatomic,retain)UIImageView  *iconImage;             //缩略图
@property(nonatomic,retain)UILabel      *mainTitle;             //主标题
@property(nonatomic,retain)UILabel      *subTitle;              //副标题
@property(nonatomic,retain)UILabel      *recommandStaticText;   //(推荐)静态文字
@property(nonatomic,retain)UIImageView  *arrowImageView;             //指示箭头

@end

@implementation MainAndSubTitleCell
@synthesize iconImage;
@synthesize mainTitle;
@synthesize subTitle;
@synthesize recommandStaticText;
@synthesize arrowImageView;

/**
 *  功能:初始化方法
 *
 *  参数: style          cell样式
 *  参数: reuseIdentifier cell唯一标示
 *
 *  返回值:cell对象
 */
-(id)initWithStyleDefault:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
        [self setLayoutSubViews];
        
    }
   
    return self;
}

-(void)initSubViews{

    //缩略图
    iconImage = [[UIImageView alloc]init];
    iconImage.contentMode =  UIViewContentModeScaleAspectFill;
    iconImage.clipsToBounds = YES;
    [self addSubview:iconImage];
   
    
    //主标题
    mainTitle = [[UILabel alloc]init];
    mainTitle.adjustsFontSizeToFitWidth = YES;
    [mainTitle setFont:kFontSizeExplanation_15];
    [mainTitle setTextColor:colorWithHexString(@"#333333")];
    [self addSubview:mainTitle];
    
    
    //副标题
    subTitle = [[UILabel alloc]init];
    [subTitle setFont:kFontSizeExplanation_12];
    [subTitle setTextColor:colorWithHexString(@"#999999")];
    [self addSubview:subTitle];
    
    
    //静态推荐文字
    
    recommandStaticText = [[UILabel alloc]init];
    recommandStaticText.hidden = YES;
    [recommandStaticText setText:@"(推荐)"];
    [recommandStaticText setFont:kFontSizeExplanation_12];
    [recommandStaticText setTextColor:colorWithHexString(@"#ff0000")];
    [self addSubview:recommandStaticText];
    
    
    //箭头
    arrowImageView = [[UIImageView alloc]init];
    [arrowImageView setImage:[UIImage imageNamed:@"bt_jiantou_05.png"]];
    [self addSubview:arrowImageView];

    
    
}

-(void)setLayoutSubViews{

    //cell高度60
    
    CGFloat  cellWidth = kWindowWidth;
    CGFloat  cellHeight = 75;//cell 高度
    CGFloat  iconWidth = 44.0;//图标宽度
    CGFloat  leftSpace = 15;//左边距（屏幕）
    CGFloat  titleSpace = 10;//标题距离图标右边10像素
    
    [iconImage setFrame:CGRectMake(leftSpace, (cellHeight - iconWidth)/2, iconWidth, iconWidth)];
    CGFloat titleStartX = CGRectGetMaxX(iconImage.frame)+titleSpace;
    
    CGFloat startMainTitleY = (CGRectGetHeight(iconImage.frame)-20-15)/3+CGRectGetMinY(iconImage.frame);
    [mainTitle setViewY:startMainTitleY];

   
    UIImage* arrowImage = [UIImage imageNamed:@"bt_jiantou_05.png"];
    CGSize arrowSize = arrowImage.size;
    CGRect arrowRect  = CGRectMake(cellWidth - leftSpace -  arrowSize.width, (cellHeight - arrowSize.height)/2, arrowSize.width, arrowSize.height);
    [arrowImageView setFrame:arrowRect];
    
    
    CGRect rect = CGRectMake(titleStartX, startMainTitleY, cellWidth - titleStartX -leftSpace, 20);
    [mainTitle setFrame:rect];
    [subTitle setFrame:rect];
    [recommandStaticText setFrame:CGRectMake(CGRectGetMaxX(mainTitle.frame)+10, startMainTitleY-2, 60, 18)];
    
    subTitle.numberOfLines = 0;
    [subTitle setViewHeight:25];
    [subTitle setViewY:CGRectGetMaxY(mainTitle.frame)];
    CGRect lineRect = CGRectMake(titleStartX, cellHeight - 1, cellWidth - titleStartX -leftSpace, 1);
    [self.baseLineView setFrame:lineRect];

}


/**
 *  功能:更新cell
 *
 *  参数: mainTitleStr  主标题
 *  参数: subTitleStr   子标题
 *  参数: imageParam 图片对象或者图片url地址
 *  参数: isShowRecommand 是否显示推荐文字
 */
-(void)updateSubviewswithParams:(NSString*)mainTitleStr
                    andSubTitle:(NSString *)subTitleStr
             andIconImageURLStr:(id)imageParam
                isShowRecommand:(BOOL)isShowRecommand;
{
    

    mainTitle.text = mainTitleStr;
    
    if (isShowRecommand) {
        
        recommandStaticText.hidden = YES;
    }
    
    subTitle.text = subTitleStr;
    if ([imageParam isKindOfClass:[UIImage class]])
    {
        
        
        iconImage.image = imageParam;
        
    }
    else
    {
    
        if ([NSString isEmptyStr:imageParam]) {
            
            
            iconImage.image = nil;
            
        }
        else if(![[imageParam substringToIndex:4] isEqualToString:@"http"])
        {
            iconImage.image = [UIImage imageNamed:imageParam];
        }
        else
        {
                
            [iconImage loadImageWithURLStr:imageParam placeHolderImage:nil];
        }

    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
  CGFloat height =   CGRectGetHeight(self.frame);
   
    [arrowImageView setViewY:(height - CGRectGetHeight(arrowImageView.frame))/2];
    
}

@end
