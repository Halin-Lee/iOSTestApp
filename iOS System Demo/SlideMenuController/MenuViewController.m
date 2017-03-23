//
//  MenuViewController.m
//  Demo
//
//  Created by Halin on 2/26/16.
//  Copyright © 2016 Halin. All rights reserved.
//

#import "MenuViewController.h"
#import "SlideMenuRootViewController.h"

@implementation MenuViewController

- (void)selectViewControllerWithIdentifier:(NSString *)identifier{
    [((SlideMenuRootViewController *)self.parentViewController) selectViewControllerWithIdentifier:identifier animated:YES];
}


@end
