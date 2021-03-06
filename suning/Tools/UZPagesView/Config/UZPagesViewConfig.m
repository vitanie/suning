
#import "UZPagesViewConfig.h"

@implementation UZPagesViewConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //默认值设置
        [self defaultValueSet];
    }
    return self;
}


/** 默认值设置 */
-(void)defaultValueSet{
    
    //顶部按钮的基本宽度
    _barBtnWidth = 40;
    
    //顶部按钮的扩展宽度
    _barBtnExtraWidth = 10;
    
    //是否使用自定义的宽度，如果不使用，则框架自行计算宽度
    _isBarBtnUseCustomWidth = YES;
    
    //bar条的高度
    _barViewH = 32;
    
    //字体大小
    _barBtnFontPoint = 13.0f;
    
    //顶部菜单最左和最右的间距
    _barScrollMargin = 10;
    
    //菜单按钮之间的间距
    _barBtnMargin = 30;
    
    //线条多余长度（单边）
    _barLineViewPadding = 10;
    
    //主体内容区间距值
    _mainViewMargin = 10;
    
    //动画时长
    _animDuration = 0.25f;
}


@end
