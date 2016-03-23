//
//  RACSignalDemo.m
//  TestApp
//
//  Created by 17track on 3/17/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "RACSignalDemo.h"

#import "ReactiveCocoa.h"

@implementation RACSignalDemo

+ (void)test{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal 被订阅");
        
        
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号销毁");
        }];
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"第一个订阅接受到信号 %@",x);
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"第二个订阅接受到信号 %@",x);
    }];
    
    

}

@end
