//
//  NSString+Addition.h
//  Halin
//
//  Created by Halin on 15-5-11.
//  Copyright (c) 2015年 Halin All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


static NSString *const CHARACTER_LETTERS = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
static NSString *const CHARACTER_SPACE   = @"0123456789";
static NSString *const CHARACTER_NUMBERS = @" ";
static NSString *const CHARACTER_LINE_BREAK = @"\n";
/**过滤需要把单号中间的空白也去除 ted修改*/
static NSString *const CHARACTER_LETTERS_NUMS_AND_SPACE = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
/**包含字母数字,\n \r的string*/
static NSString *const CHARACTER_LETTERS_NUMS_SPACE_LINE_BREAK_AND_R_LINE_BREAK = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 \n\r";


@interface  NSString(Addition)


+ (NSString *)convertToIconTextWithHexString:(NSString *)hexStr;

/**空字符判断,为空或者长度为0返回true*/
+ (BOOL)isEmpty:(NSString *)string;


/**
 *  判断字符串是只包含目标文本
 *
 *  @param
 *     characters:包含的文本
 *
 *  @return 若全部字符为字母，数字或者空格则返回yes，否则返回no
 */
- (BOOL)isStringOnlyContainCharacters:(NSString *)characters;


- (NSString *)md5;

/**
 *  将日期转换为指定格式的字符串
 *
 *  @param date 日期
 *
 *  @return 指定格式的字符串
 */
+(NSString*)transformDateToString:(NSDate*)date;


/**将制定的前缀(target)替换成replacement*/
- (NSString *)stringByReplacingFirstOccurrencesOfString:(NSString *)target withString:(NSString *)replacement;

/**将所有出现在characters的字符串替换为空*/
- (NSString *)stringByReplacingCharacterSet:(NSCharacterSet *)characters;

/**
 *  字符串的宽高
 *
 *  @param height   高度上限
 *  @param width    宽度上限
 *  @param fontSize 字体大小
 *
 *  @return 字符串在以上限制条件的情况下的宽高
 */
-(CGSize)stringSizeWithLableHeight:(CGFloat)height width:(CGFloat)width font:(UIFont*)fontSize;


@end
