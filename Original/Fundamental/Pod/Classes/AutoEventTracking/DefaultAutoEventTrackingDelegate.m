//
//  DefaultAutoEventTrackingDelegate.m
//  TestApp
//
//  Created by Halin on 4/12/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "DefaultAutoEventTrackingDelegate.h"
#import "Logger.h"

@implementation DefaultAutoEventTrackingDelegate

- (void)onEventScreen:(NSString *)screen prefix:(NSString *)prefix trackEventItem:(TrackEventItem *)trackEventItem name:(NSString *)name{
    NSLog(@"页面:%@ %@ 事件:%@",screen,prefix,name);
}

@end
