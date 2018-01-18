//
//  SwitchHelper.h
//  Halin
//
//  Created by Halin on 15/9/10.
//  Copyright (c) 2015年Halin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, Switch2D)
{
    Switch2DBothFalse = 0,
    Switch2DBothTrue  = 3,
    Switch2DTrueFalse = 2,
    Switch2DFalseTrue = 1
};

@interface SwitchHelper : NSObject
+ (Switch2D) swtich2DWithFirst:(BOOL)first second:(BOOL)second;
@end
