//
//  SNNoData.h
//  suning
//
//  Created by Bai on 2017/9/25.
//  Copyright © 2017年 Bai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNNoData : UIView
+(SNNoData*)shard;
+(void)remove;
- (void)setnodataImage:(NSString *)imageStr;
@end
