//
//  UIDevice+Addition.m
//  Halin
//
//  Created by Halin on 12/21/15.
//  Copyright © 2015 Halin. All rights reserved.
//

#import "UIDevice+Addition.h"
#import <sys/utsname.h>

@implementation UIDevice(Addition)

/**获得手机对应型号的*/
- (NSString *)iphoneModel{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    /**
     * 屏幕height
     * iPhone 6+ : 736
     * iPhone 6  : 667
     * iPhone 5s : 568
     * iPhone 5  : 568
     * iPhone 4s : 480
     */
    /*
    float screenHeight = [UIScreen mainScreen].bounds.size.height;\
    switch ((int)screenHeight) {
        case 480:
            
            return @"iPhone 4s";
        case 568:
            
            return @"iPhone 5";
        case 667:
            
            return @"iPhone 6";
        case 736:
            
            return @"iPhone 6P";
            
        default:
            return @"Unknown";

    }*/
}




@end
