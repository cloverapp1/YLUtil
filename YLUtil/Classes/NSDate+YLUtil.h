//
//  NSDate+YLUtil.h
//  Pods
//
//  Created by Yangli on 2018/3/13.
//

//#import <Foundation/Foundation.h>
#import <Foundation/NSDate.h>
#import <Foundation/NSCalendar.h>

#define ONE_MINUTE 60
#define ONE_HOUR  (60*ONE_MINUTE)
#define ONE_DAY   (24*ONE_HOUR)

@interface NSDate (YLUtil)


/**
  获取网络时间

 @return <#return value description#>
 */
+ (NSDate*)getInternetTime;

/**
 时间字符串 ‘yyyyMMddHHmmss’ 转换为 NSDate

 @param timeString <#timeString description#>
 @return <#return value description#>
 */
+ (NSDate*)dateFromDateNumString:(NSString*)timeString;

/**
 时间字符串 ‘yyyy-MM-dd HH:mm:ss’ 转换为 NSDate

 @param timeString <#timeString description#>
 @return <#return value description#>
 */
+ (NSDate*)dateFromDateTimeString:(NSString*)timeString;

/**
 时间字符串 ‘yyyy年MM月dd日’ 转换为 NSDate

 @param dateString <#dateString description#>
 @return <#return value description#>
 */
+ (NSDate*)dateFromChineseString:(NSString*)dateString;

/**
 日期字符串‘yyyy-MM-dd' 转换为 NSDate

 @param dateStr <#dateStr description#>
 @return <#return value description#>
 */
+ (NSDate *)dateFromDateString:(NSString *)dateStr;


/**
 日期字符串‘yyyy-MM' 转换为 NSDate

 @param dateString <#dateString description#>
 @return <#return value description#>
 */
+ (NSDate*)dateFromChineseStringMonth:(NSString*)dateString;


/**
 日期字符串‘formate' 转换为 NSDate

 @param dateString <#dateString description#>
 @param formateString <#formateString description#>
 @return <#return value description#>
 */
+ (NSDate*)dateString:(NSString*)dateString formatString:(NSString*)formateString;


/**
 修改日期，创建新时间

 @param h <#h description#>
 @param m <#m description#>
 @param sec <#sec description#>
 @return <#return value description#>
 */
- (NSDate*)updateDateWithhour:(int)h minute:(int)m second:(int)sec;


/**
 修改日期，创建新时间

 @param day <#day description#>
 @return <#return value description#>
 */
- (NSDate*)updateDateWithDay:(int)day;


/**
 修改月份，对当前月份增加或者减少

 @param value <#value description#>
 @return <#return value description#>
 */
- (NSDate*)moveMonth:(int)value;


/**
 修改年份，对当前年增加或者减少

 @param value <#value description#>
 @return <#return value description#>
 */
- (NSDate*)moveYear:(int)value;


/**
 当前NSDate转为GMT 时间的字符串

 @return <#return value description#>
 */
- (NSString*)gmtDateTimeString;


/**
 当前NSDate转为GMT 日期的字符串

 @return <#return value description#>
 */
- (NSString*)gmtDateString;


/**
 当前NSDate转为‘yyyy-MM-dd HH:mm:ss’ 时间的字符串

 @return <#return value description#>
 */
- (NSString*)dateTimeString;


/**
 当前NSDate转为‘yyyy-MM-dd HH:mm’ 时间的字符串

 @return <#return value description#>
 */
- (NSString*)dateTimeSimpleString;


/**
 当前NSDate转为‘yyyy-MM-dd'字符串

 @return <#return value description#>
 */
- (NSString *)dateString;


/**
 当前NSDate转为‘yyyy年MM月dd日'字符串

 @return <#return value description#>
 */
- (NSString *)chineseDateString;


/**
 当前NSDate转为‘yyyy年MM月'字符串

 @return <#return value description#>
 */
- (NSString *)chineseYearMonthDateString;


/**
 当前NSDate转为‘MM-dd'字符串

 @return <#return value description#>
 */
- (NSString*)monthDayString;


/**
 当前NSDate转为‘yyyy-MM'字符串

 @return <#return value description#>
 */
- (NSString*)yearMonthString;


/**
 当前NSDate转为‘hh-mm'字符串

 @return <#return value description#>
 */
- (NSString*)timeString;


/**
 一年中的第几天

 @return <#return value description#>
 */
- (NSInteger)dayOfYear;


/**
 一天从0点开始的时间，单位 秒

 @return <#return value description#>
 */
- (NSInteger)dayTime;


/**
 <#Description#>

 @return <#return value description#>
 */
- (NSDateComponents*)components;


/**
 比较两个时间之间差距的绝对值

 @param date <#date description#>
 @return <#return value description#>
 */
- (NSTimeInterval)absIntervalSinceDate:(NSDate *)date;

/**
 当前时间对象和现在时间差的绝对值

 @return <#return value description#>
 */
- (NSTimeInterval)absIntervalSinceNow;

/**
 当前时间对象和所选时间差

 @param date <#date description#>
 @return <#return value description#>
 */
- (NSTimeInterval)IntervalSinceDate:(NSDate *)date;


/**
 根据时间戳计算天、小时、时、分

 @param interval <#interval description#>
 @return <#return value description#>
 */
+ (NSString *)getTimeByInterval:(NSTimeInterval)interval;


/**
 获取当前时间戳

 @return <#return value description#>
 */
+ (NSString *)getTimeStamp;


/**
 转化任意日期到当前时区

 @param forDate <#forDate description#>
 @return <#return value description#>
 */
+(NSDate *)dateToLocalDateFromDate: (NSDate *)forDate;


/**
 <#Description#>

 @param timeDate <#timeDate description#>
 @return <#return value description#>
 */
+(NSString *)stringFromDateNumString:(NSDate *)timeDate;

@end
