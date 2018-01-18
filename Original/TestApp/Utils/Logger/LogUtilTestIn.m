//
//  LogUtilTestIn.m
//  Halin
//
//  Created by Halin on 11/6/15.
//  Copyright © 2015 Halin. All rights reserved.
//

#import "LogUtilTestIn.h"
// #import <TestinmAPM/TestinmAPM.h>

@implementation LogUtilTestIn

- (instancetype)initWithAppid:(NSString *)appid channel:(NSString *)appCHannel
{
    self = [super init];
    if (self) {
        //  [TestinmAPM init:appid channel:appCHannel config:[TestinConfig defaultConfig]];
    }
    return self;
}



/**testin日志*/
- (void)log:(NSString *)message{
    // [TestinmAPM leaveBreadcrumbWithString:message];
}

/**testin异常日志*/
- (void)logE:(NSString *)message{
    // [TestinmAPM reportCustomizedException:[NSException exceptionWithName:@"程序异常" reason:message userInfo:nil] message:message];
}

@end
