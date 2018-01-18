//
//  NSData+Addition.m
//  Halin
//
//  Created by Halin on 7/23/15.
//  Copyright (c) 2015 Halin. All rights reserved.
//

#import "NSData+Addition.h"

#import "CommonCrypto/CommonDigest.h"


@implementation NSData(Addition)

- (NSString *)hexadecimalString {
    const unsigned char *dataBuffer = (const unsigned char *)[self bytes];
    if (!dataBuffer) return [NSString string];
    
    NSUInteger          dataLength  = [self length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    
    return [NSString stringWithString:hexString];
}

/**
 生成data对应点md5
 @param data 为nil将返回@”“
 */
- (NSString *) md5{
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(self.bytes, (CC_LONG)self.length, md5Buffer);
    
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output =
    [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", md5Buffer[i]];
    
    return output;    
}

+ (BOOL)isEmpty:(NSData *)data{
    if (data) {
        if (data.length > 0) {
            return NO;
        }
    }
    return  YES;
}


+ (BOOL)isEqual:(NSData *)data1 withData:(NSData *)data2{
    if (!data1 && !data2) {
        //都不存在,返回YES;
        return YES;
    }else if(data1 && data2){
        //都存在,比较
        return [data1 isEqualToData:data2];
    }else{
        //一个存在一个不存在,返回NO;
        return NO;
    }

}

@end
