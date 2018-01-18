
//
//  RACDemoService.m
//  TestApp
//
//  Created by Halin Lee on 6/3/17.
//  Copyright © 2017 me.halin. All rights reserved.
//

#import "RACDemoService.h"

@implementation RACDemoService

+ (instancetype)sharedSingleton{
    static RACDemoService *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        
        self.uploadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(RACTuple *tuple) {
            NSLog(@"RACCommand 执行 %@",tuple);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                BOOL isSucceed = ((NSNumber *)tuple.first).boolValue;
                NSTimeInterval duration = ((NSNumber *)tuple.second).doubleValue;
                
                NSDate *timeout = [NSDate dateWithTimeIntervalSinceNow:duration];
                
                //等待
                while( [[NSDate date] compare:timeout] == NSOrderedAscending){
                    //每秒检查一次,直到完成
                    CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1, NO);
                    double percentage = [[NSDate date] timeIntervalSinceDate:timeout] / duration;
                    [subscriber sendNext:@(percentage)];
                }
                
                if (isSucceed) {
                    [subscriber sendCompleted];
                } else {
                    [subscriber sendError:nil];
                }
                
                
                
                return nil;
            }];
        }];
    }
    return self;
}

@end


@implementation RACDemoServiceTestCase


+ (void)test{
    
    RACDemoService *service = [RACDemoService sharedSingleton];


    
    
    [service.uploadCommand execute:RACTuplePack(@(NO),@(10.0))];
    
    
//    [service.uploadCommand.executionSignals subscribeNext:^(RACSignal *signal) {
//        NSLog(@"executionSignals订阅接受到信号 %@",signal);
//        [signal subscribeNext:^(id x) {
//            NSLog(@"executionSignals信号接受到信号 %@",x);
//        } error:^(NSError *error) {
//            //错误信号会被内部捕捉掉,这个error不会被触发
//            NSLog(@"executionSignals信号接受到错误 %@",error);
//        } completed:^{
//            NSLog(@"executionSignals信号接受到完成");
//            [service.uploadCommand execute:RACTuplePack(@(YES),@(10.0))];
//        }];
//    }];

    
    [[service.uploadCommand.executionSignals takeLast:1]  subscribeNext:^(id x) {
        NSLog(@"executionSignals信号接受到信号 %@",x);
    } error:^(NSError *error) {
        //错误信号会被内部捕捉掉,这个error不会被触发
        NSLog(@"executionSignals信号接受到错误 %@",error);
    } completed:^{
        NSLog(@"executionSignals信号接受到完成");
        [service.uploadCommand execute:RACTuplePack(@(YES),@(10.0))];
    }];

    [[service.uploadCommand.executionSignals switchToLatest] subscribeNext:^(id x) {
        NSLog(@"executionSignals信号接受到信号 %@",x);
    } error:^(NSError *error) {
        //错误信号会被内部捕捉掉,这个error不会被触发
        NSLog(@"executionSignals信号接受到错误 %@",error);
    } completed:^{
        NSLog(@"executionSignals信号接受到完成");
        [service.uploadCommand execute:RACTuplePack(@(YES),@(10.0))];
    }];

}

@end



