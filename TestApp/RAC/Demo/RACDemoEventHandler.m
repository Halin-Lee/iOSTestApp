//
//  RACDemoEventHandler.m
//  TestApp
//
//  Created by 17track on 8/16/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "RACDemoEventHandler.h"

@interface RACDemoEventHandler ()

@property (nonatomic,weak) RACDemoViewModel *viewModel;

@end

@implementation RACDemoEventHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setupWithViewModel:(RACDemoViewModel *)viewModel{
    
    self.viewModel = viewModel;

    [viewModel.signInCommand.executionSignals subscribeNext:^(id x) {
        NSLog(@"登录按钮点击 %@",x);
    }];
    
    [viewModel.emailSignal subscribeNext:^(id x) {
        NSLog(@"监听到文本改变 %@",x);
    }];
    
    @weakify(self)
    
    //email输入是否有效的信号
    RACSignal *emailValidSignal = [viewModel.emailSignal map:^id(id value) {
        @strongify(self)
        return @([self validInputValid:value]);
    }];
    
    //password输入是否有效的信号
    RACSignal *passwordValidSignal = [viewModel.passwordSignal map:^id(id value) {
        @strongify(self)
        return @([self validInputValid:value]);
    }];
    
    //按钮是否能点击的信号
    [[RACSignal combineLatest:@[emailValidSignal,passwordValidSignal] reduce:^id(NSNumber *left, NSNumber *right){
        return @(left.boolValue && right.boolValue);
    }] subscribeNext:^(NSNumber *x) {
        @strongify(self)
        [self.viewModel.inputValidSubject sendNext:x];
    }];

}

- (BOOL)validInputValid:(NSString *)input{
    return input && input.length > 6;
}

@end
