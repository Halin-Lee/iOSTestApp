//
//  Logger.h
//  V5TrackDemo
//
//  Created by Halin on 7/9/15.
//  Copyright (c) 2015 Halin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoggerConstant.h"

@protocol LogUtil ;
@interface Logger : NSObject

+ (BOOL)isDebug;

/**初始化*/
+ (void)setupWithLogUtil:(id<LogUtil>)logUtil isDebug:(BOOL)isDebug;

/**打印日志*/
+ (void)logWithTag:(NSString *)tag format:(NSString *)format,... NS_FORMAT_FUNCTION(2,3);

/**打印错误日志*/
+ (void)logEWithTag:(NSString *)tag format:(NSString *)format,...  NS_FORMAT_FUNCTION(2,3);

/**用户维度跟踪*/
+ (void)trackDimensionForIndex:(NSUInteger)index value:(NSString *)value;

/**用户测量跟踪*/
+ (void)trackMetricForIndex:(NSUInteger)index value:(NSString *)value;

/**用户事件跟踪*/
+ (void)trackEventForCategory:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value;

/**用户耗时跟踪*/
+ (void)trackTimingForCategory:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value;

@end
