//
//  AdView.m
//  Lottery
//
//  Created by chenhaojie on 13-12-24.
//  Copyright (c) 2013年 UUZZ. All rights reserved.
//


#import "AdView.h"
#define  adTag  0xa0


@interface AdView ()
{
 
    UIScrollView * scrollView;     //滚动试图
    NSInteger            currentPage;    //当前显示的第几组数据（3个为一组）
    UIView *       blackbgView;    //背景颜色
    UIPageControl* pageControl;     //页面控制器(显示圆点)
    
}

@property(nonatomic,strong)NSMutableArray *adArray;              //活动数组
@property(nonatomic, strong) NSTimer      *adTimer;              //轮播定时器
@property(nonatomic,assign)  NSInteger          adIndex;               //当前显示的ad的索引值
@property(nonatomic,strong)NSMutableArray *adimageViewArray;     //活动数组图片
@property(nonatomic,strong)NSMutableArray *currentAdImageArray;  //活动数组图片
@property(nonatomic, strong) NSTimer      *animationTimer;       //动画间隔
@end

@implementation AdView

@synthesize adArray;

@synthesize adTimer;
@synthesize adIndex;
@synthesize adimageViewArray;
@synthesize currentAdImageArray;
@synthesize animationTimer;


#pragma mark mark====================*********CreateUI*********==========================
/**
 @功能: 初始化创建轮播广告图
 @参数: frame 广告图frame
 @参数: adarray 广告图数组
 @返回值: 广告图对象
 */

- (id)initWithFrame:(CGRect)frame adArray:(NSMutableArray *)adarray
{
    self = [super initWithFrame:frame];
    if (self) {
        
         blackbgView= [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        blackbgView.alpha = 0.75;
        blackbgView.backgroundColor= [UIColor blackColor];
        [self addSubview:blackbgView];
        self.adArray = [[NSMutableArray alloc]initWithArray:adarray];
        self.adimageViewArray = [[NSMutableArray alloc]initWithCapacity:0];
        currentAdImageArray = [[NSMutableArray alloc]initWithCapacity:0];
        currentPage = 1;
        
        
        
        
         scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, frame.size.width, frame.size.height)];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [scrollView setBackgroundColor:[UIColor whiteColor]];
        [scrollView setUserInteractionEnabled:YES];
       
        //[scrollView setViewOrigin:CGPointMake(CGRectGetMinX(scrollView.frame),(kWindowHeight-CGRectGetHeight(scrollView.frame)-12)/2)];
        scrollView.delegate = self;
        [scrollView setPagingEnabled:YES];
        [scrollView setContentSize:CGSizeMake(frame.size.width * 3, frame.size.height)];
        [self addSubview:scrollView];
    
        [self createImageViews];
        [self updatescrollView];
        if (adarray.count !=1) {
           
            [self createPageControl];
        }
    }

    return self;
}



-(void)createPageControl{
    
    

    pageControl = [[UIPageControl alloc]init];
    pageControl.frame = CGRectMake(kWindowWidth - [adArray count]* 12-15 , CGRectGetHeight(self.frame)-15-8, [adArray count]* 12, 8);
    pageControl.numberOfPages = [adArray count];
    pageControl.currentPage = 0;
    
    [self addSubview:pageControl];

    
}




-(void)updatescrollView{

    if ([adArray count]>1) {
        [self refreshScrollView];
    }else if([adArray count]==1){
        
        [self addOneImage];
    }
}



/**
 @功能: 更新轮播图图片
 */
- (void)updateCycleView{


   
    [self.adimageViewArray removeAllObjects];
    [self createImageViews];
    [self updatescrollView];
}


/**
	@功能: 创建imageViews
 */
-(void)createImageViews
{
    for(NSInteger i=0 ;i<[adArray count];i++)
    {
        
        UIImageView * imageView = [[UIImageView alloc] init];
        [imageView setImage:[UIImage imageNamed:[adArray objectAtIndex:i]]];
        [imageView setUserInteractionEnabled:YES];
        [self.adimageViewArray addObject:imageView];
        imageView.tag = adTag+i;//设置图片的tag
    }
}
/**
	@功能: 只有一张图片
 */
-(void)addOneImage
{
    if ([self.adimageViewArray count]>=1) {
        
    }
    
    UIImageView * imageView = [self.adimageViewArray objectAtIndex:0];
    imageView.userInteractionEnabled = YES;
    imageView.tag= adTag;
    [imageView setFrame:CGRectMake(0,0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [scrollView setScrollEnabled:NO];
    [scrollView addSubview:imageView];

}

/**
 @功能: 更新轮播图
 */
-(void)refreshScrollView
{
    
    NSArray *subViews = [scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:currentPage];
    NSInteger index = 0;
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView * tempImageView = [currentAdImageArray objectAtIndex:i];
        
        UIImageView * imageView =[[UIImageView alloc]initWithImage:tempImageView.image];
        [imageView setUserInteractionEnabled:YES ];
        imageView.tag = tempImageView.tag;
        if (i == 1) {
            index = imageView.tag -adTag;
        }
        [imageView setFrame:CGRectMake(CGRectGetWidth(self.frame) * i,0,CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [scrollView addSubview:imageView];
    }
    
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame), 0)];
    pageControl.currentPage = index;
}





#pragma mark mark===***控制轮播广告动画（动画开始，动画结束，循环动画，手滑结束开启动画，手滑开始结束动画）*****==

/**
 @功能: 开始动画
 */
-(void)startAdAnimation

{
    
    self.adTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(cycleShow:) userInfo:nil repeats:NO];
}

//结束动画
-(void)stopAdAnimation
{
    
    [self.adTimer invalidate];
    [animationTimer invalidate];
    
    
}



//循环产生动画效果函数
- (void)cycleShow:(NSTimer * )aadTimer{
    
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame) *2, 0) animated:YES];
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(cycleShow:) userInfo:nil repeats:NO];
}

//手动滑动停止时开启动画
-(void)scrollViewDidEndDragging:(UIScrollView *)ascrollView willDecelerate:(BOOL)decelerate{
    
    [self startAdAnimation];
    
}

//手动滑动开始的时候 结束动画

- (void)scrollViewWillBeginDragging:(UIScrollView *)ascrollView{
    
    [self stopAdAnimation];
    
}


#pragma mark mark=======**********控制当前显示轮播图的数组（每次3个图片）为一组）*********==========

/**
	@功能: 获取当前的显示图片数组
	@参数: page 当前显示的一组照片（一组3个）
	@返回值: 当前轮播图数组
 */
- (NSArray *)getDisplayImagesWithCurpage:(int)page
 {
    
    NSInteger pre = [self validPageValue:currentPage-1];
    NSInteger last = [self validPageValue:currentPage+1];
    
    if([currentAdImageArray count] != 0) [currentAdImageArray removeAllObjects];
    [currentAdImageArray addObject:[adimageViewArray objectAtIndex:pre-1]];
    [currentAdImageArray addObject:[adimageViewArray objectAtIndex:currentPage-1]];
    [currentAdImageArray addObject:[adimageViewArray objectAtIndex:last-1]];
    
    return currentAdImageArray;
}

/**
	@功能: 获取图片的坐标（在一个循环内获取，一个循环从0开始到count结束）
	@参数: value  图片下标
	@返回值: 造成循环显示的图片下标（0，显示最后一个）
 */
- (NSInteger)validPageValue:(NSInteger)value
 {
    
    if(value == 0) value = [adArray count];               // value＝1为第一张，value = 0为前面一张
    if(value == [adArray count] + 1) value = 1;
    
    return value;
}

//控制刷新轮播图的效果
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
 {
    NSInteger x = aScrollView.contentOffset.x;
    // 水平滚动
    
        //正滑 往下翻一张（左边滑动）
        if(x >= (2*CGRectGetWidth(self.frame))) {
            currentPage = [self validPageValue:currentPage+1];
            [self refreshScrollView];
        }
     //倒滑 下一张（右边滑动）
        if(x <= 0) {
            
            currentPage = [self validPageValue:currentPage-1];

            [self refreshScrollView];
        }
    
    
}
//滑动结束，设置scrollview的位移

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
   

        [scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame)
                                                 , 0) animated:YES];
   
}


@end
