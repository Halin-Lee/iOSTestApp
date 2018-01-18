//
//  UserDefaultsConfiguration.m
//  Halin
//
//  Created by Halin on 4/5/16.
//  Copyright © 2016Halin. All rights reserved.
//

#import "UserDefaultsConfiguration.h"
#import "NSUserDefaults+Base.h"

@implementation UserDefaultsConfiguration

- (instancetype)initWithDefaultValue
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setup{
    [NSUserDefaults updateUserDefaults];
}


@end
