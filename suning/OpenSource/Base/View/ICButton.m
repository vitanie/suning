//
//  lCButton.m
//  Lottery
//
//  Created by hao chentao on 13-5-15.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//

#import "ICButton.h"

@implementation ICButton
@synthesize m_touchDown;            //记录按钮点击的次数 默认0次
@synthesize selectBool;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.exclusiveTouch = YES;
        self.m_touchDown = 0;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.exclusiveTouch = YES;
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.m_touchDown = 0;
    }
    return self;
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state Shadow:(ShadowType) type Font:(NSInteger)fontnumber Bold:(BOOL) bold Color:(UIColor *)color
{

    
    if (bold == YES) {
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:fontnumber]];
    }
    else
    {
        [self.titleLabel setFont:[UIFont systemFontOfSize:fontnumber]];
    }
    
    if (type == ICButtondown) {
        

        [self setTitleColor:[UIColor blackColor] forState:state];
        //setShadowOnButton(self, color, CGSizeMake(0, 1));
    }
    else if (type == ICButtontop)
    {
        [self setTitleColor:[UIColor whiteColor] forState:state];
        //setShadowOnButton(self, color, CGSizeMake(0, -1));
       
    }
    [super setTitle:title forState:state];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
