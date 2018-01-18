//
//  JSPatchDemoViewController.m
//  TestApp
//
//  Created by Halin on 3/8/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "JSPatchDemoViewController.h"

@interface JSPatchDemoViewController  ()


@end

@implementation JSPatchDemoViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"我就干瞪着,什么事都不做");

}
- (void)tap{
    
//    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"我就干瞪着,什么事都不做");
    
}

- (ViewControllerPresentType)viewControllerPresentType{
    return ViewControllerPresentTypePush;
}
@end
