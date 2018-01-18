//
//  LoggerInitialization.m
//  Pods
//
//  Created by Halin on 3/18/16.
//
//

#import "LoggerConfiguration.h"
#import "LogUtilTestIn.h"
#import "LogUtilGoogle.h"
#import "LogUtil.h"
#import "Logger.h"
@implementation LoggerConfiguration

- (instancetype)initWithDefaultValue
{
    self = [super init];
    if (self) {
        _isDebug = YES;
    }
    return self;
}



- (void)setup{
    
    NSString * appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    BOOL lockRelease = appBuildString.intValue%100>=80?YES:NO;
    id<LogUtil> logUtil;
    if (self.isDebug && lockRelease == NO) {
        logUtil = [[LogUtilTestIn alloc] initWithAppid:self.appID channel:self.appChannel];
    }else{
        logUtil = [[LogUtilGoogle alloc] initWithGAIID:self.gaiID];
    }
    [Logger setupWithLogUtil:logUtil isDebug:self.isDebug];
    

    if (lockRelease) {
        NSLog(@"锁定Release模式");
    }
    
}


@end
