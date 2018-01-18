//
//  Mediator.h
//  TestApp
//
//  Created by Halin on 3/22/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigurableViewControllerDelegate.h"

@interface Mediator : NSObject

+ (instancetype)sharedSingleton;

/**初始化方式*/
- (void)setupWithRootViewController:(UINavigationController *)rootController;


/**显示ViewController,具体怎么显示由viewControllerToPresent自行决定*/
- (void)presentViewControllerClass:(Class)viewControllerClass withParamDictionary:(NSDictionary *)dictionary animated:(BOOL)animated;

/**显示ViewController,具体怎么显示由viewControllerToPresent自行决定*/
- (void)presentViewController:(UIViewController<ConfigurableViewControllerDelegate>  *)viewControllerToPresent withParamDictionary:(NSDictionary *)dictionary animated:(BOOL)animated;

/**回退到上一个ViewController*/
- (void)popWithParam:(NSDictionary *)param animated:(BOOL)animated;

/**推到指定的ViewController*/
- (BOOL)popToViewController:(Class)viewControllerClass;

@end
