//
//  TestBuilder.m
//  TestApp
//
//  Created by Halin on 11/10/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import "TestBuilder.h"
#import "TestItem.h"
#import "MessageUITestViewController.h"
#import "DataBindingPlaceHolderViewController.h"
#import "PPMainViewController.h"
#import "JSPatchDemoViewController.h"

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
    
    NSString *messageUITestGroupName = @"MessageUI测试";
    [self addWithTestGroup:messageUITestGroupName name:messageUITestGroupName clazz:[MessageUITestViewController class]];
    
    
    NSString *dataBindingTestGroupName = @"DataBinding测试";
    [self addWithTestGroup:dataBindingTestGroupName name:dataBindingTestGroupName clazz:[DataBindingPlaceHolderViewController class]];
    
    NSString *ppTestGroupName = @"ProjectPrestudy";
    [self addWithTestGroup:ppTestGroupName name:ppTestGroupName clazz:[PPMainViewController class]];
    
    NSString *jsParchGroupName = @"JSPatch Demo";
    [self addWithTestGroup:jsParchGroupName name:jsParchGroupName clazz:[JSPatchDemoViewController class]];

    return [_testArray copy];
}

- (void)addWithTestGroup:(NSString *)group name:(NSString *)name clazz:(Class)clazz{
    TestItem *item = [TestItem testItemWithTestGroup:group name:name clazz:clazz];
    [_testArray addObject:item];
}

@end
