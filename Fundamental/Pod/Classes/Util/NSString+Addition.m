//
//  NSString+Addition.m
//  Halin
//
//  Created by Halin on 15-5-11.
//  Copyright (c) 2015年 Halin All rights reserved.
//

#import "NSString+Addition.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString(Addition)


+ (NSString *)convertToIconTextWithHexString:(NSString *)hexStr{

    if (!hexStr) {
        return @"";
    }
    //1.将json中的iconText 转换成16进制
    unsigned long hex = strtoul([hexStr UTF8String], 0, 16);
    //2.将16进制强制转换成unsigned short
    unichar ll = hex;
    
    //3.在转成NSString
    return [[NSString alloc] initWithCharacters:&ll length:1];

}


+ (BOOL)isEmpty:(NSString *)string{
    if (string) {
        if (string.length >0) {
            return NO;
        }
    }
    return  YES;
}


- (BOOL)isStringOnlyContainCharacters:(NSString *)characters{
    NSCharacterSet *cs = [NSCharacterSet characterSetWithCharactersInString:characters];
    NSCharacterSet *allowedCharacters = [cs invertedSet];
    return ([self rangeOfCharacterFromSet:allowedCharacters].location == NSNotFound);
}

- (NSString *)trimWithoutCharacters:(NSString *)characters{
    NSCharacterSet *cs = [NSCharacterSet characterSetWithCharactersInString:characters];
    NSCharacterSet *allowedCharacters = [cs invertedSet];
    return [self stringByTrimmingCharactersInSet:allowedCharacters];
}

- (NSString *)stringByReplacingFirstOccurrencesOfString:(NSString *)target withString:(NSString *)replacement{

    NSRange rOriginal = [self rangeOfString: target];
    if (NSNotFound != rOriginal.location) {
        return [self stringByReplacingCharactersInRange:rOriginal withString:replacement];
    }
    return self;
}

- (NSString *)stringByReplacingCharacterSet:(NSCharacterSet *)characters{
   return [[self componentsSeparatedByCharactersInSet:characters] componentsJoinedByString:@""];
}

- (NSString *)md5 {
    // Create pointer to the string as UTF8
    const char *ptr = [self UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 bytes MD5 hash value, store in buffer
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output =
    [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", md5Buffer[i]];
    
    return [output uppercaseString];
    
}

+(NSString*)transformDateToString:(NSDate*)date{
    NSString *result = @"";
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *transformCmps = [calendar components:unit fromDate:date];
    
    
    NSDateFormatter *formatt=[[NSDateFormatter alloc] init];
    
    //小于一天
    if(nowCmps.year==transformCmps.year && nowCmps.month==transformCmps.month && nowCmps.day==transformCmps.day){
        [formatt setDateFormat:@"HH:mm"];
    }
    //小于一年
    else if (nowCmps.year==transformCmps.year){
        [formatt setDateFormat:@"MM/dd"];
    }
    //大于一年
    else{
        [formatt setDateFormat:@"yyyy-MM"];
    }
    result = [formatt stringFromDate:date];
    return result;
}

-(CGSize)stringSizeWithLableHeight:(CGFloat)height width:(CGFloat)width font:(UIFont*)fontSize{
    
    CGSize textSize=CGSizeZero;
    if(self.length==0)
    {
        return textSize;
    }
    NSMutableAttributedString *attStr=[[NSMutableAttributedString alloc]initWithString:self];
    [attStr addAttribute:NSFontAttributeName value:fontSize range:NSMakeRange(0, attStr.length)];
    NSRange range=NSMakeRange(0, attStr.length);
    NSDictionary *dic=[attStr attributesAtIndex:0 effectiveRange:&range];
    textSize=[self boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return textSize;
}
@end
