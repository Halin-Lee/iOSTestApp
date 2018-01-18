//
//  RACEXTScopeDemo.m
//  TestApp
//
//  Created by 17track on 8/11/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "RACEXTScopeDemo.h"
#import "CommonMarco.h"

@implementation RACEXTScopeDemo


+ (void)test{
    
    RACEXTScopeDemo *demo = [[RACEXTScopeDemo alloc] init];
    [demo test];

}


- (void)test{
    _count = 0;
    
    @weakify(self)
    _block = ^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"RACSignal 被订阅");
        
        //通过使用@weakify @strongify 使得self可以回收
        @strongify(self)
        [subscriber sendNext:@(self.count)];
        self.count++;
        [subscriber sendNext:@(self.count)];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号销毁");
        }];
    };
    
    RACSignal *signal = [RACSignal createSignal:_block];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"第一个订阅接受到信号 %@",x);
    }];


}

- (void)dealloc
{
    NSLog(@"RACEXTScopeDemo 回收");
}


@end
