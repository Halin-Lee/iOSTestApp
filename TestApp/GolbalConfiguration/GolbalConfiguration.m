//
//  GolbalConfiguration.m
//  Pods
//
//  Created by Halin on 3/18/16.
//
//

#import "GolbalConfiguration.h"
#import "Logger.h"


@implementation GolbalConfiguration



SINGLETON_FOR_CLASS(GolbalConfiguration)

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
