//
//  SafetyObserver.h
//  TestApp
//
//  Created by 17track on 8/14/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SafetyObserver : NSObject

@property (nonatomic,weak,readonly) id weakModel;

@property (nonatomic,assign,readonly) id assignModel;

@property (nonatomic,weak,readonly) id observer;

@property (nonatomic,copy,readonly) NSString *keyPath;


- (instancetype)initWithModel:(id)model observer:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

- (void)removeObserver;

@end
