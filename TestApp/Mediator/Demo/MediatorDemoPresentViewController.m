//
//  MediatorDemoPresentViewController.m
//  TestApp
//
//  Created by Halin on 3/23/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "MediatorDemoPresentViewController.h"

#import "Mediator.h"
#import "MediatorDemoPushViewController.h"


@interface MediatorDemoPresentViewController ()

@end

@implementation MediatorDemoPresentViewController

- (void)receiveStartParam:(NSDictionary *)dictionary{
//    NSLog(@"收到启动参数 %@",dictionary);
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    for (UILabel *label in self.view.subviews) {
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [label addGestureRecognizer:gestureRecognizer];
        label.userInteractionEnabled = YES;
    }
    
}

- (void)tap:(UIGestureRecognizer *)gestureRecognizer{
    [self performSelector:NSSelectorFromString(((UILabel *)gestureRecognizer.view).text)];
}

- (void)popToRoot{
    [[Mediator sharedSingleton] popToViewController:NSClassFromString(@"MainViewController")];
}

- (void)pop{
    [[Mediator sharedSingleton] popWithParam:nil animated:YES];
}

- (void)push{
    UIViewController<ConfigurableViewControllerDelegate> *viewController = [[MediatorDemoPushViewController alloc] init];
    NSDictionary *param = @{@"from Controller":NSStringFromClass([self class])} ;
    [[Mediator sharedSingleton] presentViewController:viewController withParamDictionary:param animated:YES];
}


- (void)present{
    UIViewController<ConfigurableViewControllerDelegate> *viewController = [[MediatorDemoPresentViewController alloc] init];
    NSDictionary *param = @{@"from Controller":NSStringFromClass([self class])} ;
    [[Mediator sharedSingleton] presentViewController:viewController withParamDictionary:param animated:YES];
}


- (void)popToPush{
    [[Mediator sharedSingleton] popToViewController:NSClassFromString(@"MediatorDemoPushViewController")];
}


- (void)popToPresent{
    [[Mediator sharedSingleton] popToViewController:NSClassFromString(@"MediatorDemoPresentViewController")];
}


//返回时调用的回调
- (void)popWithParam:(NSDictionary *)dictionary{
    NSLog(@"收到返回参数 %@",dictionary);
}

- (ViewControllerPresentType)viewControllerPresentType{
    return ViewControllerPresentTypePresent;
}

@end
