//
//  CustomPwdKeyBoard.m
//  jianpan
//
//  Created by Mr_Zhu on 15/2/4.
//  Copyright (c) 2015年 Mr_Zhu. All rights reserved.
//

#define VIEWHEIGHT  220    //底层框高度
#define TOPHEIGHT   0     //顶部层高度

#define COMPLETETAG     101 //完成tag
#define DELETETAG       102 //删除tag

#define KEYBORDSHOWSIZE @"keyBordShowSize"  //数字键盘弹出
#define KEYBORDHideSIZE @"keyBordHideSize"  //数字键盘关闭

#import "CustomPwdKeyBoard.h"
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomPwdKeyBoard ()
{
    UIImage *delImg;    //删除图标
    UIImage *compleImg; //展位图标
    UIImage *topImg;    //topView图标
    
    UIColor *fNumCol; //非数字按钮背景
    UIColor *numCol; //非数字按钮背景
    
    UIView *topView;    //顶层view
    UIView *downView;   //底层view
}
@property (assign, nonatomic) bordType type;
@property (copy, nonatomic) NSString *textFile;
@property (assign, nonatomic) id smClass;

@property (strong, nonatomic) NSArray *numArr;   //数据源
@end
static CustomPwdKeyBoard *pwd = nil;
@implementation CustomPwdKeyBoard
+(id)shareWithView:(UIView *)view textViews:(id)textView bordType:(bordType)type
{
    @synchronized(pwd)
    {
        if(!pwd){
            pwd = [[CustomPwdKeyBoard alloc]initWithFrame:CGRectMake(0, kWindowHeight, kWindowWidth, VIEWHEIGHT+TOPHEIGHT)];
            pwd.backgroundColor = [UIColor clearColor];
        }
        [view addSubview:pwd];
        pwd.type = type;
        pwd.textFile = [textView valueForKey:@"text"];
        pwd.smClass = textView;
        [pwd createNumberView];
    }
    
    return pwd;
}
//获取键盘高度
+(float)getKeyBoardHeight
{
    if(pwd){
        return CGRectGetHeight(pwd.frame);
    }
    return 0;
}
/**
 *  功能:创建键盘层/显示
 */
-(void)createNumberView
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];

    [self getImgDataSource];
    [self createViews];
    [self getDataSource];
    [self showView];
}
//创建顶部view
-(void)createViews
{
    //topView
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowWidth, TOPHEIGHT)];
    topView.backgroundColor = colorWithHexString(@"#EBEBEB");
    topView.clipsToBounds = YES;
    NSString *str = @"手机在线安全输入";
    CGSize size = getStringSize(str, kWindowWidth, TOPHEIGHT, [UIFont systemFontOfSize:17]);
    
    UIImageView *logoImg = [[UIImageView alloc]initWithFrame:CGRectMake((kWindowWidth - (topImg.size.width+5+size.width))/2, (TOPHEIGHT - topImg.size.height)/2, topImg.size.width, topImg.size.height)];
    logoImg.image = topImg;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(logoImg.frame)+5, (CGRectGetHeight(topView.frame) - size.height)/2, size.width, size.height)];
    label.text = str;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = colorWithHexString(@"#3A3A3A");
    label.font = [UIFont systemFontOfSize:17];
    
    [topView addSubview:label];
    [topView addSubview:logoImg];
    [self addSubview:topView];
    
    //downView
    downView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), kWindowWidth, VIEWHEIGHT)];
    downView.backgroundColor = colorWithHexString(@"#D4D4D4");
    [self addSubview:downView];
}
//配置数据源
-(void)getDataSource
{
    switch (_type) {
        case NumType:
            _numArr = [self getRandomNum:[NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5",@"6", @"7",@"8",@"9",@"0",nil]];
            break;
        case cardType:
        case smallType:
        case doubelType:
            _numArr = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4",@"5", @"6",@"7",@"8",@"9",@"0",nil];
            break;
            
        default:
            break;
    }
    [self createXButtons];
}
//配置图片资源
-(void)getImgDataSource
{
    fNumCol = colorWithHexString(@"#ACB4BF");
    numCol = colorWithHexString(@"#FFFFFF");
    topImg = acquireImage(@"ic_keyboard");


    delImg = acquireImage(@"clearbt.png");
    compleImg = acquireImage(@"keyboard.png");
}
/**
 *  功能:获取随机不重复数
 */
-(NSArray *)getRandomNum:(NSArray *)arr
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:arr];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    int i;
    NSUInteger count = [arr count];
    for (i = 0; i < count; i ++) {
        int index = arc4random() % (count - i);
        [resultArray addObject:[tempArray objectAtIndex:index]];
        [tempArray removeObjectAtIndex:index];
        
    }
    return resultArray;
}
//获取渐变色
-(UIImage *)getColor:(CGSize)size andColor:(NSArray *)colorArr
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, size.width, size.height);
    gradient.colors = colorArr;
    
    UIGraphicsBeginImageContextWithOptions(gradient.frame.size, NO, 0);
    [gradient renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
    
}
/**
 *  功能:创建身份证右边button
 */
-(void)createXButtons
{
    float x = 5;    //间距
    float y = 5;    //间距
    float width = (kWindowWidth - x*5)/4;
    float height = (VIEWHEIGHT - y*3)/2;
    UIButton *button = nil;
    //身份证
    for(int i=0;i<2;i++){
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setAdjustsImageWhenHighlighted:NO];
        button.frame = CGRectMake(kWindowWidth - x - width, y, width, height);
        button.layer.cornerRadius = 4;
        [button setClipsToBounds:YES];  //子view超出父view时会截掉
        [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchDown];
        [button setExclusiveTouch:YES]; //单点控制
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        button.titleLabel.font = [UIFont systemFontOfSize:20];
        if(i == 0){
            [button setBackgroundImage:imageWithColor(fNumCol) forState:UIControlStateNormal];
            
            UIImageView *tempImg = [[UIImageView alloc]initWithFrame:CGRectMake((width - delImg.size.width)/2,(CGRectGetHeight(button.frame) - delImg.size.height)/2,delImg.size.width,delImg.size.height)];
            tempImg.image = delImg;
            [button addSubview:tempImg];
            button.tag = DELETETAG;
            
        }
        else{
            [button setBackgroundImage:imageWithColor(fNumCol) forState:UIControlStateNormal];
            [button setTitle:@"完成" forState:UIControlStateNormal];
            button.tag = COMPLETETAG;
        }
        y += y+height;
        [downView addSubview:button];
    }
    [self createButtons];
}
/**
 *  功能:创建button
 */
-(void)createButtons
{
    int index = 0;  //数组下标
    int widN = 4;
    float x = 5;
    float y = 5;
    float width = (kWindowWidth - x*(widN+1))/widN;
    float height = (VIEWHEIGHT - y*5)/4;
    UIButton *button = nil;
    for(int i=1;i<13;i++){
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setAdjustsImageWhenHighlighted:NO];//去掉按钮点击高亮效果
        button.frame = CGRectMake(x, y, width, height);
        button.tag = i-1;
        [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchDown];
        [button setExclusiveTouch:YES]; //单点控制
        button.layer.cornerRadius = 4;
        [button setClipsToBounds:YES];  //子view超出父view时会截掉
        button.userInteractionEnabled = YES;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        button.titleLabel.font = [UIFont systemFontOfSize:20];
        [downView addSubview:button];
        x += width + 5;
        if(i%3 == 0){
            y += 5+height;
            x = 5;
        }
        //配置颜色
        
        if(i == 12){
            [button setBackgroundImage:imageWithColor(fNumCol) forState:UIControlStateNormal];
            UIImageView *tempImg = [[UIImageView alloc]initWithFrame:CGRectMake((width - compleImg.size.width)/2,(CGRectGetHeight(button.frame) - compleImg.size.height)/2,compleImg.size.width,compleImg.size.height)];
            tempImg.image = compleImg;
            [button addSubview:tempImg];
            button.tag = COMPLETETAG;
        }
        else if (i == 10){
            [button setBackgroundImage:imageWithColor(numCol) forState:UIControlStateNormal];
            if(_type == 2){
                [button setTitle:@"x" forState:UIControlStateNormal];
            }
            else if (_type == smallType){
                [button setTitle:@"." forState:UIControlStateNormal];
            }
            else{
                [button setBackgroundImage:imageWithColor(fNumCol) forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            }
        }
        else{
            
            [button setBackgroundImage:imageWithColor(numCol) forState:UIControlStateNormal];
            [button setTitle:[_numArr objectAtIndex:index] forState:UIControlStateNormal];
            index++;
        }
    }
}
-(void)touchDown:(UIButton *)sender
{
    sender.alpha = 0.5;
}
-(void)buttonTap:(UIButton *)sender
{
    sender.alpha = 1.0;
    AudioServicesPlaySystemSound(1104);
    _textFile = [self.smClass valueForKey:@"text"];
    if(sender.tag == COMPLETETAG){
        //完成
        if(_removeBlock){
            _removeBlock();
        }
        [self remove];
        return;
    }
    else if(sender.tag == DELETETAG){
        //删除
        if(_textFile.length>0){
            if([_textFile hasSuffix:@" "] || [_textFile hasSuffix:@"-"] || (_textFile.length>1?[[_textFile substringWithRange:NSMakeRange([_textFile length]-2, 1)] isEqualToString:@" "] :NO)|| (_textFile.length>1?[[_textFile substringWithRange:NSMakeRange([_textFile length]-2, 1)] isEqualToString:@"-"] :NO)){
                
                _textFile = [_textFile substringToIndex:[_textFile length]-2];
            }
            else{
                _textFile = [_textFile substringToIndex:[_textFile length]-1];
                
            }
        }
    }
    else{
        _textFile = [_textFile stringByAppendingString:sender.titleLabel.text];
    }
    if(_type == doubelType){
//        if([_textFile length]>2 && !_isNotBetting){
//            return;
//        }
    }
    [self.smClass setValue:_textFile forKey:@"text"];
    if(_changeBlock){
        _changeBlock();
    }
}
-(void)showView
{
    float viewY = (kWindowHeight) - CGRectGetHeight(self.frame);
    if([self.superview isKindOfClass:[[[UIApplication sharedApplication].windows objectAtIndex:0] class]] && kUZversion < 7.0){
        viewY += 20;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self setViewY:viewY];
    } completion:^(BOOL finished){
        
    }];
}
-(void)remove
{
    self.isNotBetting = NO;
    float viewY = kWindowHeight;
    if([self.superview isKindOfClass:[[[UIApplication sharedApplication].windows objectAtIndex:0] class]] && kUZversion < 7.0){
        viewY += 20;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self setViewY:viewY];
    } completion:^(BOOL isFinish){
    }];
    if(![self.superview isKindOfClass:[[[UIApplication sharedApplication].windows objectAtIndex:0] class]]){
        [(UIResponder *)_smClass resignFirstResponder];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:KEYBORDHideSIZE object:nil];
    }
}
+(void)removes
{
    [pwd remove];
}
-(void)releases
{
    float viewY = kWindowHeight;
    if([self.superview isKindOfClass:[[[UIApplication sharedApplication].windows objectAtIndex:0] class]] && kUZversion < 7.0){
        viewY += 20;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self setViewY:viewY];
    } completion:^(BOOL finished){
        _numArr = nil;
        [topView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
        [downView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
        _removeBlock = nil;
        _changeBlock = nil;
        [self removeFromSuperview];
        if(pwd){
            pwd = nil;
        }
    }];
    if(![self.superview isKindOfClass:[[[UIApplication sharedApplication].windows objectAtIndex:0] class]]){
        [(UIResponder *)_smClass resignFirstResponder];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:KEYBORDHideSIZE object:nil];
    }
    
}
+(void)release
{
    [pwd releases];
}
-(void)dealloc
{
    NSLog(@"调用dealloc");
}

@end
