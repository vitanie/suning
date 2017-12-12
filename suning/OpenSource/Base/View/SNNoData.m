//
//  SNNoData.m
//  suning
//
//  Created by Bai on 2017/9/25.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "SNNoData.h"

@implementation SNNoData
{
    UIImageView* noData;
}
+(SNNoData*)shard
{
    
    static SNNoData *nodata = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //CGRect rect = [[UIScreen mainScreen] bounds];
        nodata = [[SNNoData alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight-kNavigationHeight-100)];
    });
    
    return nodata;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        noData = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wushujiu"]];
        //noData.backgroundColor = [UIColor redColor];
        noData.frame = CGRectMake((kWindowWidth-174)/2+5, 85, 174, 174);
        [self addSubview:noData];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(noData.frame)+5, kWindowWidth, 20)];
        label.text = @"暂无数据刷新试试";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor colorWithRed:158/255.0 green:172/255.0 blue:181/255.0 alpha:1];
        [self addSubview:label];
        
    }
    return self;
}

- (void)setnodataImage:(NSString *)imageStr{
    
    [noData setImage:[UIImage imageNamed:imageStr]];
}
+(void)remove
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
