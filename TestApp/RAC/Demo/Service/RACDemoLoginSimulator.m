//
//  RACDemoLoginSimulator.m
//  TestApp
//
//  Created by 17track on 8/14/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "RACDemoLoginSimulator.h"

@implementation RACDemoLoginSimulator

- (void)loginWithEmail:(NSString *)email password:(NSString *)password callback:(void (^)(NSInteger state))callback{
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        callback(0);
    });

}

@end
