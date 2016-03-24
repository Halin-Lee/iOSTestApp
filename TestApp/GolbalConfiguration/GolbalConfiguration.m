//
//  GolbalConfiguration.m
//  Pods
//
//  Created by 17track on 3/18/16.
//
//

#import "GolbalConfiguration.h"

@implementation GolbalConfiguration

+ (instancetype)shareInstance{
    static GolbalConfiguration *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
//        _appGroupID = [self defaultAppGroupID];
//        _appFilePath = [self defaultFilePath];
        _moduleConfigurationFileName = @"SystemConfiguration";
    }
    return self;
}








@end
