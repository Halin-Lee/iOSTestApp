//
//  PPMainViewController.m
//  TestApp
//
//  Created by 17track on 2/5/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "PPMainViewController.h"
#import "PPPhoneFileBrowserViewController.h"

@interface PPMainViewController ()

@end

@implementation PPMainViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        PPPhoneFileBrowserViewController *ppPhoneFileBrowserViewController = [[PPPhoneFileBrowserViewController alloc] init];
        ppPhoneFileBrowserViewController.tabBarItem.title = @"文件浏览";
        
        [self addChildViewController:ppPhoneFileBrowserViewController];
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ViewControllerPresentType)viewControllerPresentType{
    return ViewControllerPresentTypePush;
}

@end
