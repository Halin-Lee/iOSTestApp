//
//  MediatorDemoPushViewController.m
//  TestApp
//
//  Created by 17track on 3/23/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "MediatorDemoPushViewController.h"
#import "Mediator.h"
#import "MediatorDemoPresentViewController.h"

@implementation MediatorDemoPushViewController

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
    [[Mediator shareInstance] popToViewController:NSClassFromString(@"MainViewController")];
}

- (void)pop{
    [[Mediator shareInstance] popWithParam:nil animated:YES];
}

- (void)push{
    UIViewController<ConfigurableViewControllerDelegate> *viewController = [[MediatorDemoPushViewController alloc] init];
    NSDictionary *param = @{@"from Controller":NSStringFromClass([self class])} ;
    [[Mediator shareInstance] presentViewController:viewController withParamDictionary:param animated:YES];
}


- (void)present{
    UIViewController<ConfigurableViewControllerDelegate> *viewController = [[MediatorDemoPresentViewController alloc] init];
    NSDictionary *param = @{@"from Controller":NSStringFromClass([self class])} ;
    [[Mediator shareInstance] presentViewController:viewController withParamDictionary:param animated:YES];
}


- (void)popToPush{
    [[Mediator shareInstance] popToViewController:NSClassFromString(@"MediatorDemoPushViewController")];
}


- (void)popToPresent{
    [[Mediator shareInstance] popToViewController:NSClassFromString(@"MediatorDemoPresentViewController")];
}




//返回时调用的回调
- (void)popWithParam:(NSDictionary *)dictionary{
    NSLog(@"收到返回参数 %@",dictionary);
}

- (ViewControllerPresentType)viewControllerPresentType{
    return ViewControllerPresentTypePush;
}
@end
