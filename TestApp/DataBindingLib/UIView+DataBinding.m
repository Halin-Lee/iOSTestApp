//
//  UIView+DataBinding.m
//  TestApp
//
//  Created by Halin on 11/10/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import "UIView+DataBinding.h"
#import "DataBindingUtil.h"
#import <objc/runtime.h>
@implementation UIView(DataBinding)

+ (void)load{
    Method overridedMethod = class_getInstanceMethod([UIView class], @selector(overridedSetValue:forKey:));
    Method originalMehtod = class_getInstanceMethod([UIView class], @selector(setValue:forKey:));
    method_exchangeImplementations(overridedMethod, originalMehtod);
}


- (void)overridedSetValue:(id)value forKey:(NSString *)key{
    
    //覆盖UIView原本的set事件,拦截BindMethod和BindType
    
    if (value && [value isKindOfClass:[NSString class]] &&[value hasPrefix:BIND_PATH]) {
        //绑定方法
        NSString *field = [value stringByReplacingOccurrencesOfString:BIND_PATH withString:@""];
        NSString *method = key;
        [[DataBindingUtil dataBindingUtil] addBindingField:field bindingMethod:method forView:self];
        
    } else if(value && [value isKindOfClass:[NSString class]] &&[value hasPrefix:REVERSE_BIND_PATH]){
        //绑定方法
        NSString *method = [value stringByReplacingOccurrencesOfString:REVERSE_BIND_PATH withString:@""];
        NSString *field = key;
        [[DataBindingUtil dataBindingUtil]  addReverseBindingField:field bindingMethod:method forView:self];
    
    } else if (value && [value isKindOfClass:[NSString class]] &&[value hasPrefix:BIND_SIGNAL]) {
        //绑定方法
        NSString *field = [value stringByReplacingOccurrencesOfString:BIND_SIGNAL withString:@""];
        NSString *method = key;
        [[DataBindingUtil dataBindingUtil] addBindingSignal:field bindingMethod:method forView:self];
        
    } else if(value && [value isKindOfClass:[NSString class]] &&[value hasPrefix:REVERSE_BIND_SIGNAL]){
        //绑定方法
        NSString *method = [value stringByReplacingOccurrencesOfString:REVERSE_BIND_SIGNAL withString:@""];
        NSString *field = key;
        [[DataBindingUtil dataBindingUtil]  addReverseBindingSignal:field bindingMethod:method forView:self];
        
    } else if([key isEqualToString:BIND_TYPE]){
        //设置绑定类型
        [[DataBindingUtil dataBindingUtil] addModelType:value forView:self];
        
    } else if([key isEqualToString:BIND_ID]){
        //设置绑定id
        [[DataBindingUtil dataBindingUtil] addModelIdentifier:value forView:self];
        
    } else {
        [self overridedSetValue:value forKey:key];
    }
    
}


@end


