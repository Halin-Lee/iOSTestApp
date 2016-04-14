//
//  UIColor+Addition.m
//  Halin
//
//  Created by Halin on 15-5-12.
//  Copyright (c) 2015年 Halin All rights reserved.
//

#import "UIColor+Addition.h"

#import "Logger.h"

static NSString *const TAG = @"UIColor+Addition";


@implementation UIColor(Addition)


+ (UIColor *)colorWithR:(int)r G:(int)g B:(int)b{
    return [self colorWithR:r G:g B:b A:1.0];
}

+ (UIColor *)colorWithR:(int)r G:(int)g B:(int)b A:(int)a{
    return [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a];
}

+ (UIColor *)colorWithRGB:(NSUInteger )rgbValue{
    return  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0f green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0f blue:((float)(rgbValue & 0xFF)) / 255.0f alpha:1.0f];
}




+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    // String should be 6 or 8 characters
    if ([hexString length] < 6) {
        [Logger logEWithTag:TAG format:@"16进制颜色转换错误"];
        return [UIColor blackColor];
    }
    
    // 过滤掉 0X 或者 #
    if ([hexString hasPrefix:@"0x"]) hexString = [hexString substringFromIndex:2];
    if ([hexString hasPrefix:@"0X"]) hexString = [hexString substringFromIndex:2];
    if ([hexString hasPrefix:@"#"])  hexString = [hexString substringFromIndex:1];
    
    if ([hexString length] != 6) {
        [Logger logEWithTag:TAG format:@"16进制颜色转换错误,输入长度不对"];
        return [UIColor blackColor];
    }
    
    //转换为unsigned
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:0];
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xff0000) >> 16)/255.0 green:((rgbValue & 0xff00) >> 8)/255.0 blue:(rgbValue & 0xff)/255.0  alpha:alpha];
  
}

- (NSString *)hexString{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}
@end
