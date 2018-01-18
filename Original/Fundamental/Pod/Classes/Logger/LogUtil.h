//
//  LogUtil.h
//  Halin
//
//  Created by Halin on 11/6/15.
//  Copyright © 2015 Halin. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LogUtil <NSObject>

/**打印日志*/
- (void)log:(NSString *)message;

/**打印错误日志*/
- (void)logE:(NSString *)message;

@end


@protocol MeasuringUtil <LogUtil>

/**用户维度跟踪*/
- (void)trackDimensionForIndex:(NSUInteger)index value:(NSString *)value;

/**用户测量跟踪*/
- (void)trackMetricForIndex:(NSUInteger)index value:(NSString *)value;

/**用户事件跟踪*/
- (void)trackEventForCategory:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value;

/**时间跟踪*/
- (void)trackTimingForCategory:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value;
@end