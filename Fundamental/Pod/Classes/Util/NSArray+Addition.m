//
//  NSArray+Addition.m
//  Halin
//
//  Created by 毕志锋 on 15/7/22.
//  Copyright (c) 2015年Halin. All rights reserved.
//

#import "NSArray+Addition.h"
@implementation NSArray(Addition)

+ (id) arrayWithInts:(NSInteger) n1, ...{
    
    if (n1 == NSIntegerMax) {
        return [NSArray array];
    }
    
    va_list argList;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    NSNumber *num = [[NSNumber alloc] initWithInteger:n1];
    [arr addObject:num];
    
    
    va_start(argList,n1);
    NSInteger cur;
    while ((cur = va_arg(argList, NSInteger)) != NSIntegerMax ) {
        NSNumber *num = [[NSNumber alloc] initWithInteger:cur];
        [arr addObject:num];
        
    }
    
    va_end(argList);
    
    NSArray *retArr = [NSArray arrayWithArray:arr];
    
    return retArr;
}

+ (id) arrayWithFloats:(CGFloat) n1, ...{
    
    if (n1 == NSIntegerMax) {
        return [NSArray array];
    }
    
    va_list argList;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    NSNumber *num = [[NSNumber alloc] initWithFloat:n1];
    [arr addObject:num];
    
    
    va_start(argList,n1);
    NSInteger cur;
    while ((cur = va_arg(argList, NSInteger)) != NSIntegerMax ) {
        NSNumber *num = [[NSNumber alloc] initWithFloat:cur];
        [arr addObject:num];
        
    }
    
    va_end(argList);
    
    NSArray *retArr = [NSArray arrayWithArray:arr];
    
    return retArr;
}


@end
