//
//  ViewBinder.m
//  TestApp
//
//  Created by Halin on 11/11/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import "ViewBinder.h"
#import "SafetyObserver.h"
#import "ReactiveCocoa.h"

@implementation ViewBinder

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fieldMethodDictionary = [NSMutableDictionary dictionary];
        _reverseFieldMethodDictionary = [NSMutableDictionary dictionary];
        _signalMethodDictionary = [NSMutableDictionary dictionary];
        _reverseSignalMethodDictionary = [NSMutableDictionary dictionary];
        _observers = [NSMutableArray array];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if (object == _model) {
        NSString *method = _fieldMethodDictionary[keyPath];
        //监听正常时调用setter
        //        [_view performSelector:NSSelectorFromString(method) withObject:[_assignModel valueForKey:keyPath]];
        [_view setValue:[_model valueForKey:keyPath] forKeyPath:method];
    } else if (object == _view) {
        NSString *method = _reverseFieldMethodDictionary[keyPath];
        //监听正常时调用setter
        //        [_view performSelector:NSSelectorFromString(method) withObject:[_assignModel valueForKey:keyPath]];
        [_model setValue:[_view valueForKey:keyPath] forKeyPath:method];
    }
    
    
}

- (void)bind:(id)model{
    if (_model) {
        //已经有model绑定,跳过
        return;
    }
    _model = model;
    NSArray *keys = [_fieldMethodDictionary allKeys];
    for (NSString *keyPath in keys) {
        //插入所有监听
        
        SafetyObserver *observer = [[SafetyObserver alloc] initWithModel:model observer:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
        [_observers addObject:observer];
        
        //将当前值写入
        NSString *method = _fieldMethodDictionary[keyPath];
        [_view setValue:[model valueForKeyPath:keyPath] forKeyPath:method];

    }
    
    keys = [_reverseFieldMethodDictionary allKeys];
    for (NSString *keyPath in keys) {
        //插入所有监听
        
        SafetyObserver *observer = [[SafetyObserver alloc] initWithModel:_view observer:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
        [_observers addObject:observer];
        
        //将当前值写入
        NSString *method = _reverseFieldMethodDictionary[keyPath];
        [model setValue:[_view valueForKeyPath:keyPath] forKeyPath:method];
        
    }
    
    keys = [_signalMethodDictionary allKeys];
    for (NSString *key in keys) {
        //插入所有监听
        NSString *method = _signalMethodDictionary[key];
        RACSignal *signal = [model valueForKeyPath:key];
        @weakify(self)
        [signal subscribeNext:^(id x) {
            @strongify(self)
            [self.view setValue:x forKeyPath:method];
        }];
    }
    
    keys = [_reverseSignalMethodDictionary allKeys];
    for (NSString *key in keys) {
        //插入所有监听
        NSString *method = _signalMethodDictionary[key];
        RACSignal *signal = [_view valueForKeyPath:key];
        @weakify(self)
        [signal subscribeNext:^(id x) {
            @strongify(self)
            [self.model setValue:x forKeyPath:method];
        }];
    }
}

- (void)unbind{
    //回收的时候移除所有监听
    [_observers removeAllObjects];
}


@end