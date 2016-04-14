//
//  ViewControllerRegister.m
//  TestApp
//
//  Created by Halin on 3/24/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "ViewControllerRegister.h"
#import "Mediator.h"

@interface ViewControllerRegister ()

@property (nonatomic,strong) NSMutableDictionary *urlDictionary;

@end


@implementation ViewControllerRegister

SINGLETON_FOR_CLASS(ViewControllerRegister)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _urlDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}


- (void)registerUrl:(NSString *)url withViewControllerClassName:(NSString *)className{
    _urlDictionary[url] = className;
}

- (void)registerUrl:(NSString *)url{
    [_urlDictionary removeObjectForKey:url];
}

- (BOOL)openUrl:(NSString *)url{
    NSArray *parts = [url componentsSeparatedByString:@"?"];
    NSString *path = parts[0];
    Class viewControllerClass = NSClassFromString(_urlDictionary[path]);
    
    if (!viewControllerClass) {
        return NO;
    }
    
    [[Mediator sharedSingleton] presentViewControllerClass:viewControllerClass withParamDictionary:@{KOpenUrl:url} animated:YES];
    
    
    return YES;
    
}




@end
