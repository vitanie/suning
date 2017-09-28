

#import "DJPageView.h"


#define   WIN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define   WIN_HEIGHT [[UIScreen mainScreen] bounds].size.heigh

@interface DJPageView ()<UIScrollViewDelegate>
{
    UIPageControl *pageControl;
}
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) UIPageControl *pageControl;
@property (nonatomic ,strong) NSTimer *timer;
@property (nonatomic ,copy)  void(^action)(NSInteger index );
@property (nonatomic ,assign) BOOL isWebImage;
@property (nonatomic, strong) NSArray * imageArray;

@end

@implementation DJPageView


-(instancetype)initPageViewFrame:(CGRect)frame webImageStr:(NSArray *)webimages didSelectPageViewAction:( void(^)(NSInteger index ))action
{
    self = [super initWithFrame:frame];
    if (self) {
        self.action = action;
        self.imageArray = webimages;
    }
    return self;
}
//手势点击
- (void)pageViewClick:(UITapGestureRecognizer *)tap
{
    if (self.action) {
        self.action(self.pageControl.currentPage);
    }
}


- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    [self setUpScrollView:imageArray];
    [self setUpImage:imageArray];
    [self setUpPageControl:imageArray];
    //保证不管先设置图片来源还是时间，都可以start
    [self.timer invalidate];
    [self startTimer];
}

-(void)setDuration:(NSTimeInterval)duration
{
    _duration = duration;
    [self.timer invalidate];
    [self startTimer];
}

/**
 *  设置scrollView
 */
-(void)setUpScrollView:(NSArray *)array
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageViewClick:)];
    [scrollView addGestureRecognizer:tapGesture];
    
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}

/**
 *  设置scrollView的内容图片：如果是网络图片的话就用SDWebImage加载，本地则直接设置
 *  暂时没想出其他方法。
 */
-(void)setUpImage:(NSArray *)array
{
    CGSize contentSize;
    CGPoint startPoint;
    NSLog(@"%d",_isWebImage);
    if (array.count > 1) {     //多张图片
        for (int i = 0 ; i < array.count + 2; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            [self.scrollView addSubview:imageView];
            if (i == 0) {
                [imageView setImageWithURL:[NSURL URLWithString:array[array.count - 1]]];
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:array[array.count - 1]]];
//                    UIImage *image =  [UIImage imageWithData:data];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (data) {
//                            imageView.image = image;
//                        }
//                        
//                    });
//                });
            }else if(i == array.count + 1){
                 [imageView setImageWithURL:[NSURL URLWithString:array[0]]];
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:array[0]]];
//                    UIImage *image =  [UIImage imageWithData:data];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        imageView.image = image;
//                    });
//                });
                
            }else{
                 [imageView setImageWithURL:[NSURL URLWithString:array[i - 1]]];
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:array[i - 1]]];
//                    UIImage *image =  [UIImage imageWithData:data];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        imageView.image = image;
//                    });
//                });
                
            }
            
            
            
            
            
            
            contentSize = CGSizeMake((array.count + 2) * self.frame.size.width,0);
            startPoint = CGPointMake(self.frame.size.width, 0);
        }
    }else{ //1张图片
        for (int i = 0; i < array.count; i ++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:array[i]]];
                UIImage *image =  [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = image;
                });
            });
            
            [self addSubview:imageView];
        }
        contentSize = CGSizeMake(self.frame.size.width, 0);
        startPoint = CGPointZero;
    }
    
    //开始的偏移量跟内容尺寸
    self.scrollView.contentOffset = startPoint;
    self.scrollView.contentSize = contentSize;
}


-(void)setUpPageControl:(NSArray *)array
{
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.superview.backgroundColor = [UIColor redColor];
    pageControl.numberOfPages = array.count;
    //默认是0
    pageControl.currentPage = 0;
    //自动计算大小尺寸
    CGSize pageSize = [pageControl sizeForNumberOfPages:array.count];
    
    
    
    pageControl.bounds = CGRectMake(0, 0, pageSize.width, 10);
    //pageControl.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height-pageControl.frame.size.height/2.0);
    
    [pageControl setViewX:CGRectGetWidth(self.frame) - pageSize.width - 10];
    [pageControl setViewY:CGRectGetHeight(self.frame) - 10];
    
    pageControl.backgroundColor = [UIColor clearColor];
    
    
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
   
    
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];

    [pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

-(void)pageChange:(UIPageControl *)page
{
    NSLog(@"%zd  & %f",page.currentPage,self.bounds.size.width);
    //获取当前页面的宽度
    CGFloat x = page.currentPage * self.bounds.size.width;
    //通过设置scrollView的偏移量来滚动图像
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

#pragma mark mark - Timer时间方法
-(void)startTimer
{
    if (!_duration) {
        self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }else{
        self.timer = [NSTimer timerWithTimeInterval:_duration target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)updateTimer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x  + CGRectGetWidth(self.scrollView.frame), 0);
    [self.scrollView setContentOffset:newOffset animated:YES];
}


#pragma mark mark - scrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.x < self.frame.size.width) {
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * (self.imageArray.count + 1), 0) animated:NO];
    }
    //偏移超过
    if (scrollView.contentOffset.x > self.frame.size.width * (self.imageArray.count + 1)) {
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    }
    int pageCount = scrollView.contentOffset.x / self.frame.size.width;
    
    if (pageCount > self.imageArray.count) {
        pageCount = 0;
    }else if (pageCount == 0){
        pageCount = (int)self.imageArray.count - 1;
    }else{
        pageCount--;
    }
    self.pageControl.currentPage = pageCount;
}
//停止滚动时
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}
//开始拖动时
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}
//结束拖动时
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}



- (void)setPageBackgroundColor:(UIColor *)pageBackgroundColor
{
    if (pageBackgroundColor) {
        pageControl.backgroundColor = pageBackgroundColor;
    }
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    if (pageIndicatorTintColor) {
        pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
    }
}
- (void)setCurrentPageColor:(UIColor *)currentPageColor
{
    if (currentPageColor) {
        pageControl.currentPageIndicatorTintColor = currentPageColor;
    }
}
@end
