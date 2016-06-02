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
#import "MediatorDemoLib.h"
#import "RouterFirstDemoViewController.h"
#import "AutoEventTrackingDemoViewController.h"
#import "FBRetainCycleDetectorDemoViewController.h"
#import "AccountStoreDemoViewController.h"
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
    
    NSString *mediatorDemoGroupName = @"Mediator Demo";
    [self addWithTestGroup:mediatorDemoGroupName name:@"Present Demo" clazz:[MediatorDemoPresentViewController class]];
    [self addWithTestGroup:mediatorDemoGroupName name:@"Push Demo" clazz:[MediatorDemoPushViewController class]];
    
    
    NSString *routerGroupName = @"Router Demo";
    [self addWithTestGroup:routerGroupName name:routerGroupName clazz:[RouterFirstDemoViewController class]];
    
    
    
    NSString *autoEventTrackingGroupName = @"Auto Event Tracking Demo";
    [self addWithTestGroup:autoEventTrackingGroupName name:autoEventTrackingGroupName clazz:[AutoEventTrackingDemoViewController class]];
    
    NSString *retainCycleDetectorGroupName = @"FB Retain Cycle Detector";
    [self addWithTestGroup:retainCycleDetectorGroupName name:retainCycleDetectorGroupName clazz:[FBRetainCycleDetectorDemoViewController class]];
    
    NSString *accountStoreGroupName = @"Account Store Demo";
    [self addWithTestGroup:accountStoreGroupName name:accountStoreGroupName clazz:[AccountStoreDemoViewController class]];
    
    return [_testArray copy];
}

- (void)addWithTestGroup:(NSString *)group name:(NSString *)name clazz:(Class)clazz{
    TestItem *item = [TestItem testItemWithTestGroup:group name:name clazz:clazz];
    [_testArray addObject:item];
}

@end
