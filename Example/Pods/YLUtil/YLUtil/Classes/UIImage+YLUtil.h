//
//  UIImage+YLUtil.h
//  YLUtilExample
//
//  Created by Yangli on 2018/3/12.
//  Copyright © 2018年 Yangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YLUtil)

/**
 * 将图片缩放到指定的CGSize大小
 * UIImage image 原始的图片
 * CGSize size 要缩放到的大小
 */
+ (UIImage*)image:(UIImage *)image scaleToSize:(CGSize)size;

/**
 image裁剪
 
 @param image <#image description#>
 @param rect <#rect description#>
 @return <#return value description#>
 */
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

/**
 * 根据给定的size的宽高比自动缩放原图片、自动判断截取位置,进行图片截取
 * UIImage image 原始的图片
 * CGSize size 截取图片的size
 */
- (UIImage *)clipImage:(UIImage *)image toRect:(CGSize)size;


/**
 根据给定的size的宽高比自动缩放原图片

 @param image <#image description#>
 @param newSize <#newSize description#>
 @return <#return value description#>
 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;


/**
 根据颜色初始化image
 
 @param color <#color description#>
 @return <#return value description#>
 */
+ (UIImage*)createImageWithColor: (UIColor*) color;

/**
 根据颜色初始化image

 @param color <#color description#>
 @param width <#width description#>
 @return <#return value description#>
 */
+ (UIImage*)createImageWithColor: (UIColor*) color withWidth:(CGFloat)width;


/**
 圆角矩形
 
 @param radius <#radius description#>
 @return <#return value description#>
 */
- (UIImage*)imageWithCornerRadius:(CGFloat)radius;


/**
 防止图片拉伸

 @param name <#name description#>
 @return <#return value description#>
 */
+ (UIImage *)resizableImage:(NSString *)name;


@end
