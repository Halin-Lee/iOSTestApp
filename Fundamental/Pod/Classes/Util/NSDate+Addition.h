//
//  NSDate.h
//  Halin
//
//  Created by Halin on 15/9/10.
//  Copyright (c) 2015年Halin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(Addition)

//FIXME:修改成带error抛出;
/**将时间文本转换为"yyyy-MM-dd'T'HH:mm:ss.SSS"格式的date*/
+ (NSDate *)dateWithServerTimeString:(NSString *)dateStr;

/**将date转换为"yyyy-MM-dd'T'HH:mm:ss.SSS"格式的文本*/
- (NSString *)serverTimeString;
@end
