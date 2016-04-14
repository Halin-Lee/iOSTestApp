//
//  Mediator.m
//  TestApp
//
//  Created by Halin on 3/22/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "Mediator.h"

@interface Mediator()

@property (nonatomic,strong) NSMutableArray<UINavigationController *> *navigationStack;

@end

@implementation Mediator


+ (instancetype)sharedSingleton{
    static Mediator *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}


- (void)setupWithRootViewController:(UINavigationController *)rootController{

    if (_navigationStack) {
        NSLog(@"异常,Mediator已被初始化过");
        return;
    }
    
    _navigationStack = [NSMutableArray array];
    [_navigationStack addObject:rootController];
}


- (void)presentViewControllerClass:(Class)viewControllerClass withParamDictionary:(NSDictionary *)dictionary animated:(BOOL)animated{
    UIViewController<ConfigurableViewControllerDelegate> *viewController = [[viewControllerClass alloc] init];
    
    if (viewController) {
        [self presentViewController:viewController withParamDictionary:dictionary animated:animated];
    }
}

//使用delegate的方式,1.无法统一URL打开与页面跳转 2.页面耦合严重,每一个页面都依赖于与他相关的所有页面
- (void)presentViewController:(UIViewController<ConfigurableViewControllerDelegate>  *)viewControllerToPresent withParamDictionary:(NSDictionary *)dictionary animated:(BOOL)animated{
    
    //向viewControllerToPresent 写入参数
    if ([viewControllerToPresent respondsToSelector:@selector(receiveStartParam:)]) {
        [viewControllerToPresent receiveStartParam:dictionary];
    }

    
    switch (viewControllerToPresent.viewControllerPresentType) {
        case ViewControllerPresentTypePresent:{
            //子ViewController要求使用Present的方式展现,构造一个新的NavigationController,并present
            UINavigationController *newNav = [[UINavigationController alloc] initWithRootViewController:viewControllerToPresent];
            [_navigationStack.lastObject presentViewController:newNav animated:animated completion:nil];
            [_navigationStack addObject:newNav];
            break;
        }
            
            
            
        case ViewControllerPresentTypePush:
            //子ViewController要求使用Push的方式展现
        default:
            //默认以push方式显示
            [_navigationStack.lastObject pushViewController:viewControllerToPresent animated:animated];
            
            break;
    }
    

    //某些动画可能导致主线程睡眠(比如cell点击动画),所以这里要主动唤醒主线程
    //http://stackoverflow.com/questions/21075540/presentviewcontrolleranimatedyes-view-will-not-appear-until-user-taps-again
    CFRunLoopWakeUp(CFRunLoopGetCurrent());
}

- (void)popWithParam:(NSDictionary *)param animated:(BOOL)animated{
    UINavigationController *lastNav = _navigationStack.lastObject;
    if (lastNav.viewControllers.count == 1) {
        //在根目录,用dismiss
        [_navigationStack removeLastObject];
        [lastNav dismissViewControllerAnimated:animated completion:nil];
        
    }else{
        //不在根目录
        [lastNav popViewControllerAnimated:animated];
        
    }
    UIViewController<ConfigurableViewControllerDelegate> *lastViewController =(UIViewController<ConfigurableViewControllerDelegate> *)_navigationStack.lastObject.topViewController;
    //调用回调
    if ([lastViewController respondsToSelector:@selector(popWithParam:)]) {
        [lastViewController popWithParam:param];
    }
 

}



- (BOOL)popToViewController:(Class)viewControllerClass{
    

    //判断能否后腿
    BOOL canPopToViewController = NO;
    UINavigationController *popNav;
    
    for (UINavigationController *nav in _navigationStack.reverseObjectEnumerator) {
        for (UIViewController *viewController in nav.viewControllers.reverseObjectEnumerator) {
            if (viewController.class == viewControllerClass) {
                canPopToViewController = YES;
                popNav = nav;
                break;
            }
        }
        if (canPopToViewController) {
            break;
        }
    }
    
    
    if (!canPopToViewController) {
        //不能后退
        return NO;
    }
    
    //能回退,回退

    //先回退navigation
    BOOL needPop = NO;
    while (_navigationStack.lastObject != popNav) {
        needPop = YES;
        [_navigationStack removeLastObject];
    }
    if (needPop) {
        [popNav dismissViewControllerAnimated:NO completion:nil];
    }
    
    
    //pop,修改Navigation的ViewControllers,将需要pop走的ViewController移除
    UINavigationController *lastNav = _navigationStack.lastObject;
    NSMutableArray<UIViewController *> *viewControllers = [lastNav.viewControllers mutableCopy];
    for (UIViewController *viewController in viewControllers.reverseObjectEnumerator) {
        if (viewController.class == viewControllerClass) {
            break;
        }
        [viewControllers removeObject:viewController];
    }
    _navigationStack.lastObject.viewControllers = viewControllers;
    return YES;
}

@end
