
#import "UZPagesBarBtn.h"

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


@implementation UZPagesBarBtn


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //个性化
        [self UZPagesBarBtnPrePare];
    }
    
    return self;
}



-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //个性化
        [self UZPagesBarBtnPrePare];
    }
    
    return self;
}

/**
 *  个性化
 */
-(void)UZPagesBarBtnPrePare{
    
    [self setTitleColor:kTextFontColor forState:UIControlStateNormal];
    //[self setTitleColor:kNavigationColor forState:UIControlStateHighlighted];
    [self setTitleColor:kNavigationColor forState:UIControlStateSelected];
}


@end
