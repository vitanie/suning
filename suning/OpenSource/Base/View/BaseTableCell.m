//
//  BaseTableCell.m
//  Happy
//
//  Created by chenhaojie on 15/7/30.
//  Copyright © 2015年 tsunami. All rights reserved.
//

#import "BaseTableCell.h"

@interface BaseTableCell()



@end

@implementation BaseTableCell
@synthesize baseLineView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.exclusiveTouch = YES;
        baseLineView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetHeight(self.frame)-1, kWindowWidth - 10 * 2, 1)];
        [baseLineView setBackgroundColor:colorWithHexString(@"#EAEDEF")];
        baseLineView.hidden = YES;
        [self addSubview:baseLineView];
    }
    return self;
}



/**
 *  功能:更新列表子视图的数据
 *
 *  参数: param 子视图显示时需要的数据源
 */
-(void)updateSubViewsWithParam:(id)param{


}

/**
 *  功能:创建子视图控件
 */
-(void)initSubViews{


}
/**
 *  功能:设置子视图的frame
 */
-(void)setSubViews{


}


/**
 *  功能:维护线条显示隐藏
 *
 *  参数: Total 数据总条数
 *  参数: Index 当前第几条
 */
- (void)setLineHidden:(NSInteger) Total CurrentIndex:(NSInteger) Index
{
    
    baseLineView.hidden =  (Index == Total - 1) ? YES : NO;
    
    
}

@end
