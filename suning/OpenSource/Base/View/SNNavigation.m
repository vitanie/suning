//
//  SNNavigation.m
//  suning
//
//  Created by Bai on 2017/9/21.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import "SNNavigation.h"
#define NAVIGATION_BACK_BUTTON_WIDTH 50
#define NAVIGATION_BACK_BUTTON_HEIGHT 40

#define NAVIGATION_HELP_BUTTON_WIDTH 50
#define NAVIGATION_HELP_BUTTON_HEIGHT 40

#define NAVIGATION_TITLE_HEIGHT 15
@implementation SNNavigation
@synthesize rightBtn;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame title:(NSString*)title isBack:(BOOL)isBack isHelp:(BOOL)isHelp
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //Login导航背景图
        self.backgroundColor = [UIColor colorWithHexString:@"#d41e15"];
        
        
        //标题
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, (frame.size.height-NAVIGATION_TITLE_HEIGHT - kStateBarHeight)/2 + kStateBarHeight, kWindowWidth, NAVIGATION_TITLE_HEIGHT)];
        _title.font = [UIFont boldSystemFontOfSize:18];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.text = title;
        _title.textColor = [UIColor whiteColor];
        [self addSubview:_title];
        //返回按钮
        UIButton* backBt = [UIButton buttonWithType:UIButtonTypeCustom];
        //backBt.backgroundColor = [UIColor redColor];
        [backBt setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
        backBt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [backBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backBt addTarget:self action:@selector(navigationBackClick) forControlEvents:UIControlEventTouchUpInside];
        backBt.frame = CGRectMake(-5.0f,(frame.size.height-NAVIGATION_BACK_BUTTON_HEIGHT - kStateBarHeight)/2 + kStateBarHeight,
                                  NAVIGATION_BACK_BUTTON_WIDTH,
                                  NAVIGATION_BACK_BUTTON_HEIGHT);
        backBt.hidden = YES;
        if (isBack == YES) {
            backBt.hidden = NO;
        }
        [self addSubview:backBt];
        //帮助按钮
        rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setImage:[UIImage imageNamed:@"nav_help"] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(navigationHelpClick) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.frame = CGRectMake(frame.size.width-NAVIGATION_HELP_BUTTON_WIDTH-5.0f,
                                    (frame.size.height-NAVIGATION_HELP_BUTTON_HEIGHT - kStateBarHeight)/2 + kStateBarHeight,
                                    NAVIGATION_HELP_BUTTON_WIDTH,
                                    NAVIGATION_HELP_BUTTON_HEIGHT);
        rightBtn.hidden = YES;
        if (isHelp == YES) {
            rightBtn.hidden = NO;
        }
        [self addSubview:rightBtn];
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame title:(NSString*)title  rightBtnTitle:(NSString*)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //Login导航背景图
        self.backgroundColor = kNavigationColor;
        
        //标题
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, (frame.size.height-NAVIGATION_TITLE_HEIGHT - kStateBarHeight)/2 + kStateBarHeight, kWindowWidth, NAVIGATION_TITLE_HEIGHT)];
        _title.font = [UIFont boldSystemFontOfSize:18];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.text = title;
        _title.textColor = [UIColor whiteColor];
        [self addSubview:_title];
        //返回按钮
        UIButton* backBt = [UIButton buttonWithType:UIButtonTypeCustom];
        //backBt.backgroundColor = [UIColor redColor];
        [backBt setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
        backBt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [backBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backBt addTarget:self action:@selector(navigationBackClick) forControlEvents:UIControlEventTouchUpInside];
        backBt.frame = CGRectMake(-10.0f,(frame.size.height-NAVIGATION_BACK_BUTTON_HEIGHT - kStateBarHeight)/2 + kStateBarHeight,
                                  NAVIGATION_BACK_BUTTON_WIDTH,
                                  NAVIGATION_BACK_BUTTON_HEIGHT);
        
        [self addSubview:backBt];
        //帮助按钮
        UIButton* helpBt = [UIButton buttonWithType:UIButtonTypeCustom];
        helpBt.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [helpBt setTitle:titles forState:UIControlStateNormal];
        [helpBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [helpBt addTarget:self action:@selector(navigationRightClick) forControlEvents:UIControlEventTouchUpInside];
        CGSize size = getStringSize(titles, kWindowWidth, 20, kFontSizeExplanation_15);
        helpBt.frame = CGRectMake(frame.size.width-size.width-5.0f,
                                  (frame.size.height-size.height - kStateBarHeight)/2 + kStateBarHeight,
                                  size.width,
                                  size.height);
        helpBt.hidden = YES;
        if (titles.length) {
            helpBt.hidden = NO;
        }
        [self addSubview:helpBt];
        
    }
    return self;
}

-(void)navigationBackClick
{
    NSLog(@"back");
    if (_delegate) {
        [_delegate navigationBackClick];
    }
    
}

-(void)navigationHelpClick
{
    NSLog(@"help");
    if (_delegate) {
        [_delegate navigationHelpClick];
    }
    
}

- (void)navigationRightClick
{
    if (_delegate) {
        [_delegate navigationRigthClick];
    }
}

- (void)setRightBtnImg:(NSString *)rightBtnimgName
{
    [rightBtn setImage:[UIImage imageNamed:rightBtnimgName] forState:UIControlStateNormal];
}
@end
