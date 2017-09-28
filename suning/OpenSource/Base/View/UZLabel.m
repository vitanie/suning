//
//  UZLabel.m
//  UZLottery
//
//  Created by kevin on 13/8/15.
//  Copyright (c) 2015年 kevin. All rights reserved.
//

#import "UZLabel.h"

@implementation UZLabel

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

-(void)setUzText:(NSString *)text
{
    self.text = text;
    CGSize size = CGSizeMake(kWindowWidth,kWindowHeight);
    CGSize lotteryNameSize = [text sizeWithFont:self.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    [self setFrame:CGRectMake(self.frame.origin.x,self.frame.origin.y, lotteryNameSize.width, lotteryNameSize.height)];
}
@end
