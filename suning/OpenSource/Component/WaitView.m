//
//  WaitView.m
//  LotteryClient
//
//  Created by 马寅生 on 13-10-22.
//  Copyright (c) 2012-2013 UUZZ All rights reserved.
//

#import "WaitView.h"

#define  GifWidth 50
#define kWaitVieTag    (131314)   //加载框tag
#define kApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface WaitView ()

@end

static WaitView *waitView = nil;
@implementation WaitView



@synthesize bgView;
@synthesize jdtBgView;
@synthesize bgHeight;
@synthesize bgStartY;
@synthesize baseView;







+(id)share
{
    @synchronized(waitView){
        if(!waitView){
            
            
            //等待对话框
            waitView = [[self alloc] initWithFrame:CGRectMake(0.0f, 0, kWindowWidth, kWindowHeight)];
            waitView.backgroundColor = [UIColor clearColor];
            waitView.hidden = YES;
            waitView.tag = kWaitVieTag;
            waitView.userInteractionEnabled = YES;
        }
    }
    return waitView;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        float baseY = kUZversion>=7.0?0:20;
        //背景基本层（黑色透明度遮罩层）
        baseView = [[UIView alloc]initWithFrame:CGRectMake(0, baseY, kWindowWidth, kWindowHeight)];
        baseView.backgroundColor = [UIColor blackColor];
        baseView.alpha = 0.0;
        [self addSubview:baseView];
    
        
        //GIF动画层
        UIImage *gifImage =acquireImage(@"loading_yuan");
        
        gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ICReHeightFlaot(GifWidth) - gifImage.size.width)/2, (ICReHeightFlaot(GifWidth) - gifImage.size.height)/2, gifImage.size.width, gifImage.size.height)];
        
        
        
        [gifImageView setImage:gifImage];
        
        
        
        UIImage *bgImage = acquireImage(@"loading_logo.png");
        
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ICReHeightFlaot(GifWidth) - bgImage.size.width)/2, (ICReHeightFlaot(GifWidth) - bgImage.size.height)/2, bgImage.size.width, bgImage.size.height)];
        [bgImageView setImage:bgImage];
        
        //Loading背景层
        bgView = [[UIImageView alloc]init];
        bgView.frame = CGRectMake(0, 0, ICReHeightFlaot(GifWidth), ICReHeightFlaot(GifWidth));
        bgView.center = CGPointMake(self.frame.size.width/2,self.frame.size.height/2 - 8);
        bgView.backgroundColor = [UIColor blackColor];
        bgView.layer.cornerRadius = 4;
        [bgView setClipsToBounds:YES];
        bgView.alpha = 0.8;
        [self addSubview:bgView];
        self.bgHeight = bgView.frame.size.height;
        self.bgStartY = bgView.frame.origin.y;
        
        
        [bgView addSubview:bgImageView];
        [bgView addSubview:gifImageView];
        
        
        jdtBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, gifImage.size.width, gifImage.size.width)];
        jdtBgView.backgroundColor = [UIColor whiteColor];
        jdtBgView.layer.cornerRadius = 8;
        [jdtBgView setClipsToBounds:YES];
        [self addSubview:jdtBgView];
        
        jdtBgView.hidden = YES;
        
    }
    return self;
}

/*
 * 功能：改变提示框可见区域大小及提示框内各控件位置(普通等待框)
 * 参数：width - 动态宽度 ； height - 动态高度
 */
- (void)changePositionWithWidth:(float)width AndHeight:(float)height
{
    int min = 91;                        //最小边界值
    int value = bgView.frame.size.width; //实际值
    if (width > min) {
        value = width + 15;
    }
    if (width > 200) {
        value = width - 30;
    }
    
    //动态改变背景区域大小
    bgView.frame = CGRectMake(bgView.frame.origin.x, bgView.frame.origin.y, value, bgView.frame.size.height + height);
    bgView.center = CGPointMake(self.frame.size.width/2,self.frame.size.height/2 - 8);
    
    //动态改变动画区域
    gifImageView.frame = CGRectMake(bgView.frame.size.width/2-gifImageView.frame.size.width/2, gifImageView.frame.origin.y, gifImageView.frame.size.width, gifImageView.frame.size.height);
}

/*
 * 功能：改变提示框可见区域大小及提示框内各控件位置(下载等待框)
 * 参数：width - 动态宽度 ； height - 动态高度
 */
- (void)changePositionWithWidthWithProcess:(float)width AndHeight:(float)height
{
    int min = 91;                        //最小边界值
    int value = bgView.frame.size.width; //实际值
    if (width > min) {
        value = width + 15;
    }
    if (width > 200) {
        value = width - 30;
    }
    
    //动态改变背景区域大小
    bgView.frame = CGRectMake(bgView.frame.origin.x, bgStartY, value, bgHeight + height);
    bgView.center = CGPointMake(self.frame.size.width/2,self.frame.size.height/2 - 8);
    
    //动态改变动画区域
    gifImageView.frame = CGRectMake(bgView.frame.size.width/2-gifImageView.frame.size.width/2, gifImageView.frame.origin.y, gifImageView.frame.size.width, gifImageView.frame.size.height);
}


-(void)showDalog{


    [self startAnimation];
    
}

-(void)closeDalog{

    [self stopAnimation];
}


/*
 * 功能：开始动画
 */
-(void)startAnimation
{
   
    
    
    [[UIApplication sharedApplication]windows ];
   
    if (! [[[[UIApplication sharedApplication]windows]objectAtIndex:0] viewWithTag:kWaitVieTag]) {
        
        [[[[UIApplication sharedApplication]windows]objectAtIndex:0] addSubview:(UIView*)self];
        
    }
    
    self.hidden = NO;
    isStopAnimation = NO;
    bgView.hidden = NO;
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    
    [UIView animateWithDuration:0.015 animations:^{
        
        gifImageView.transform = transform;
        
    } completion:^(BOOL flag){
        
        angle +=  2*M_PI /100; //每隔15ms转的度数= 2*M_PI /100
        if (angle > M_PI*2) {//大于 M_PI*2(360度) 角度再次从0开始
            angle = 0;
        }
        if (!isStopAnimation) {
            
            [self startAnimation];
        }
        
    }];
}

/*
 * 功能：停止动画
 */
-(void)stopAnimation
{
    self.hidden = YES;
    isStopAnimation = YES;
    bgView.hidden = YES;
    //还原视图的原始位置
    gifImageView.transform = CGAffineTransformMakeRotation(2*M_PI-angle);
    //还原度数
    angle = 0;
    
    
    if ( [[[[UIApplication sharedApplication]windows]objectAtIndex:0] viewWithTag:kWaitVieTag]) {
        
        [self  removeFromSuperview];
    }
}



@end
