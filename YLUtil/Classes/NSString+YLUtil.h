//
//  NSString+YLUtil.h
//  YLUtilExample
//
//  Created by Yangli on 2018/3/12.
//  Copyright © 2018年 Yangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YLUtil)

/**
 判断字符串是否有空格
 
 @param str <#str description#>
 @return <#return value description#>
 */
+ (BOOL)isBlank:(NSString *)str;


/**
 移除字符串中的空格和换行
 
 @param str <#str description#>
 @return <#return value description#>
 */
+ (NSString *)removeSpaceAndNewline:(NSString *)str;


/**
 字符串为空或者为单个空格
 
 @param str <#str description#>
 @return <#return value description#>
 */
+ (BOOL)isEqualToNil:(NSString *)str;

/**
 判断NSString字符串是否包含emoji表情
 
 @param string <#string description#>
 @return <#return value description#>
 */
+ (BOOL)stringContainEmoji:(NSString *)string;

/**
 过滤表情
 
 @param text <#text description#>
 @return <#return value description#>
 */
+ (NSString *)disable_emoji:(NSString *)text;

/**
 过滤字符串中的表情
 
 @param emojiStr <#emojiStr description#>
 @return <#return value description#>
 */
+ (NSString *)converStrEmoji:(NSString* )emojiStr;


/**
 md5加密
 
 @param str <#str description#>
 @return <#return value description#>
 */
+ (NSString *)stringToMD5:(NSString *)str;

/**
 字符串转换为数值型字符串<未使用>
 
 @param str <#str description#>
 @return <#return value description#>
 */
+ (NSString *)numStringFromString:(NSString *)str;

/**
 判断字符串是否为web端的null,是返回@""

 @param content <#content description#>
 @return <#return value description#>
 */
+ (NSString*)stringVerifyEmptyWithContent:(NSString*)content;


/**
 验证转成NSNumber

 @return <#return value description#>
 */
- (BOOL)VerifyToNSNumber;

/**
 验证车牌

 @param BOOL <#BOOL description#>
 @return <#return value description#>
 */
- (BOOL)VerifyCarNo;

/**
 验证手机号码

 @param BOOL <#BOOL description#>
 @return <#return value description#>
 */
- (BOOL)VerifyPhone;


/**
 验证短信验证码

 @return <#return value description#>
 */
- (BOOL)VerifySMSNote;



/**
 验证是否满足位数要求

 @param minL 最小位数
 @param maxL 最大位数
 @return <#return value description#>
 */
- (BOOL)VerifyPwdWithMinLength:(NSUInteger)minL MaxLength:(NSUInteger)maxL;


/**
 验证是否数字

 @return <#return value description#>
 */
- (BOOL)VerifyNum;



/**
 转换钱的小数点位数，只有小数点后一位的只取到小数点后1位，是整数的取整数,最多保留后2位

 @return <#return value description#>
 */
- (NSString*)getMoneyString;



/**
 转换钱的小数点位数，保留后2位小数

 @param value <#value description#>
 @return <#return value description#>
 */
- (NSString*)getMoneyStringWithDouble:(double)value;

@end
