//
//  NSError+Addition.m
//  Halin
//
//  Created by Halin on 12/23/15.
//  Copyright © 2015 Halin. All rights reserved.
//

#import "NSError+Addition.h"

@implementation NSError(Addition)

- (NSString *)description
{
    //修改NSError打印文本....避免中文乱码
    NSString *descriptionStr = [NSString stringWithCString:[self.userInfo.description cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return descriptionStr;
}

@end
