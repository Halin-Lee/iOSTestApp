//
//  RouterFirstDemoViewController.m
//  TestApp
//
//  Created by halin on 3/24/16.
//  Copyright © 2016 me.halin. All rights reserved.
//


#import "RouterFirstDemoViewController.h"
#import "RouterSecondDemoViewController.h"
#import "ViewControllerRegister.h"

@interface RouterFirstDemoViewController ()

@end

@implementation RouterFirstDemoViewController


+ (void)load{
    
    [[ViewControllerRegister sharedSingleton] registerUrl:RouterFirstDemoUrl withViewControllerClassName:NSStringFromClass(self)];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.title = NSStringFromClass([self class]);
    for (UILabel *label in self.view.subviews) {
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [label addGestureRecognizer:gestureRecognizer];
        label.userInteractionEnabled = YES;
    }
    
}

- (void)tap:(UIGestureRecognizer *)gestureRecognizer{
    [self performSelector:NSSelectorFromString(((UILabel *)gestureRecognizer.view).text)];
}


- (void)openFirstUrl{
    NSString *className = NSStringFromClass([self class]);
    NSString *url = [NSString stringWithFormat:@"%@?fromController=%@&param=%@",RouterFirstDemoUrl,className,@"Hello"];
    [[ViewControllerRegister sharedSingleton] openUrl:url];
}


- (void)openSecondUrl{
    NSString *className = NSStringFromClass([self class]);
    NSString *url = [NSString stringWithFormat:@"%@?fromController=%@&param=%@",RouterSecondDemoUrl,className,@"Welcome"];
    [[ViewControllerRegister sharedSingleton] openUrl:url];
}


//指明ViewController展现方式
- (ViewControllerPresentType)viewControllerPresentType{
    return ViewControllerPresentTypePush;
}


//启动时带进来的参数
- (void)receiveStartParam:(NSDictionary *)dictionary{
    return NSLog(@"%@接收到参数%@",NSStringFromClass([self class]),dictionary);
}
@end
