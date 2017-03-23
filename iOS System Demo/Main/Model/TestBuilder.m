//
//  TestBuilder.m
//  TestApp
//
//  Created by Halin on 11/10/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import "TestBuilder.h"
#import "TestItem.h"


@interface TestBuilder ()

@property (nonatomic,strong) NSMutableArray *testArray;

@end

@implementation TestBuilder

- (instancetype)init
{
    self = [super init];
    if (self) {
        _testArray = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)build{
    
    NSString *photoGroupName = @"Photos 测试";
    [self addWithTestGroup:photoGroupName name:photoGroupName clazz:NSClassFromString(@"PhotosViewController")];
    
    
    return [_testArray copy];
}

- (void)addWithTestGroup:(NSString *)group name:(NSString *)name clazz:(Class)clazz{
    TestItem *item = [TestItem testItemWithTestGroup:group name:name clazz:clazz];
    [_testArray addObject:item];
}

@end
