//
//  RequestSimulatorViewModel.m
//  TestApp
//
//  Created by 17track on 8/2/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "RequestSimulatorViewModel.h"
#import "DataBindingUtil.h"


@implementation RequestSimulatorViewModel

- (void)dealloc{
    [[DataBindingUtil dataBindingUtil] unbindModel:self];
}

- (void)setMethod:(RequestMethod)method{
    [self willChangeValueForKey:NSStringFromSelector(@selector(method))];
    [self willChangeValueForKey:NSStringFromSelector(@selector(isGet))];
    [self willChangeValueForKey:NSStringFromSelector(@selector(isPost))];
    _method = method;
    
    [self didChangeValueForKey:NSStringFromSelector(@selector(method))];
    [self didChangeValueForKey:NSStringFromSelector(@selector(isGet))];
    [self didChangeValueForKey:NSStringFromSelector(@selector(isPost))];
}

- (BOOL)isGet{
    return _method == RequestMethodGet;
}

- (BOOL)isPost{
    return _method == RequestMethodPost;
}

@end
