//
//  Logger.m
//  V5TrackDemo
//
//  Created by Halin on 7/9/15.
//  Copyright (c) 2015 Halin. All rights reserved.
//

#import "Logger.h"
#import "LogUtil.h"
#import "LogUtilTestIn.h"
#import "Singleton.h"


#pragma mark 日志标签
static NSString *const LOGGER_TAG = @"Logger";

@interface Logger()

/**日志工具*/
@property (nonatomic,strong) id<LogUtil> logUtil;

@property (nonatomic,assign) BOOL isDebug;

@end

@implementation Logger

SINGLETON_FOR_CLASS(Logger)
#pragma mark - 初始化
+ (void)setupWithLogUtil:(id<LogUtil>)logUtil isDebug:(BOOL)isDebug{
    Logger *logger = [self sharedSingleton];
    logger.logUtil = logUtil;
    logger.isDebug = isDebug;
    
    NSString *model;
    if (isDebug) {
        model = @"DEBUG";
    }else{
        model = @"RELEASE";
    }
    
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [Logger logWithTag:LOGGER_TAG format:@"日志工具初始化完成 模式:%@",model];
    
}

/**处理未知错误,需测试*/
void uncaughtExceptionHandler(NSException *exception){
    [Logger logEWithTag:@"程序崩溃" format:@"程序崩溃,堆栈:%@",[exception callStackSymbols]];
}

+ (BOOL)isDebug{
    return [[Logger sharedSingleton] isDebug];
}

#pragma mark - 日志打印



+ (void)logWithTag:(NSString *)tag format:(NSString *)format,...{
    //format string
    va_list args;
    va_start(args, format);
    NSString *event = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);


    NSString *message = [NSString stringWithFormat:@"%@ | %@",tag,event];
    Logger *logger = [Logger sharedSingleton];
    [logger.logUtil log:message];
    
    if (logger.isDebug) {
        //调试模式,打印日志
        NSLog(@"🔧%@",message);
    }
}


+ (void)logEWithTag:(NSString *)tag format:(NSString *)format,...{
    //format string
    va_list args;
    va_start(args, format);
    NSString *event = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    NSString *message = [NSString stringWithFormat:@"%@ | %@" ,tag,event];
    
    Logger *logger = [Logger sharedSingleton];
    [logger.logUtil logE:message];
    
    if (logger.isDebug) {
        //调试模式,打印日志
        NSLog(@"⚠️ %@",message);
    }
}


#pragma mark - 测量方法

+ (void)trackDimensionForIndex:(NSUInteger)index value:(NSString *)value{
    id logUtil = [Logger sharedSingleton].logUtil;
    if([logUtil conformsToProtocol:@protocol(MeasuringUtil)]){
        [logUtil trackDimensionForIndex:index value:value];
    }
}

+ (void)trackMetricForIndex:(NSUInteger)index value:(NSString *)value{
    id logUtil = [Logger sharedSingleton].logUtil;
    if([logUtil conformsToProtocol:@protocol(MeasuringUtil)]){
        [logUtil trackMetricForIndex:index value:value];
    }

}


+ (void)trackEventForCategory:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value{
    
    Logger *logger = [Logger sharedSingleton];
    id logUtil = logger.logUtil;
    if([logUtil conformsToProtocol:@protocol(MeasuringUtil)]){
        [logUtil trackEventForCategory:category action:action label:label value:value];
    }
    
    if (logger.isDebug) {
        //调试模式,打印日志
        NSLog(@"🔧 上传事件 类别:%@ 事件:%@ 标签:%@ 数值%@",category,action,label,value);
    }
    
}

+ (void)trackTimingForCategory:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value{
    
    Logger *logger = [Logger sharedSingleton];
    id logUtil = logger.logUtil;
    if([logUtil conformsToProtocol:@protocol(MeasuringUtil)]){
        [logUtil trackTimingForCategory:category action:action label:label value:value];
    }
    
    if (logger.isDebug) {
        //调试模式,打印日志
        NSLog(@"🔧 统计耗时 类别:%@ 事件:%@ 标签:%@ 数值%@",category,action,label,value);
    }
}


@end
