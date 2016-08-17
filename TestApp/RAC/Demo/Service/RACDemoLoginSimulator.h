//
//  RACDemoLoginSimulator.h
//  TestApp
//
//  Created by 17track on 8/14/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RACDemoLoginSimulator : NSObject

- (void)loginWithEmail:(NSString *)email password:(NSString *)password callback:(void (^)(NSInteger state))callback;

@end
