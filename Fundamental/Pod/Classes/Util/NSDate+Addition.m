//
//  NSDate.m
//  Halin
//
//  Created by Halin on 15/9/10.
//  Copyright (c) 2015年Halin. All rights reserved.
//

#import "NSDate+Addition.h"
#import "Logger.h"


@implementation NSDate(Addition)

+ (NSDate *)dateWithServerTimeString:(NSString *)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];                //初始化时间格式转换
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];                           //设置时间 格式
    NSTimeZone* utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];         //设置时区
    [dateFormatter setTimeZone:utcTimeZone];
    NSLocale *usLocale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];         //设置地域
    [dateFormatter setLocale:usLocale];
    NSDate *outputDate = [dateFormatter dateFromString:dateStr];
    if (!outputDate) {
        [Logger logEWithTag:[[self class] description] format:@"服务器时间格式转换失败,str:%@ ,date:%@",dateStr ,outputDate];
    }
    return outputDate;                              //转换
}


- (NSString *)serverTimeString{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];            //初始化时间格式转换
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];                       //设置时间 格式
    NSLocale *usLocale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];     //设置地域
    [dateFormatter setLocale:usLocale];
    NSTimeZone* utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];     //设置时区
    [dateFormatter setTimeZone:utcTimeZone];
    NSString *serverTimeString = [dateFormatter stringFromDate:self];
    if (!serverTimeString) {
        [Logger logEWithTag:[[self class] description] format:@"服务器时间转文本转换失败,str:%@ ,date:%@",nil ,self];
    }
    
    if([serverTimeString hasPrefix:@"2079"] && ![serverTimeString isEqualToString:@"2079-01-01 00:00:00"]){
        
    }
    
    return serverTimeString;
}

@end
