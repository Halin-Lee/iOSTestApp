//
//  LeftSideViewController.m
//  Demo
//
//  Created by Halin on 2/26/16.
//  Copyright © 2016 Halin. All rights reserved.
//

#import "LeftSideViewController.h"

@implementation LeftSideViewController


- (void)viewDidLoad{

    UITapGestureRecognizer *labelATapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(labelATap)];
    [self.vLabelA addGestureRecognizer:labelATapGestureRecognizer];
    self.vLabelA.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *labelBTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(labelBTap)];
    [self.vLabelB addGestureRecognizer:labelBTapGestureRecognizer];
    self.vLabelB.userInteractionEnabled = YES;
    
}


- (void)labelATap{
    [self selectViewControllerWithIdentifier:@"NavigationA"];
}


- (void)labelBTap{
    
    [self selectViewControllerWithIdentifier:@"NavigationB"];
}

@end
