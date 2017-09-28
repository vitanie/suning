//
//  UIImageView+Util.h
//  Happy
//
//  Created by chenhaojie on 15/8/1.
//  Copyright © 2015年 tsunami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Util)


/**
 *  功能:sdwebimage加载图片
 *
 *  参数: urlStr 图片网址
 */
-(void)loadImagechangeBlurryImageWithURLStr:(NSString*)urlStr;
/**
 *  功能:sdwebimage加载图片
 *
 *  参数: urlStr 图片网址
 */
-(void)loadImageWithURLStr:(NSString*)urlStr placeHolderImage:(UIImage*)image;
@end
