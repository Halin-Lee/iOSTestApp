//
//  AutoEventTracking.h
//  TestApp
//
//  Created by 17track on 4/11/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AutoEventTrackingDelegate.h"

@interface AutoEventTracking : NSObject<UIGestureRecognizerDelegate>

- (instancetype)initWithController:(UIViewController *)viewController delegate:(id<AutoEventTrackingDelegate>)delegate;

/**
 * 当前页面名称
 */
@property (nonatomic,copy) NSString *screenName;

/**
 * 页面名称前缀
 */
@property (nonatomic,copy) NSString *prefixString;

/**
 * 回调
 */
@property (nonatomic,strong) id<AutoEventTrackingDelegate> delegate;

@end
