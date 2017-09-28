
#import <UIKit/UIKit.h>

@interface HYPageView : UIScrollView

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *unselectedColor;
@property (nonatomic, strong) UIColor *topTabBottomLineColor;
@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat rightSpace;
@property (nonatomic, assign) CGFloat minSpace;
@property (nonatomic, assign) CGFloat topSpace;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, assign) BOOL isAdapteNavigationBar;
@property (nonatomic, assign) BOOL isAnimated;
@property (nonatomic, assign) BOOL isTranslucent;
@property (nonatomic, assign) BOOL isAverage;

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withViewControllers:(NSArray *)controllers withParameters:(NSArray *)parameters;

@end
