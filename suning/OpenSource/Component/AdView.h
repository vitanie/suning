//
//  AdView.h
//  Lottery
//
//  Created by chenhaojie on 13-12-24.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//
//  =====================================================
//  视图:消息通知轮播图界面（任何场景只在大厅显示）-此页面的显示内容（图片）有缓存机制
//  功能:显示消息通知的轮播图片（可以手动轮播可以自动轮播）点击一条进入新闻详情界面，返回的时候进入新闻列表界面。
//  =====================================================



@interface AdView : UIView<UIScrollViewDelegate>



/**
	@功能: 初始化创建轮播广告图
	@参数: frame 广告图frame
	@参数: adarray 广告图数组
	@返回值: 广告图对象
 */
- (id)initWithFrame:(CGRect)frame adArray:(NSMutableArray *)adarray
;

/**
 @功能: 开始动画
 */
- (void)startAdAnimation;
/**
 @功能: 更新轮播图图片
 */
- (void)updateCycleView;
@end

