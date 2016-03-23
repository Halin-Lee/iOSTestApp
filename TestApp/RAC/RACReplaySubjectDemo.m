//
//  RACReplaySubjectDemo.m
//  TestApp
//
//  Created by 17track on 3/17/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "RACReplaySubjectDemo.h"

#import "ReactiveCocoa.h"

@implementation RACReplaySubjectDemo
+ (void)test{
    
    /**ReplaySubject与Subject的最主要区别在于,RACReplaySubject在订阅时会将之前收到的所有信息重复一次*/
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    
    NSLog(@"插入第一个subscribeNext订阅");
    [subject subscribeNext:^(id x) {
        NSLog(@"第一个subscribeNext接受到信号 %@",x);
    }];
    
    
    NSLog(@"第1次sendNext");
    [subject sendNext:@"第1次sendNext"];
    
    NSLog(@"插入第二个subscribeNext订阅");
    //订阅next的时候能马上收到之前发出的1
    [subject subscribeNext:^(id x) {
        NSLog(@"第二个subscribeNext接受到信号 %@",x);
    }];
    
    [subject subscribeError:^(NSError *error) {
        NSLog(@"第一个subscribeError %@",error);
    }];
    
    
    NSLog(@"第2次sendNext");
    [subject sendNext:@"第2次sendNext"];
    
    NSLog(@"插入第三个subscribeNext订阅");
    //订阅的时候能马上收到之前发出的1,2   ,finally模块调用方式与subject相同
    [[subject finally:^{
        NSLog(@"第三个subscribeNext订阅finally");
    }] subscribeNext:^(id x) {
        NSLog(@"第三个subscribeNext(finally)接受到信号 %@",x);
    }];
    
    NSLog(@"sendCompleted/sendError");
    //    [subject sendError:[NSError errorWithDomain:@"halin.me" code:-1 userInfo:nil]];
    //弃用subject
    [subject sendCompleted];
    
    
    NSLog(@"第二个subscribeError,subscribeCompleted订阅");
    [subject subscribeError:^(NSError *error) {
        NSLog(@"第二个subscribeError %@",error);
    } completed:^{
        NSLog(@"第二个subscribeCompleted");
    }];


    //不会再被接受到
    [subject sendNext:@"第3次sendNext"];
}
@end
