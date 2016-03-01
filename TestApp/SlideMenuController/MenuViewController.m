//
//  MenuViewController.m
//  Demo
//
//  Created by 17track on 2/26/16.
//  Copyright © 2016 17track. All rights reserved.
//

#import "MenuViewController.h"
#import "SlideMenuRootViewController.h"

@implementation MenuViewController

- (void)selectViewControllerWithIdentifier:(NSString *)identifier{
    [((SlideMenuRootViewController *)self.parentViewController) selectViewControllerWithIdentifier:identifier animated:YES];
}


@end
