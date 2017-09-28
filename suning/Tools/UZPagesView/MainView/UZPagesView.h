//
//  UZPagesView.h
//  UZLottery
//
//  Created by kevin on 8/8/15.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UZPageModel.h"
#import "UZPagesViewConfig.h"

@protocol UZPagesViewDelegate
-(void)uzPagesViewSelectedIndex:(NSInteger)index;
@end
@interface UZPagesView : UIView<UZPagesViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,assign)id<UZPagesViewDelegate>delegate;

/** 中转到指定页码 */
-(void)jumpToPage:(NSUInteger)jumpPage;



/**
 *  快速实例化对象
 *
 *  @param ownerVC    本视图所属的控制器
 *  @param pageModels 模型数组
 *  @param config     配置
 *
 *  @return 实例
 */
+(instancetype)viewWithOwnerVC:(UIViewController *)ownerVC pageModels:(NSArray *)pageModels config:(UZPagesViewConfig *)config;






@end
