//
//  RACSampleService.h
//  TestApp
//
//  Created by Halin Lee on 3/5/17.
//  Copyright © 2017 me.halin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonMarco.h"

@interface RACSampleService : NSObject
SINGLETON_FOR_HEADER(RACSampleService)

@property (assign,nonatomic) BOOL isTranslating ;
@property (assign,nonatomic) BOOL isTracking ;


- (void)trackWithNo:(NSString *)trackNo callback:(void (^)(NSString *result))callback;

- (void)translateWithResult:(NSString *)result callback:(void (^)(NSString *result))callback;
@end
