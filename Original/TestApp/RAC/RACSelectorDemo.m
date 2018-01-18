//
//  RACSelectorDemo.m
//  TestApp
//
//  Created by Halin Lee on 5/11/17.
//  Copyright © 2017 me.halin. All rights reserved.
//

#import "RACSelectorDemo.h"
#import "ReactiveCocoa.h"

@implementation RACSelectorDemo

+ (void)test{
    RACSelectorDemo *selectorDemo = [[RACSelectorDemo alloc] init];
    [[selectorDemo rac_signalForSelector:@selector(method:)] subscribeNext:^(RACTuple *tuple) {
        
        NSLog(@"method 监听执行");
        ((void (^)(NSObject *obj))tuple.first)(tuple);
        NSLog(@"method 监听完成");
    }];
    
    NSLog(@"method 调用");
    [selectorDemo method:^(NSObject *obj) {
        NSLog(@"block 调用 %@",obj);
    }];
    NSLog(@"method 调用完成");
}

- (void)method:(void (^)(NSObject *obj))block{
    NSLog(@"method 执行");
}

@end
