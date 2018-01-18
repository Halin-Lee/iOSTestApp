//
//  RACSubjectDemo.m
//  TestApp
//
//  Created by Halin on 3/17/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "RACSubjectDemo.h"
#import "ReactiveCocoa.h"

@implementation RACSubjectDemo

+ (void)test{

    RACSubject *subject = [RACSubject subject];
    
    
    NSLog(@"插入第一个subscribeNext订阅");
    [subject subscribeNext:^(id x) {
        NSLog(@"第一个subscribeNext接受到信号 %@",x);
    }];
    NSLog(@"第1次sendNext");
    [subject sendNext:@"第1次sendNext"];

    
    //订阅失败
    [subject subscribeError:^(NSError *error) {
        NSLog(@"第一个subscribeError订阅 %@",error);
    }];
    
    //订阅完成
    [subject subscribeCompleted:^{
        NSLog(@"第一个subscribeCompleted订阅");
    }];
    
    //订阅失败与完成
    [subject subscribeError:^(NSError *error) {
        NSLog(@"第二个subscribeError订阅 %@",error);
    } completed:^{
        NSLog(@"第二个subscribeCompleted订阅");
    }];
    
    
    NSLog(@"插入第二个subscribeNext订阅");
    //finally用法,fianlly得到的RACSingal必须被订阅(无论是成功,失败,还是next),才会在comleted,error时被调用,finally比自己的comleted,error慢
    [[subject finally:^{
        NSLog(@"第二个subscribeNext执行finally");
    }] subscribeNext:^(id x) {
        NSLog(@"第二个subscribeNext(finally)接收到信号 %@",x);
    }];
    
    [[subject finally:^{
        NSLog(@"第三个subscribeCompleted订阅finally");
    }] subscribeCompleted:^{
        NSLog(@"第三个subscribeCompleted订阅");
    }];
    
    [subject finally:^{
        NSLog(@"这个finally无法被调用");
    }];
    
    
    NSLog(@"插入第三个subscribeNext订阅");
    [subject subscribeNext:^(id x) {
        NSLog(@"第三个subscribeNext接受到信号 %@",x);
    }];
    
    
    //第三个Completed订阅的finally先执行再执行这里
    [subject subscribeCompleted:^{
        NSLog(@"第四个subscribeCompleted订阅");
    }];
    
    NSLog(@"第2次sendNext");
    [subject sendNext:@"第2次sendNext"];
    //Error与Completed只有一个能执行,注释掉这句,则sendCompleted不会被发送
//    [subject sendError:[NSError errorWithDomain:@"halin.me" code:-1 userInfo:nil]];
    //弃用subject
    [subject sendCompleted];
    //不会再被接受到
    [subject sendNext:@"第3次sendNext"];
    
  

}

@end
