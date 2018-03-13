//
//  NSString+YLUtil.m
//  YLUtilExample
//
//  Created by Yangli on 2018/3/12.
//  Copyright © 2018年 Yangli. All rights reserved.
//

#import "NSString+YLUtil.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (YLUtil)

/**
 判断字符串是否有空格
 
 @param str <#str description#>
 @return <#return value description#>
 */
+ (BOOL)isBlank:(NSString *)str {
    NSRange _range = [str rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        //有空格
        return YES;
    } else {
        //没有空格
        return NO;
    }
}

/**
 移除字符串中的空格和换行
 
 @param str <#str description#>
 @return <#return value description#>
 */
+ (NSString *)removeSpaceAndNewline:(NSString *)str {
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}


/**
 字符串为空
 
 @param str <#str description#>
 @return <#return value description#>
 */
+ (BOOL)isEqualToNil:(NSString *)str {
    return str.length <= 0 || [str isEqualToString:@""] || !str||[str isEqualToString:@" "];
}


/**
 判断NSString字符串是否包含emoji表情
 
 @param string <#string description#>
 @return <#return value description#>
 */
+ (BOOL)stringContainsEmoji:(NSString *)string{
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue =YES;
                }
            }else {
                // non surrogate
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue =YES;
                }else if (0x2B05 <= hs && hs <= 0x2b07) {
                    returnValue =YES;
                }else if (0x2934 <= hs && hs <= 0x2935) {
                    returnValue =YES;
                }else if (0x3297 <= hs && hs <= 0x3299) {
                    returnValue =YES;
                }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                    returnValue =YES;
                }
            }
        }
    }];
    return returnValue;
}


/**
 过滤表情
 
 @param text <#text description#>
 @return <#return value description#>
 */
+ (NSString *)disable_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

+ (BOOL)stringContainEmoji:(NSString *)string{
    NSUInteger len = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if (len < 3) { // 大于2个字符需要验证Emoji(有些Emoji仅三个字符)
        return NO;
    }
    
    // 仅考虑字节长度为3的字符,大于此范围的全部做Emoji处理
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    Byte *bts = (Byte *)[data bytes];
    Byte bt;
    short v;
    for (NSUInteger i = 0; i < len; i++) {
        bt = bts[i];
        
        if ((bt | 0x7F) == 0x7F) { // 0xxxxxxx ASIIC编码
            continue;
        }
        if ((bt | 0x1F) == 0xDF) { // 110xxxxx 两个字节的字符
            i += 1;
            continue;
        }
        if ((bt | 0x0F) == 0xEF) { // 1110xxxx 三个字节的字符(重点过滤项目)
            // 计算Unicode下标
            v = bt & 0x0F;
            v = v << 6;
            v |= bts[i + 1] & 0x3F;
            v = v << 6;
            v |= bts[i + 2] & 0x3F;
            
            // NSLog(@"%02X%02X", (Byte)(v >> 8), (Byte)(v & 0xFF));
            
            if ([NSString emojiInSoftBankUnicode:v] || [NSString emojiInUnicode:v]) {
                return YES;
            }
            
            i += 2;
            continue;
        }
        if ((bt | 0x3F) == 0xBF) { // 10xxxxxx 10开头,为数据字节,直接过滤
            continue;
        }
        
        return YES; // 不是以上情况的字符全部超过三个字节,做Emoji处理
    }
    return NO;
}

+ (BOOL)emojiInSoftBankUnicode:(short)code{
    return ((code >> 8) >= 0xE0 && (code >> 8) <= 0xE5 && (Byte)(code & 0xFF) < 0x60);
}
+ (BOOL)emojiInUnicode:(short)code{
    if (code == 0x0023
        || code == 0x002A
        || (code >= 0x0030 && code <= 0x0039)
        || code == 0x00A9
        || code == 0x00AE
        || code == 0x203C
        || code == 0x2049
        || code == 0x2122
        || code == 0x2139
        || (code >= 0x2194 && code <= 0x2199)
        || code == 0x21A9 || code == 0x21AA
        || code == 0x231A || code == 0x231B
        || code == 0x2328
        || code == 0x23CF
        || (code >= 0x23E9 && code <= 0x23F3)
        || (code >= 0x23F8 && code <= 0x23FA)
        || code == 0x24C2
        || code == 0x25AA || code == 0x25AB
        || code == 0x25B6
        || code == 0x25C0
        || (code >= 0x25FB && code <= 0x25FE)
        || (code >= 0x2600 && code <= 0x2604)
        || code == 0x260E
        || code == 0x2611
        || code == 0x2614 || code == 0x2615
        || code == 0x2618
        || code == 0x261D
        || code == 0x2620
        || code == 0x2622 || code == 0x2623
        || code == 0x2626
        || code == 0x262A
        || code == 0x262E || code == 0x262F
        || (code >= 0x2638 && code <= 0x263A)
        || (code >= 0x2648 && code <= 0x2653)
        || code == 0x2660
        || code == 0x2663
        || code == 0x2665 || code == 0x2666
        || code == 0x2668
        || code == 0x267B
        || code == 0x267F
        || (code >= 0x2692 && code <= 0x2694)
        || code == 0x2696 || code == 0x2697
        || code == 0x2699
        || code == 0x269B || code == 0x269C
        || code == 0x26A0 || code == 0x26A1
        || code == 0x26AA || code == 0x26AB
        || code == 0x26B0 || code == 0x26B1
        || code == 0x26BD || code == 0x26BE
        || code == 0x26C4 || code == 0x26C5
        || code == 0x26C8
        || code == 0x26CE
        || code == 0x26CF
        || code == 0x26D1
        || code == 0x26D3 || code == 0x26D4
        || code == 0x26E9 || code == 0x26EA
        || (code >= 0x26F0 && code <= 0x26F5)
        || (code >= 0x26F7 && code <= 0x26FA)
        || code == 0x26FD
        || code == 0x2702
        || code == 0x2705
        || (code >= 0x2708 && code <= 0x270D)
        || code == 0x270F
        || code == 0x2712
        || code == 0x2714
        || code == 0x2716
        || code == 0x271D
        || code == 0x2721
        || code == 0x2728
        || code == 0x2733 || code == 0x2734
        || code == 0x2744
        || code == 0x2747
        || code == 0x274C
        || code == 0x274E
        || (code >= 0x2753 && code <= 0x2755)
        || code == 0x2757
        || code == 0x2763 || code == 0x2764
        || (code >= 0x2795 && code <= 0x2797)
        || code == 0x27A1
        || code == 0x27B0
        || code == 0x27BF
        || code == 0x2934 || code == 0x2935
        || (code >= 0x2B05 && code <= 0x2B07)
        || code == 0x2B1B || code == 0x2B1C
        || code == 0x2B50
        || code == 0x2B55
        || code == 0x3030
        || code == 0x303D
        || code == 0x3297
        || code == 0x3299
        // 第二段
        || code == 0x23F0) {
        return YES;
    }
    return NO;
}


/**
 过滤字符串中的表情
 
 @param emojiStr <#emojiStr description#>
 @return <#return value description#>
 */
+ (NSString *)converStrEmoji:(NSString* )emojiStr{
    
    NSString *tempStr = [[NSString alloc]init];
    NSMutableString *kksstr = [[NSMutableString alloc]init];
    NSMutableArray *array = [NSMutableArray array];
    NSMutableString *strMu = [[NSMutableString alloc]init];
    if ([NSString stringContainEmoji:emojiStr]) {
        for(int i =0; i < [emojiStr length]; i++){
            
            tempStr = [emojiStr substringWithRange:NSMakeRange(i, 1)];
            [strMu appendString:tempStr];
            if ([self stringContainsEmoji:strMu]) {
                if ([strMu length] >= 2) {
                    strMu = [[strMu substringToIndex:([strMu length]-2)] mutableCopy];
                }
                
                if (array.count > 0) {
                    [array removeLastObject];
                }
                continue;
            }else
                [array addObject:tempStr];
            
        }
        
        
    }else{
        [array addObject:emojiStr];
    }
    
    for (NSString *strs in array) {
        [kksstr appendString:strs];
    }
    
    return kksstr;
}

+ (NSString *)stringToMD5:(NSString *)str
{
    
    //1.首先将字符串转换成UTF-8编码, 因为MD5加密是基于C语言的,所以要先把字符串转化成C语言的字符串
    const char *fooData = [str UTF8String];
    
    //2.然后创建一个字符串数组,接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    //3.计算MD5的值, 这是官方封装好的加密方法:把我们输入的字符串转换成16进制的32位数,然后存储到result中
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    /**
     第一个参数:要加密的字符串
     第二个参数: 获取要加密字符串的长度
     第三个参数: 接收结果的数组
     */
    
    //4.创建一个字符串保存加密结果
    NSMutableString *saveResult = [NSMutableString string];
    
    //5.从result 数组中获取加密结果并放到 saveResult中
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
    return saveResult;
}

/**
 字符串转换为数值型字符串<未使用>
 
 @param str <#str description#>
 @return <#return value description#>
 */
+ (NSString *)numStringFromString:(NSString *)str {
    if (str) {
        return str;
    }
    return @"0";
}


/**
 判断字符串是否为web端的null,是返回@""

 @param content <#NSString description#>
 @return <#return value description#>
 */
+ (NSString*)stringVerifyEmptyWithContent:(NSString*)content{
    if(content== nil || content == NULL || [content isEqual:[NSNull null]]||[content isEqual:@"(null)"])
        return @"";
    
    return content;
}


/**
 验证转成NSNumber

 @return <#return value description#>
 */
- (BOOL)VerifyToNSNumber{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    
    NSNumber *ber = nil;
    ber = [f numberFromString:self];
    return ber?YES:NO;
}



/**
 验证车牌

 @return <#return value description#>
 */
- (BOOL)VerifyCarNo{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[A-Z]{1}[a-zA-Z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    BOOL isMatch = [carTest evaluateWithObject:self];
    return isMatch;
}


/**
 验证手机号码

 @return <#return value description#>
 */
- (BOOL)VerifyPhone{
    NSString *pattern = @"^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}


/**
 验证短信验证码

 @return <#return value description#>
 */
- (BOOL)VerifySMSNote{
    NSString *pattern = @"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#define NUMBERS @"0123456789\n"
/**
 验证是否数字

 @return <#return value description#>
 */
- (BOOL)VerifyNum{
    NSCharacterSet* cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}


/**
 转换钱的小数点位数，只有小数点后一位的只取到小数点后1位，是整数的取整数,最多保留后2位

 @return <#return value description#>
 */
- (NSString*)getMoneyString{
    NSString *money = [NSString stringWithFormat:@"%.02f",[self doubleValue]];
    double d = [money doubleValue];
    int i = d;
    if (d != i) {
        if ([[money substringFromIndex:money.length-1] isEqualToString:@"0"]) {
            money = [money substringToIndex:money.length-1];
        }
        
        return money;
    }
    
    return [NSString stringWithFormat:@"%d",i];
}


/**
 验证是否满足位数要求
 
 @param minL 最小位数
 @param maxL 最大位数
 @return <#return value description#>
 */
- (BOOL)VerifyPwdWithMinLength:(NSUInteger)minL MaxLength:(NSUInteger)maxL{
    if (self.length<minL || self.length>maxL) {
        return 0;
    }
    return 1;
}


/**
 转换钱的小数点位数，保留后2位小数
 
 @param value <#value description#>
 @return <#return value description#>
 */
- (NSString*)getMoneyStringWithDouble:(double)value{
    NSString *money = [NSString stringWithFormat:@"%.02f",value];
    
    return [money getMoneyString];
}

@end
