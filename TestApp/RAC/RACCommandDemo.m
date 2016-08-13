//
//  RACCommandDemo.m
//  TestApp
//
//  Created by 17track on 8/13/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "RACCommandDemo.h"
#import "ReactiveCocoa.h"

@implementation RACCommandDemo

+ (void)test{
    
    
    NSLog(@"/*--------------测试1.RACCommand基本使用-------------------*///");
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"RACCommand 执行 %@",input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"RACSignal 被订阅");
            [subscriber sendNext:@1];
            //同一时间只能有一个Command被触发,注释掉下面代码将导致第二个execute得到错误
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    //RACCommand所产生的Signal不需要被subscribe都会被订阅,使用不带subscribe也能使Signal被订阅
//    [command execute:@1]; 
    [[command execute:@1] subscribeNext:^(id x) {
        NSLog(@"第一个订阅接受到信号 %@",x);
    }];
    
    //禁止异步的情况下同一时间只能有一个Command被触发,注释掉下面代码将导致第二个execute得到错误,
//    [self wait];
//    command.allowsConcurrentExecution = YES;
    
    [[command execute:@2] subscribeNext:^(id x) {
        NSLog(@"第二个订阅接受到信号 %@",x);
    } error:^(id x) {
        NSLog(@"第二个订阅接受到错误 %@",x);
    } completed:^{
        NSLog(@"第二个订阅接受到完成");
    }];
    
    //RACCommand不是同步执行的,所以需要RunLoop等待才会执行
    [self wait];
    
    
    NSLog(@"/*--------------测试2.executionSignals------------------*///");

    command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"RACCommand 执行 %@",input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"RACSignal 被订阅");
            [subscriber sendNext:@1];
            [subscriber sendNext:@2];
            //错误信号会被内部捕捉掉,所以就算注释掉下面,抛出异常,executionSignals的监听也只会捕捉到完成(某些类型的error会在RACCommand的error里抛出,具体看4)
//            [subscriber sendError:[[NSError alloc] initWithDomain:@"me.halin" code:-1 userInfo:@{@"Error":@"Signal Error"}]];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    //command每次被有效执行将触发executionSignals
    [command.executionSignals subscribeNext:^(RACSignal *signal) {
        NSLog(@"executionSignals订阅接受到信号 %@",signal);
        [signal subscribeNext:^(id x) {
            NSLog(@"executionSignals信号接受到信号 %@",x);
        } error:^(NSError *error) {
            //错误信号会被内部捕捉掉,这个error不会被触发
            NSLog(@"executionSignals信号接受到错误 %@",error);
        } completed:^{
            NSLog(@"executionSignals信号接受到完成");
        }];
    }];
    
    NSLog(@"RACCommand 第一次execute");
    [command execute:@1];
    [self wait];
//    command.allowsConcurrentExecution = YES;
    
    NSLog(@"RACCommand 第二次execute");
    [command execute:@2];
    [self wait];
    
   
    NSLog(@"/*--------------测试3.executing------------------*///");
    __block id<RACSubscriber> blockSubscriber;
    command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"RACCommand 执行,生成一个信号");
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"RACSignal 被订阅");
            [subscriber sendNext:@1];
            blockSubscriber = subscriber;
            return nil;
        }];
    }];
    
    //判断command是否正在执行,订阅后会马上返回当前状态,当状态改变时会再发送信号
    [command.executing subscribeNext:^(NSNumber *x) {
        NSLog(@"第一个执行判断 信号是否在执行 %@",x.boolValue ? @"YES" : @"NO");
    }];
    
    NSLog(@"RACCommand execute");
    [command execute:nil];
   
   //等待,让execute生成信号,否则第一个执行判断将在一开始返回No(因为execute是异步的)
   [self wait];
   
   [command.executing subscribeNext:^(NSNumber *x) {
        NSLog(@"第二个执行判断 信号是否在执行 %@",x.boolValue ? @"YES" : @"NO");
    }];

    NSLog(@"Command生成的Signal执行完成");
   [blockSubscriber sendCompleted];
   [self wait];
    
   
    
    NSLog(@"/*--------------测试4.error------------------*///");
    command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"RACCommand 执行 %@",input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"RACSignal 被订阅");
            [subscriber sendNext:@1];
            [subscriber sendNext:@2];
            //错误信号会被Command.errors捕捉掉
            [subscriber sendError:[[NSError alloc] initWithDomain:@"me.halin" code:-1 userInfo:@{@"Error":@"Signal Error"}]];
            //            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    [command.errors subscribeNext:^(id x) {
        //error是由next监听到的(因为并不是errors发生了error)
        NSLog(@"errors信号接受到信号 %@",x);
    } error:^(NSError *error) {
        NSLog(@"errors信号接受到错误 %@",error);
    } completed:^{
        NSLog(@"errors信号接受到完成");
    }];
    
    
    NSLog(@"RACCommand 第一次execute");
    [command execute:@1];
    
    //Command.errors只会捕捉已发出的signal的error,对于无法执行的error不会捕捉
    NSLog(@"RACCommand 第二次execute");
    [[command execute:@2] subscribeError:^(NSError *error) {
        NSLog(@"RACCommand 第二次execute 抛出error %@",error);
    }];
    [self wait];
    
    
    NSLog(@"/*--------------测试5.enable------------------*///");
    command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"RACCommand 执行 %@",input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"RACSignal 被订阅");
            [subscriber sendNext:@1];
            [subscriber sendNext:@2];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    //注释掉下面代码,允许异步,则enabled不会变NO;
    command.allowsConcurrentExecution = YES;
    
    //其实这个信号相当于指示command是否被阻塞,禁止并发时,如果有command被执行则enabled为NO,不禁止并发则一直为YES
    [command.enabled subscribeNext:^(NSNumber *x) {
        NSLog(@"enabled信号接受到信号 %@",x.boolValue ? @"YES" : @"NO");
    } error:^(NSError *error) {
        NSLog(@"enabled信号接受到错误 %@",error);
    } completed:^{
        NSLog(@"enabled信号接受到完成");
    }];
    
    
    NSLog(@"RACCommand 第一次execute");
    [command execute:@1];
    [self wait];

    
 
    NSLog(@"/**///");
    NSLog(@"/*---测试结束-------------------*///");
    
}

+ (void)wait{
    NSLog(@" ");
    NSLog(@"RunLoop等待");
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1, NO);
    NSLog(@"RunLoop等待结束");
    NSLog(@" ");

}

@end
