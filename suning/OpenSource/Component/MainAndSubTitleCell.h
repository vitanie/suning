//
//  MainAndSubtitleCell.h
//  Lottery
//
//  Created by chenhaojie on 15/7/23.
//  Copyright © 2015年 UUZZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"

@interface MainAndSubTitleCell : BaseTableCell


/**
 *  功能:初始化方法
 *
 *  参数: style          cell样式
 *  参数: reuseIdentifier cell唯一标示
 *
 *  返回值:cell对象
 */
-(id)initWithStyleDefault:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


/**
 *  功能:初始化控件
 */
-(void)initSubViews;
/**
 *  功能:设置控件的坐标
 */
-(void)setLayoutSubViews;

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


@end
