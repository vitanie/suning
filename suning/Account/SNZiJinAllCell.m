//
//  SNZiJinAllCell.m
//  suning
//
//  Created by 白云皓 on 2017/11/10.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "SNZiJinAllCell.h"

@interface SNZiJinAllCell()
@property(nonatomic,strong)UILabel* descL;
@property(nonatomic,strong)UILabel* descLabel;
@property(nonatomic,strong)UILabel* leftL;
@property(nonatomic,strong)UILabel* timeLabel;
@property(nonatomic,strong)UIImageView* line;
@end


@implementation SNZiJinAllCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUZCashCell];
    }
    return self;
}

-(void)initUZCashCell
{
    
    //操作时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10, kWindowWidth, 15)];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = [UIFont systemFontOfSize:11];
    _timeLabel.textColor = kTextFontColor;
    [self addSubview:_timeLabel];
    
    //类型标题
    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(_timeLabel.frame)+5, kWindowWidth-20, 12)];
    _descLabel.textAlignment = NSTextAlignmentLeft;
    _descLabel.font = [UIFont boldSystemFontOfSize:11];
    _descLabel.textColor = kFontGrayColor;
    _descLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _descLabel.numberOfLines = 0;
    [self addSubview:_descLabel];
    
    //标题 操作金额
    _descL = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_descLabel.frame)+5, kWindowWidth, 11)];
    _descL.textAlignment = NSTextAlignmentLeft;
    _descL.font = [UIFont systemFontOfSize:11];
    _descL.textColor = kTextFontColor;
    [self addSubview:_descL];
    
    //标题 余额
    _leftL = [[UILabel alloc] initWithFrame:CGRectMake(kWindowWidth-250, CGRectGetMaxY(_descLabel.frame)+5,200, 11)];
    _leftL.textAlignment = NSTextAlignmentRight;
    _leftL.font = [UIFont systemFontOfSize:11];
    _leftL.textColor = [UIColor colorWithRed:226.0/255 green:166.0/255 blue:117.0/255 alpha:1];
    [self addSubview:_leftL];
    
    
    //分割线
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, 1)];
    _line.image = [UIImage imageNamed:@"xuxian"];
    [self addSubview:_line];
    
}


-(void)setItem:(NSDictionary*)item
{
    
    NSString* flag = [item objectForKey:@"flag"];
    if ([flag isEqualToString:@"+"]) {
        _descL.text = [NSString stringWithFormat:@"%@: +%@元",[item objectForKey:@"desc"],[StaticTools fenToyuan:[item objectForKey:@"value"]]];
        _descL.textColor = kRedBallColor;
    }
    else if([flag isEqualToString:@"-"])
    {
        _descL.text = [NSString stringWithFormat:@"%@: -%@元",[item objectForKey:@"desc"],[StaticTools fenToyuan:[item objectForKey:@"value"]]];
        _descL.textColor = kBlueBallColor;
    }
    else
    {
        _descL.text = [NSString stringWithFormat:@"%@: %@元",[item objectForKey:@"desc"],[StaticTools fenToyuan:[item objectForKey:@"value"]]];
    }
    
    UIFont* theFont = [UIFont boldSystemFontOfSize:11];
    _descLabel.text = [NSString stringWithFormat:@"类型:%@",[item objectForKey:@"actDesc"]];
    
    CGSize size = [_descLabel.text sizeWithFont:theFont
                              constrainedToSize:CGSizeMake(kWindowWidth-20, MAXFLOAT)
                                  lineBreakMode:NSLineBreakByWordWrapping];
    
    [_descLabel setViewHeight:size.height];
    [_descL setViewY:CGRectGetMaxY(_descLabel.frame)+5];
    [_leftL setViewY:CGRectGetMaxY(_descLabel.frame)+5];
    [_line setViewY:CGRectGetMaxY(_descL.frame)+5];
    _leftL.text = [NSString stringWithFormat:@"余额: %@元",[StaticTools fenToyuan:[item objectForKey:@"left"]]];
    
    NSString* time = [item objectForKey:@"time"];
    NSString* moon = [time substringWithRange:NSMakeRange(4, 2)];
    NSString* day = [time substringWithRange:NSMakeRange(6, 2)];
    NSString* hour = [time substringWithRange:NSMakeRange(8, 2)];
    NSString* minute = [time substringWithRange:NSMakeRange(10, 2)];
    //    //week计算
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyyMMdd"];
    //    NSDate *weekDate = [dateFormatter dateFromString:[time substringToIndex:8]];
    //    NSString* week = [UZStaticTools weekdayStringFromDate:weekDate];
    _timeLabel.text = [NSString stringWithFormat:@"%@-%@ %@:%@",moon,day,hour,minute];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
