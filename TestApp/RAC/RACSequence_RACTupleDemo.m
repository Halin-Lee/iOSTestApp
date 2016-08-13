//
//  RACSequence_RACTupleDemo.m
//  TestApp
//
//  Created by Halin on 3/18/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "RACSequence_RACTupleDemo.h"
#import "ReactiveCocoa.h"

@implementation RACSequence_RACTupleDemo

+ (void)test{
    NSMutableArray *numbers = [@[@1,@2,@3,@4] mutableCopy];
    
    //其实就是遍历数组...类似于replaySubject,他会把数组里面的所有内容按顺序subscribeNext,但调用完毕block就会移除,不再有用
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"numbers 收到rac_sequence 信号:%@",x);
    }];
    
    //上面的block不会因为加多个objcet就调用
    [numbers addObject:@5];

    
    

}

@end
