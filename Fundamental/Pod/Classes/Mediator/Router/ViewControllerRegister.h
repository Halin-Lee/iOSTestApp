//
//  ViewControllerRegister.h
//  TestApp
//
//  Created by Halin on 3/24/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonMarco.h"

static NSString *const KOpenUrl = @"KOpenUrl";

@interface ViewControllerRegister : NSObject

SINGLETON_FOR_HEADER(ViewControllerRegister)


- (void)registerUrl:(NSString *)url withViewControllerClassName:(NSString *)className;

- (void)registerUrl:(NSString *)url;

- (BOOL)openUrl:(NSString *)url;

@end
