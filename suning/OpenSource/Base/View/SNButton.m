//
//  SNButton.m
//  suning
//
//  Created by Bai on 2017/9/22.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "SNButton.h"

@implementation SNButton
-(id)initWithFrame:(CGRect)frame title:(NSString*)title target:(id)target action:(SEL)action
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:kButtonColor forState:UIControlStateHighlighted];
        [self setBackgroundImage:imageWithColor([UIColor whiteColor]) forState:UIControlStateHighlighted];
        [self setBackgroundImage:imageWithColor([UIColor colorWithHexString:@"#E6313A"]) forState:UIControlStateNormal];
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:3.0];
        [self.layer setBorderColor:[UIColor colorWithHexString:@"#E6313A"].CGColor];
        [self.layer setBorderWidth:1];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
