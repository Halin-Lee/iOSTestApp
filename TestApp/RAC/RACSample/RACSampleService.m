//
//  RACSampleService.m
//  TestApp
//
//  Created by Halin Lee on 3/5/17.
//  Copyright © 2017 me.halin. All rights reserved.
//

#import "RACSampleService.h"

@interface RACSampleService ()


@property (copy,nonatomic) void (^translateCallback)(NSString *result) ;
@property (copy,nonatomic) void (^trackCallback)(NSString *result) ;

@end

@implementation RACSampleService

SINGLETON_FOR_CLASS(RACSampleService)



- (void)trackWithNo:(NSString *)trackNo callback:(void (^)(NSString *result))callback{
    _trackCallback = callback;
    _isTracking = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _isTracking = NO;
        if (_trackCallback) {
            _trackCallback(@"Track Result");
        }
    });

}

- (void)translateWithResult:(NSString *)result callback:(void (^)(NSString *result))callback{

    _translateCallback = callback;
    _isTranslating = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _isTranslating = NO;
        if (_translateCallback) {
            _translateCallback(@"Translate Result");
        }
    });

}

@end
