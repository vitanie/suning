//
//  ICLabel.m
//  Lottery
//
//  Created by hao chentao on 13-5-15.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//

#import "ICLabel.h"

@implementation ICLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}

- (id)initWithCustomeStr:(NSString *)str isWarping:(BOOL)warp re:(CGRect)rect col:(UIColor *)color bgCol:(UIColor *)bgcol fon:(UIFont *)strfont
{
    self = [super initWithFrame:rect];
    if (self) {
        if (warp) {
            //self.lineBreakMode = kLineBreakModeCharacterWrap;
            self.numberOfLines = 0;
        }
        self.text = str;
        self.font = strfont;
        self.textColor = color;
        self.backgroundColor = bgcol;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.preferredMaxLayoutWidth = self.bounds.size.width;
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
