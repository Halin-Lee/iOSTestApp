//
//  LogUtilGoogle.m
//  Halin
//
//  Created by Halin on 11/6/15.
//  Copyright © 2015 Halin. All rights reserved.
//

#import "LogUtilGoogle.h"

#import "GAITracker.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@interface LogUtilGoogle()

@property(nonatomic,weak) GAI *gaiInstance;
/**跟踪器*/
@property(nonatomic,weak,readonly) id<GAITracker> tracker;
/**设备id*/
@property (nonatomic,copy) NSString *uuid;

@end

@implementation LogUtilGoogle


- (instancetype)initWithGAIID:(NSString *)GAIID
{
    self = [super init];
    if (self) {
        //初始化跟踪器
        self.gaiInstance = [GAI sharedInstance];
        self.gaiInstance.trackUncaughtExceptions = YES;                 //自动跟踪崩溃
        self.gaiInstance.dispatchInterval = 20;                         //发送间隔
        [[self.gaiInstance logger] setLogLevel:kGAILogLevelError];      //日志等级
        [self.gaiInstance trackerWithTrackingId:GAIID];                //设置跟踪id
        _tracker = [self.gaiInstance defaultTracker];                   //获得tracker
        
        //设置设备类型
        NSString *model = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ?@"iPad":@"iPhone";
        [self trackDimensionForIndex:1 value:model];
        
        self.uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    }
    return self;
}



/**谷歌日志*/
- (void)logE:(NSString *)message{
    NSString *logStr = [NSString stringWithFormat:@"%@ | %@",self.uuid,message];
    NSMutableDictionary *dict = [[GAIDictionaryBuilder  createExceptionWithDescription:logStr withFatal:@1] build];       //为事件设置自定义标签 (用户选择语言)
    [self.tracker send:dict];                                                                                            //发送事件
}



/**打印日志*/
- (void)log:(NSString *)message{
    //谷歌分析不打印普通级别日志
}

/**用户维度跟踪*/
- (void)trackDimensionForIndex:(NSUInteger)index value:(NSString *)value{
    [self.tracker set:value value:[GAIFields customDimensionForIndex:index]];
}

/**用户测量跟踪*/
- (void)trackMetricForIndex:(NSUInteger)index value:(NSString *)value{
    [self.tracker set:[GAIFields customMetricForIndex:index]
           value:value];
    
    [self.tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}


/**用户事件跟踪*/
- (void)trackEventForCategory:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value{
    NSDictionary *eventDict = [[GAIDictionaryBuilder createEventWithCategory:category action:action label:label value:value] build];
    [self.tracker send:eventDict];
}

/**时间跟踪*/
- (void)trackTimingForCategory:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value{
    NSDictionary *timingDict =[[GAIDictionaryBuilder createTimingWithCategory:category
                                                                    interval:value
                                                                        name:action
                                                                       label:label] build];
    [self.tracker send:timingDict];
}



@end
