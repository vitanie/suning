

#import <UIKit/UIKit.h>

#define iPhone5Height 1096
#define iPhone5Width  640

#ifndef iphone6_Fix_Demo_GTCommontHeader_h
#define iphone6_Fix_Demo_GTCommontHeader_h

CG_INLINE CGFloat ICFixHeightFlaot(CGFloat height) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/iPhone5Height*2 < 1) {
        return height;
    }
    height = height*mainFrme.size.height/iPhone5Height*2;
    return height;
}
//下面这个对
CG_INLINE CGFloat ICReHeightFlaot(CGFloat height) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/iPhone5Height*2 < 1) {
        return height;
    }
    height = height* mainFrme.size.height*2 /iPhone5Height;
    return height;
}

CG_INLINE CGFloat ICFixWidthFlaot(CGFloat width) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/iPhone5Height*2 < 1) {
        return width;
    }
    width = width*mainFrme.size.width/iPhone5Width*2;
    return width;
}

CG_INLINE CGFloat ICReWidthFlaot(CGFloat width) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/iPhone5Height*2 < 1) {
        return width;
    }
    width = width*iPhone5Width/mainFrme.size.width/2;
    return width;
}

// 以iphone5屏幕为适配基础
CG_INLINE CGRect
ICRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x;
    rect.origin.y = y;
    rect.size.width  = width;//UZFixWidthFlaot(width);
    rect.size.height = height;//UZFixWidthFlaot(height);
    return rect;
}


#endif
