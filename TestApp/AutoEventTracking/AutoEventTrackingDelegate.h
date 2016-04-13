//
//  AutoEventTrackingDelegate.h
//  TestApp
//
//  Created by 17track on 4/12/16.
//  Copyright © 2016 me.halin. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "TrackEventItem.h"

@protocol AutoEventTrackingDelegate <NSObject>

- (void)onEventScreen:(NSString *)screen prefix:(NSString *)prefix trackEventItem:(TrackEventItem *)trackEventItem name:(NSString *)name;

@end
