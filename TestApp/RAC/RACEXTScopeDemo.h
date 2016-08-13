//
//  RACEXTScopeDemo.h
//  TestApp
//
//  Created by 17track on 8/11/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface RACEXTScopeDemo : NSObject

+ (void)test;

@property (nonatomic,assign) NSInteger count;

@property (nonatomic,copy) RACDisposable *(^block)(id<RACSubscriber> subscriber);

@end
