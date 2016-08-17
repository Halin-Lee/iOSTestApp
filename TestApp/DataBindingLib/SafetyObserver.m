//
//  SafetyObserver.m
//  TestApp
//
//  Created by 17track on 8/14/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "SafetyObserver.h"

@implementation SafetyObserver

- (instancetype)initWithModel:(id)model observer:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context{
    self = [super init];
    if (self) {
        _observer = observer;
        _weakModel = model;
        _assignModel = model;
        _keyPath = keyPath;
        //添加绑定
        [model addObserver:self forKeyPath:keyPath options:options context:context];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (_weakModel && _observer) {
        //监听对象以及回调目标都存在,调用
        [_observer observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    } else {
        //任何一个不存在了,解绑
        [self removeObserver];
    }
}


- (void)dealloc{
    [self removeObserver];
}

- (void)removeObserver{
    if (_assignModel) {
        @try {
            [_assignModel removeObserver:self forKeyPath:_keyPath];
        }@catch (NSException *exception) {
        }
        _assignModel = nil;
    }

}

@end
