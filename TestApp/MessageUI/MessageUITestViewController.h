//
//  MessageUITestViewController.h
//  TestApp
//
//  Created by Halin on 9/15/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConfigurableViewControllerDelegate.h"
@interface MessageUITestViewController : UIViewController<ConfigurableViewControllerDelegate>


- (ViewControllerPresentType)viewControllerPresentType;
@end
