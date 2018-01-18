//
//  RACDemoViewModel.m
//  TestApp
//
//  Created by 17track on 8/14/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "RACDemoViewModel.h"
#import "DataBindingUtil.h"

@implementation RACDemoViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        _signInCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal empty];
        }];
        
        _inputValidSubject = [RACSubject subject];
        
    }
    return self;
}

- (void)dealloc{
    [[DataBindingUtil dataBindingUtil] unbindModel:self];
}

+ (instancetype)model{
    return [[self alloc] init];
}


@end

