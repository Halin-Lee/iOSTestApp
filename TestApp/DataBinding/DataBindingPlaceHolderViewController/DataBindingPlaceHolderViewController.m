//
//  DataBindingViewController.m
//  TestApp
//
//  Created by Halin on 11/10/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import "DataBindingPlaceHolderViewController.h"
#import <DataBindingLib.h>
#import "DataBindingPlaceHolderbTestModel.h"


@interface DataBindingPlaceHolderViewController()

@property (nonatomic,strong) DataBindingPlaceHolderbTestModel *testModel;

@end


@implementation DataBindingPlaceHolderViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    DataBindingPlaceHolderbTestModel *testModel = [[DataBindingPlaceHolderbTestModel alloc] init];
    [[DataBindingUtil dataBindingUtil] bindModel:testModel forView:self.view];
    
    testModel.string = @"test";
    self.testModel = testModel;
    

    UIGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:recognizer];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.testModel.string = @"123";
//        self.testModel = nil;
    });
    
}

- (void)tap{
    [self dismissViewControllerAnimated:YES completion:nil];

}




@end
