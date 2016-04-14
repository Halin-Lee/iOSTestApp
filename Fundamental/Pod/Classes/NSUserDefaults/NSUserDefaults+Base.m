//
//  NSUserDefaults+Base.m
//  Pods
//
//  Created by Halin on 2/18/16.
//
//

#import "NSUserDefaults+Base.h"
#import "GlobalConfiguration.h"

static NSString *const USER_DEFAULTS_KEY_USER_LANGUAGE           = @"USER_DEFAULTS_KEY_USER_LANGUAGE";
static NSString *const USER_DEFAULTS_KEY_UID                     = @"USER_DEFAULTS_KEY_UID";
static NSString *const USER_DEFAULTS_KEY_WIDGET_LAST_REQUEST_TIME = @"USER_DEFAULTS_KEY_WIDGET_LAST_REQUEST_TIME";
static NSString *const USER_DEFAULTS_KEY_VERSION = @"USER_DEFAULTS_KEY_VERSION";

@implementation NSUserDefaults(Base)


- (NSString *)uid{
    return [self objectForKey:USER_DEFAULTS_KEY_UID];
}

- (void)setUid:(NSString *)uid{
    [self setObject:uid forKey:USER_DEFAULTS_KEY_UID];
    [self synchronize];
}


- (NSString *) userLanguage{
    return [self objectForKey:USER_DEFAULTS_KEY_USER_LANGUAGE];
}

- (void)setUserLanguage:(NSString *)userLanguage{
    [self setObject:userLanguage forKey:USER_DEFAULTS_KEY_USER_LANGUAGE];
    [self synchronize];
}

-(NSDate*)lastRequestTime{
    return [self objectForKey:USER_DEFAULTS_KEY_WIDGET_LAST_REQUEST_TIME];
}

-(void)setLastRequestTime:(NSDate *)lastRequestTime{
    [self setObject:lastRequestTime forKey:USER_DEFAULTS_KEY_WIDGET_LAST_REQUEST_TIME];
    [self synchronize];
}


+ (void)updateUserDefaults{
    

    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (self.version < 1) {
        //将standardUserDefaults的内容复制到halinUserDefaults
        NSUserDefaults *halinUserDefaults = [self halinUserDefaults];
        NSArray *keys = [standardUserDefaults.dictionaryRepresentation allKeys];
        NSArray *values = [standardUserDefaults.dictionaryRepresentation allValues];
        for (int i = 0; i < keys.count; i++) {
            id key = [keys objectAtIndex:i];
            id object = [values objectAtIndex:i];
            [halinUserDefaults setObject:object forKey:key];
        }
        [halinUserDefaults synchronize];
        //保存版本号
        standardUserDefaults.version = 1;
        halinUserDefaults.version = 1;
    }
}
- (void)setVersion:(NSInteger)version{

    [self setInteger:version forKey:USER_DEFAULTS_KEY_VERSION];
    [self synchronize];
}


- (NSInteger)version{
    NSNumber *guideState = [self objectForKey:USER_DEFAULTS_KEY_VERSION];
    if (!guideState) {
        return 0;
    }
    return guideState.integerValue;

}

+ (instancetype)halinUserDefaults{
    NSString *appGroupId = [GlobalConfiguration sharedSingleton].appGroupID;
    return [[NSUserDefaults alloc] initWithSuiteName:appGroupId];
}

@end
