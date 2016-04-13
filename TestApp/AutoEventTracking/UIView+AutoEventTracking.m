//
//  UIView+AutoEventTracking.m
//  TestApp
//
//  Created by 17track on 4/11/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "UIView+AutoEventTracking.h"
#import <objc/runtime.h>

@implementation UIView(AutoEventTracking)



- (NSString *)trackingID
{
    return objc_getAssociatedObject(self, @selector(trackingID)) ;
}

- (void)setTrackingID:(NSString *)trackingID
{
    objc_setAssociatedObject(self, @selector(trackingID), trackingID, OBJC_ASSOCIATION_COPY) ;
}


@end
