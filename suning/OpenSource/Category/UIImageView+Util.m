//
//  UIImageView+Util.m
//  Happy
//
//  Created by chenhaojie on 15/8/1.
//  Copyright © 2015年 tsunami. All rights reserved.
//

#import "UIImageView+Util.h"
//#import "UIImageView+WebCache.h"
@implementation UIImageView (Util)
/**
 *  功能:sdwebimage加载图片
 *
 *  参数: urlStr 图片网址
 */
-(void)loadImagechangeBlurryImageWithURLStr:(NSString*)urlStr{


//    self.contentMode =  UIViewContentModeScaleAspectFill;
//    [self setClipsToBounds:YES];
//    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:kDefaultLoadImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//        self.alpha = 0.0;
//        [UIView transitionWithView:self
//                          duration:0.2
//                           options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//                               if (image) {
//                                   
//                                   UIImage* blurryImage  = [UIView blurryGPUImage:image withBlurLevel:5.0];
//                                   
//                                   [self setImage:blurryImage];
//                               }
//                               
//                               self.alpha = 1.0;
//                           } completion:^(BOOL finished) {
//                           }];
//    }];



}



/**
 *  功能:sdwebimage加载图片
 *
 *  参数: urlStr 图片网址
 */
-(void)loadImageWithURLStr:(NSString*)urlStr placeHolderImage:(UIImage*)placeHolderImage{

    
     [self setImage:placeHolderImage];
    
    if ([self isCacheImage:urlStr]) {
        
        self.image = [UIImage imageWithContentsOfFile:[self getImagePath:urlStr]];
        
    }else {
        [self downLoadImage:urlStr imageView:self];
        
    }
   
    
    


}



#pragma mark mark=========************图片下载和缓存***********===============


/**
 @功能: 缓存图片
 @参数: imageurl 图片名称
 @参数: imageData 缓存图片数据
 */
-(void)cacheimage:(NSString *)imageurl imageData:(NSData *)imageData{
    
    //将文件写入本地
    [imageData writeToFile:[self getImagePath:imageurl] atomically:YES];
}




//创建图片文件的路径
- (NSString *)getImagePath:(NSString *)imageUrl{
    
    //截取文件名
    NSString * fileName = [self getimageName:imageUrl];
    
    //拼接文件缓存地址
    NSString * filePath = [NSString stringWithFormat:@"%@/Library/Caches/%@",NSHomeDirectory(),fileName];
    return filePath;
    
}
//下载图片

-(void)downLoadImage:(NSString *)aurlStr  imageView:(UIImageView *)aimageView{
    
    __block NSString * urlStr = aurlStr;
    
    //使用gcd异步下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //request
        NSURL *url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"GET"];
        NSError * dataError = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&dataError];
        
        //下载成功之后将图片更新和缓存图片
        if (data ) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (aimageView) {
                    
                    UIImage* image = [UIImage imageWithData:data];
                    if ( image!=nil) {
                        
                        aimageView.alpha = 0;
                        [aimageView setImage:image];
                        [self cacheimage:aurlStr imageData:data];
                        [UIView animateWithDuration:0.5 animations:^{
                            
                            aimageView.alpha = 1;
                            
                            
                        }];
                        
                        
                        
                    }
                }
                
                
            });
            
        } else {
            
            return ;
        }
    });
    
}


//判断是否缓存了图片
-(BOOL)isCacheImage:(NSString *)imageUrl{
    
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:[self getImagePath:imageUrl]]){
        
        return YES;
    }
    
    
    return NO;
    
}

/**
	@功能: 获取图片名称
	@参数: imageURL 图片的相对路径
	@返回值: 图片名称
 */
- (NSString *)getimageName:(NSString *)imageURL
{
    
    
    return [[imageURL componentsSeparatedByString:@"/"]lastObject];
    
}







@end
