//
//  Assist.h
//  UZLottery
//
//  Created by chenhaojie on 15/10/26.
//  Copyright © 2015年 kevin. All rights reserved.
//


UIImageView * createImageViewforImage(id parents,int tag,CGRect rect, UIImage * strImageName)
;
UIView * createView(id parents,int tag,CGRect rect,UIColor * backColor);

UILabel * createLabelWithAgu(id parents,NSInteger tag,CGRect rect, NSString * strTitle, UIColor * TextColor,UIFont * textFont,UITextAlignment Alignment)
;

UITextField * createTextFiled(id parents,int tag,CGRect rect,id delegate,NSString * strtext,NSString *strplaceholder,UITextAlignment textAlignment);

/**
 *  功能:获取图片
 *
 *  参数: colorStr颜色
 *
 *  返回值:返回图片
 */
UIImage * getColorImage(UIColor *colorStr);
/*
 * 功能:获取一段字符串的占用的宽度及高度
 */
CGSize getStringSize(NSString *str,float witdh,float height,UIFont *font);

NSString* getResolution();


NSString* getJKCLogicCode(NSString* saleId);
