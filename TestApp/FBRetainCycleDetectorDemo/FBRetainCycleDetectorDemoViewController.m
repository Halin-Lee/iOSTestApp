//
//  FBRetainCycleDetectorDemoViewController.m
//  TestApp
//
//  Created by 17track on 4/15/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "FBRetainCycleDetectorDemoViewController.h"

#import <FBRetainCycleDetector/FBRetainCycleDetector.h>

@interface FBRetainCycleDetectorDemoViewController ()

@property (nonatomic,strong) NSSet *recycleRetainSet;


@end

@implementation FBRetainCycleDetectorDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self nssetRetainCycles];
    [self nssetRetainCycles2];
}





- (void)nssetRetainCycles{
    
    _recycleRetainSet = [NSSet setWithObject:self];
    
    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
    [detector addCandidate:self];
    NSSet *retainCycles = [detector findRetainCycles];
    NSLog(@"Recycle Retain Set %@", retainCycles);
    
}

- (void)nssetRetainCycles2{
    
    NSMutableSet *recycleRetainSet = [NSMutableSet set];
    _recycleRetainSet = [NSSet setWithObject:recycleRetainSet];
    [recycleRetainSet addObject:_recycleRetainSet];
    
    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
    [detector addCandidate:self];
    NSSet *retainCycles = [detector findRetainCycles];
    NSLog(@"Recycle Retain Set2 %@", retainCycles);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
