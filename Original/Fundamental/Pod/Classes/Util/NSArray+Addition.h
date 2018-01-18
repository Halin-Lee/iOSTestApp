//
//  NSArray+Addition.h
//  Halin
//
//  Created by 毕志锋 on 15/7/22.
//  Copyright (c) 2015年Halin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(Addition)

/**
 *  将整数参数转化为nsnumber存入队列中
 *
 *  @param n1 想要存入的整数
 *
 *  @return 存入nsnumber的队列
 */
+ (id) arrayWithInts:(NSInteger) n1, ...;

/**
 *  将浮点数参数转化为nsnumber存入队列中
 *
 *  @param n1 想要存入的浮点数
 *
 *  @return 存入nsnumber的队列
 */
+ (id) arrayWithFloats:(CGFloat) n1, ...;


@end
