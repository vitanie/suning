
#import <UIKit/UIKit.h>
#import "UZPagesBarBtn.h"
#import "UZPagesViewConfig.h"

@interface UZPagesBarView : UIScrollView



/**
 *  分页模型数组
 */
@property (nonatomic,strong) NSArray *pageModels;

/**
 *  页码
 */
@property (nonatomic,assign) NSUInteger page;

/**
 *  btn操作block
 */
@property (nonatomic,copy) void (^btnActionBlock)(UZPagesBarBtn *btn,NSUInteger selectedIndex);


@property (nonatomic,strong) UZPagesViewConfig *config;

@end
