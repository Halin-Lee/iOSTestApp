//
//  RACSignalDemo.m
//  TestApp
//
//  Created by Halin on 3/17/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "RACSignalDemo.h"

#import "ReactiveCocoa.h"


//示例:   https://www.raywenderlich.com/62699/reactivecocoa-tutorial-pt1
//中文版  http://www.cocoachina.com/ios/20150123/10994.html
@implementation RACSignalDemo

+ (void)test{
    
    NSLog(@"/*--------------测试1.RACSignal基本使用-------------------*/");
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal 被订阅");
        
        
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            //这里主要用于处理信号销毁时需要的操作
            NSLog(@"信号销毁");
        }];
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"第一个订阅接受到信号 %@",x);
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"第二个订阅接受到信号 %@",x);
    }];
    
    
    NSLog(@"/*--------------测试2.filer过滤-------------------*/");
    
    __block BOOL canPassed = YES;
    signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal 被订阅");
        
        
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号销毁");
        }];
    }] filter:^BOOL(id value) {
        return canPassed;
    }];
    
    //第一个信号没有被过滤
    [signal subscribeNext:^(id x) {
        NSLog(@"第一个订阅接受到信号 %@",x);
    }];
    
    //第二个信号被过滤
    canPassed = NO;
    [signal subscribeNext:^(id x) {
        NSLog(@"第二个订阅接受到信号 %@",x);
    }];
    
    NSLog(@"/*--------------测试3.map包装-------------------*/");
    
    signal = [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal 被订阅");
        
        
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号销毁");
        }];
    }] map:^id(NSNumber *value) {
        return @(value.integerValue * 2);
    }] filter:^BOOL(id value) {
        return YES;
    }];
    
    //next内容经过map包装
    [signal subscribeNext:^(id x) {
        NSLog(@"第一个订阅接受到信号 %@",x);
    }];
    
    
    
    NSLog(@"/*--------------测试3.RAC宏-------------------*/");
    
    RACSignalDemo *demo = [[RACSignalDemo alloc] init];
    demo.name = @"测试3.RAC宏";
    //demo的isRight对象等于Signal的返回值
    RAC(demo,isRight) =  [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal 被订阅");
        
        [subscriber sendNext:@3];
        //[subscriber sendNext:@(-3)];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号销毁");
        }];
    }] map:^id(NSNumber *value) {
        return @(value.integerValue > 0);
    }];
    NSLog(@"isRight? %@",demo.isRight ? @"YES" : @"NO");
    demo = nil;
    
    NSLog(@"/*---测试4.setKeyPath:onObject:nilValue:-------------------*/");
    
    signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal 被订阅");
        
//        [subscriber sendNext:@4];
        [subscriber sendNext:@(-4)];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号销毁");
        }];
    }] map:^id(NSNumber *value) {
        return @(value.integerValue > 0);
    }];
    
    demo = [[RACSignalDemo alloc] init];
    demo.name = @"测试4.setKeyPath:onObject:nilValue:";
    [signal setKeyPath:NSStringFromSelector(@selector(isRight)) onObject:demo nilValue:nil];
    
    NSLog(@"isRight? %@",demo.isRight ? @"YES" : @"NO");
    demo = nil;
    
    NSLog(@"/*---测试5.combine组合信号-------------------*/");
    
    RACSignal *leftSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal left 被订阅");
        
        [subscriber sendNext:@4];
        [subscriber sendNext:@3];
        [subscriber sendNext:@2];
        [subscriber sendNext:@1];
        
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号销毁");
        }];
    }];
    
    RACSignal *rightSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal right 被订阅");
        
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendNext:@3];
        [subscriber sendNext:@4];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号销毁");
        }];
    }];
    
    //合并信号
    //如果不指定reduce方式,则合并信号将用RACTuple的方式,返回,否则使用reduce返回
    RACSignal *combineSignal = [RACSignal combineLatest:@[leftSignal,rightSignal]];
//    RACSignal *combineSignal = [RACSignal combineLatest:@[leftSignal,rightSignal] reduce:^id(NSNumber *left, NSNumber *right){
//        return @(left.integerValue + right.integerValue > 3);
//    }];
    
    demo = [[RACSignalDemo alloc] init];
    @weakify(demo)
    [combineSignal subscribeNext:^(NSNumber *x) {
        @strongify(demo)
        demo.releaseTest = x;
        NSLog(@"combine信号收到信息 %@",x);
    } error:^(NSError *error) {
        NSLog(@"combine信号收到错误 %@",error);
    } completed:^{
        NSLog(@"combine信号收到完成");
    }];
    demo = nil;
    
    
    NSLog(@"/*---测试6.asynchronous异步-------------------*/");
    __block id<RACSubscriber> blockSubscriber;
    signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        blockSubscriber = subscriber;
        return nil;
    }];
    
    //因为subscribeNext每调用一次都会调用subscriber block,所以,下一个subscribeNext会覆盖掉blockSubscriber导致第一次订阅无效
    [signal subscribeNext:^(id x) {
        NSLog(@"第一个订阅接受到信号 %@",x);
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"第二个订阅接受到信号 %@",x);
    }];
    
    NSLog(@"开始发送信号");
    [blockSubscriber sendNext:@1];
    [blockSubscriber sendNext:@2];
    [blockSubscriber sendCompleted];
    
    
    NSLog(@"/*---测试6.flattenMap监听信号产生的信号-------------------*/");
   
    //flattenMap,相当于直接订阅次singal的结果
    signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"主 RACSignal 被订阅");
        
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"主信号销毁");
        }];
    }] flattenMap:^id(NSNumber *value) {
        return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"次 RACSignal 被订阅");
            blockSubscriber = subscriber;
            return nil;
        }] filter:^BOOL(NSNumber *value) {
            return value.integerValue > 0;
        }];
    }];
    
    
    [signal subscribeNext:^(id x) {
        NSLog(@"第一个订阅接受到信号 %@",x);
    }];
    
 
    
    NSLog(@"开始发送信号");
    //因为subscribeNext每调用一次都会调用subscriber block,所以,下一个subscribeNext会覆盖掉blockSubscriber导致第一次订阅无效
    [blockSubscriber sendNext:@3];
    [blockSubscriber sendNext:@4];
    [blockSubscriber sendCompleted];
    
    
    NSLog(@"/*---测试7.doNext边界影响-------------------*/");
    
    //doNext主要用户处理一个信号的附加操作,没有返回值,示例中,doNext和flattenMap合用,实现防止登录按钮多次点击的操作
    signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal 被订阅");
        blockSubscriber = subscriber;
        return nil;
    }] doNext:^(id x) {
        NSLog(@"接受到Next信号 %@",x);
    }] ;
    
    [signal subscribeNext:^(id x) {
        NSLog(@"第一个订阅接受到信号 %@",x);
    }];
    [blockSubscriber sendNext:@1];
    [blockSubscriber sendCompleted];

    
    NSLog(@"/*---测试8.then等待下一个-------------------*/");
    signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal 被订阅");
        [subscriber sendNext:@1];
        //只有第一个信号完成,下一个信号才会开始被监听,和flattenMap不同,flattenMap每次sendNext都会发送一次信号,then只在completed发生一次
        [subscriber sendCompleted];
        return nil;
    }] then:^RACSignal *{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"then RACSignal 被订阅");
            blockSubscriber = subscriber;
            return nil;
        }];
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"第一个订阅接受到信号 %@",x);
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"第二个订阅接受到信号 %@",x);
    }];
    
    [blockSubscriber sendNext:@2];
    [blockSubscriber sendCompleted];
    
    NSLog(@"/*---测试8.deleverOn事件触发线程-------------------*/");
    signal = [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal 被订阅");
        
        
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            //这里主要用于处理信号销毁时需要的操作
            NSLog(@"信号销毁是否在主线程:%@",[NSThread isMainThread] ? @"YES" : @"NO");
        }];
    }] doNext:^(id x) {
        NSLog(@"Next接受到信号 %@ 是否在主线程:%@",x,[NSThread isMainThread] ? @"YES" : @"NO");
    }] deliverOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityDefault]];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"第一个订阅接受到信号 %@ 是否在主线程:%@",x,[NSThread isMainThread] ? @"YES" : @"NO");
    }];
    
    
    
    //延迟0.5s
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.5, NO);
    
    NSLog(@"/*---测试8.subscribeOn事件订阅线程-------------------*/");
    
    signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal 被订阅 是否在主线程:%@",[NSThread isMainThread] ? @"YES" : @"NO");
        
        
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            //这里主要用于处理信号销毁时需要的操作
            NSLog(@"信号销毁是否在主线程:%@",[NSThread isMainThread] ? @"YES" : @"NO");
        }];
    }] subscribeOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityDefault]];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"第一个订阅接受到信号 %@",x);
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"第二个订阅接受到信号 %@",x);
    }];
    
    //延迟0.5s
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.5, NO);
    
    NSLog(@"/*---测试8.throttle节流阀-------------------*/");
    signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal 被订阅");
        
        
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            //这里主要用于处理信号销毁时需要的操作
            NSLog(@"信号销毁");
        }];
        //增加节流阀,0.5s内如果有其他信号进入,则忽略当前信号,处理下一个信号
    }] throttle:0.5];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"第一个订阅接受到信号 %@",x);
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"第二个订阅接受到信号 %@",x);
    }];
    
    NSLog(@"/*---测试9.RACObserve属性监听-------------------*/");
    demo = [[RACSignalDemo alloc] init];
    demo.name = @"测试9.RACObserve属性监听";
    [demo observeTest];
    demo = nil;
    
    NSLog(@"/*---测试10.merge合并信号-------------------*/");
    leftSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal left 被订阅");
        
        [subscriber sendNext:@4];
        [subscriber sendNext:@3];
        [subscriber sendNext:@2];
        [subscriber sendNext:@1];
        
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号销毁");
        }];
    }];
    
    rightSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal right 被订阅");
        
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendNext:@3];
        [subscriber sendNext:@4];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号销毁");
        }];
    }];
    
    //合并信号,和组合信号最大的区别为,combine 主要处理信号组合,通过组合得到另一个信息,而 merge 只是简单将两个信号合并在一起,其中任何一个的 next 调用,都会调用 merge 的 next,且内容和原信号一样
    RACSignal *mergeSignal = [RACSignal merge:@[leftSignal,rightSignal]];
    
    RACSignalDemo *mergeDemo = [[RACSignalDemo alloc] init];
    mergeDemo.name = @"测试10.merge";
    @weakify(mergeDemo)
    [mergeSignal subscribeNext:^(NSNumber *x) {
        @strongify(mergeDemo)
        mergeDemo.releaseTest = x;
        NSLog(@"merge信号收到信息 %@",x);
    } error:^(NSError *error) {
        NSLog(@"merge信号收到错误 %@",error);
    } completed:^{
        NSLog(@"merge信号收到完成");
    }];
    mergeDemo = nil;
    
    
    NSLog(@"/*---测试结束-------------------*/");
}

- (void)observeTest{
    [RACObserve(self, text) subscribeNext:^(id x) {
        NSLog(@"接受到信号 %@",x);
    }];
    self.text = @"RACObserve";
}

- (void)dealloc
{
    NSLog(@"RACSignalDemo %@ 回收",_name);
}

@end
