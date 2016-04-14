//
//  NSData+Addition.h
//  Halin
//
//  Created by Halin on 7/23/15.
//  Copyright (c) 2015 Halin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(Addition)

+ (BOOL)isEmpty:(NSData *)data;

/**比较data,都不存在返回YES*/
+ (BOOL)isEqual:(NSData *)data1 withData:(NSData *)data2;

/**返回16进制文本*/
- (NSString *)hexadecimalString;


- (NSString *)md5;

@end
