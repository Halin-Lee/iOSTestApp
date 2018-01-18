//
//  RACDemoViewController.m
//  TestApp
//
//  Created by 17track on 8/14/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "RACDemoViewController.h"
#import "RACDemoViewModel.h"
#import "RACDemoEventHandler.h"
#import "DataBindingUtil.h"


@interface RACDemoViewController ()

@property (nonatomic,strong) RACDemoViewModel *viewModel;
@property (nonatomic,strong) RACDemoEventHandler *eventHandler;

@end

@implementation RACDemoViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.viewModel = [RACDemoViewModel model];
    
    [[DataBindingUtil dataBindingUtil] bindModel:_viewModel forView:self.view];
    
    self.eventHandler = [[RACDemoEventHandler alloc] init];
    [self.eventHandler setupWithViewModel:self.viewModel];
    
    
    //处理输入框有效无效事件
    [self.viewModel.inputValidSubject subscribeNext:^(NSNumber *x) {
        if (x.boolValue) {
            self.vSubmitButton.backgroundColor = [UIColor whiteColor];
            self.vSubmitButton.enabled = YES;
        } else {
            self.vSubmitButton.backgroundColor = [UIColor grayColor];
            self.vSubmitButton.enabled = NO;
        }
    }];
    
    [self.viewModel.signInCommand.executing subscribeNext:^(id x) {
        
    }];
    
    
    
}





@end
