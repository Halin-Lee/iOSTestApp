//
//  RouterConfiguration.m
//  Pods
//
//  Created by Halin on 3/22/16.
//
//

#import "RouterConfiguration.h"
#import "Router.h"

@implementation RouterConfiguration


- (instancetype)initWithDefaultValue
{
    self = [super init];
    if (self) {
        _resourceName = @"RouterRule";
    }
    return self;
}

- (void)setup{
    NSString *path = [[NSBundle mainBundle] pathForResource:_resourceName ofType:@"xml"];
    [[Router sharedSingleton] setupWithResourcePath:path];
}
@end
