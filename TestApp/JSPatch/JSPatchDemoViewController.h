//
//  JSPatchDemoViewController.h
//  TestApp
//
//  Created by Halin on 3/8/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigurableViewControllerDelegate.h"

@interface JSPatchDemoViewController : UIViewController<ConfigurableViewControllerDelegate>
- (ViewControllerPresentType)viewControllerPresentType;
@end
