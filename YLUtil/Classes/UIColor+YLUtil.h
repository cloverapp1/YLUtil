//
//  UIColor+YLUtil.h
//  YLUtilExample
//
//  Created by Yangli on 2018/3/12.
//  Copyright © 2018年 Yangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YLUtil)

/**
 16进制颜色
 
 @param hexString 16进制字符串
 @return color对象
 */
+ (UIColor *)colorWithHexString: (NSString *) hexString;


@end
