//
//  RACDemoViewModel.h
//  TestApp
//
//  Created by 17track on 8/14/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"



#pragma mark - ViewModel

@interface RACDemoViewModel : NSObject

+ (instancetype)model;

@property (nonatomic,strong) RACCommand *signInCommand;

@property (nonatomic,strong) RACSignal *emailSignal;

@property (nonatomic,strong) RACSignal *passwordSignal;

@property (nonatomic,strong) RACSubject *inputValidSubject;


@end
