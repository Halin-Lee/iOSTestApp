//
//  MediatorPadDemoPushViewController.m
//  TestApp
//
//  Created by Halin Lee on 2/9/17.
//  Copyright © 2017 me.halin. All rights reserved.
//

#import "MediatorPadDemoPushViewController.h"
#import "MediatorPadDemoPresentViewController.h"
#import "Mediator.h"

@interface MediatorPadDemoPushViewController ()

@end

@implementation MediatorPadDemoPushViewController


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
    UIViewController<ConfigurableViewControllerDelegate> *viewController = [[MediatorPadDemoPushViewController alloc] init];
    NSDictionary *param = @{@"from Controller":NSStringFromClass([self class])} ;
    [[Mediator sharedSingleton] presentViewController:viewController withParamDictionary:param animated:YES];
}


- (void)present{
    UIViewController<ConfigurableViewControllerDelegate> *viewController = [[MediatorPadDemoPresentViewController alloc] init];
    NSDictionary *param = @{@"from Controller":NSStringFromClass([self class])} ;
    [[Mediator sharedSingleton] presentViewController:viewController withParamDictionary:param animated:YES];
}


- (void)popToPush{
    [[Mediator sharedSingleton] popToViewController:NSClassFromString(@"MediatorPadDemoPushViewController")];
}


- (void)popToPresent{
    [[Mediator sharedSingleton] popToViewController:NSClassFromString(@"MediatorPadDemoPresentViewController")];
}




//返回时调用的回调
- (void)popWithParam:(NSDictionary *)dictionary{
    NSLog(@"收到返回参数 %@",dictionary);
}

- (ViewControllerPresentType)viewControllerPresentType{
    return ViewControllerPresentTypePush;
}


@end
