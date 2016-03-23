//
//  DataBindingViewController.h
//  TestApp
//
//  Created by Halin on 11/10/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConfigurableViewControllerDelegate.h"
/**PlaceHolderView与DataBinding联合使用的例子*/
@interface DataBindingPlaceHolderViewController : UIViewController<ConfigurableViewControllerDelegate>
- (ViewControllerPresentType)viewControllerPresentType;
@end
