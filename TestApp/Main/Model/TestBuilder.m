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
    
    NSString *messageUITestGroupName = @"MessageUI测试";
    [self addWithTestGroup:messageUITestGroupName name:messageUITestGroupName clazz:NSClassFromString(@"MessageUITestViewController")];
    
    
    NSString *dataBindingTestGroupName = @"DataBinding测试";
    [self addWithTestGroup:dataBindingTestGroupName name:dataBindingTestGroupName clazz:NSClassFromString(@"DataBindingPlaceHolderViewController")];
    
    NSString *ppTestGroupName = @"ProjectPrestudy";
    [self addWithTestGroup:ppTestGroupName name:ppTestGroupName clazz:NSClassFromString(@"PPMainViewController")];
    
    NSString *jsParchGroupName = @"JSPatch Demo";
    [self addWithTestGroup:jsParchGroupName name:jsParchGroupName clazz:NSClassFromString(@"JSPatchDemoViewController")];
    
    NSString *mediatorDemoGroupName = @"Mediator Demo";
    [self addWithTestGroup:mediatorDemoGroupName name:@"Present Demo" clazz:NSClassFromString(@"MediatorDemoPresentViewController")];
    [self addWithTestGroup:mediatorDemoGroupName name:@"Push Demo" clazz:NSClassFromString(@"MediatorDemoPushViewController")];
    
    
    NSString *routerGroupName = @"Router Demo";
    [self addWithTestGroup:routerGroupName name:routerGroupName clazz:NSClassFromString(@"RouterFirstDemoViewController")];
    
    
    
    NSString *autoEventTrackingGroupName = @"Auto Event Tracking Demo";
    [self addWithTestGroup:autoEventTrackingGroupName name:autoEventTrackingGroupName clazz:NSClassFromString(@"AutoEventTrackingDemoViewController")];
    
    NSString *retainCycleDetectorGroupName = @"FB Retain Cycle Detector";
    [self addWithTestGroup:retainCycleDetectorGroupName name:retainCycleDetectorGroupName clazz:NSClassFromString(@"FBRetainCycleDetectorDemoViewController")];
    
    NSString *accountStoreGroupName = @"Account Store Demo";
    [self addWithTestGroup:accountStoreGroupName name:accountStoreGroupName clazz:NSClassFromString(@"AccountStoreDemoViewController")];
    
    NSString *requestSimulatorGroupName = @"Request Simulator";
    [self addWithTestGroup:requestSimulatorGroupName name:requestSimulatorGroupName clazz:NSClassFromString(@"RequestSimulatorViewController")];
    
    NSString *racDemoGroupName = @"RAC Demo";
    [self addWithTestGroup:racDemoGroupName name:racDemoGroupName clazz:NSClassFromString(@"RACDemoViewController")];
    
    return [_testArray copy];
}

- (void)addWithTestGroup:(NSString *)group name:(NSString *)name clazz:(Class)clazz{
    TestItem *item = [TestItem testItemWithTestGroup:group name:name clazz:clazz];
    [_testArray addObject:item];
}

@end
