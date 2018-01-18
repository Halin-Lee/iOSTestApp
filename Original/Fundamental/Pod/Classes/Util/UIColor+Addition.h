//
//  UIColor+Addition.h
//  Halin
//
//  Created by Halin on 15-5-12.
//  Copyright (c) 2015年 Halin All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(Addition)



/**根据RGB颜色值获得颜色*/
+ (UIColor *)colorWithR:(int)r G:(int)g B:(int)b;

/**根据RGBA颜色值获得颜色*/
+ (UIColor *)colorWithR:(int)r G:(int)g B:(int)b A:(int)a;


//FIXME:使用Error方式调用
/**根据16进制颜色值获得颜色*/
+ (UIColor *)colorWithRGB:(NSUInteger )rgbValue;
/**根据16进制文本获得颜色*/
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

- (NSString *)hexString;

@end
