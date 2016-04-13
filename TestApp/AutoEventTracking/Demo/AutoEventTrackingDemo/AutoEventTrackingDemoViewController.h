//
//  AutoEventTrackingDemoViewController.h
//  TestApp
//
//  Created by 17track on 4/11/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigurableViewControllerDelegate.h"
#import "AutoEventTrackingDelegate.h"

@interface AutoEventTrackingDemoViewController : UIViewController<ConfigurableViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,AutoEventTrackingDelegate>

@end

