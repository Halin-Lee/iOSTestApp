//
//  PPMainViewController.h
//  TestApp
//
//  Created by 17track on 2/5/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigurableViewControllerDelegate.h"

@interface PPMainViewController : UITabBarController<ConfigurableViewControllerDelegate>
- (ViewControllerPresentType)viewControllerPresentType;
@end
