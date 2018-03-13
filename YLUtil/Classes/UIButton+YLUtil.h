//
//  UIButton+YLUtil.h
//  YLUtilExample
//
//  Created by Yangli on 2018/3/12.
//  Copyright © 2018年 Yangli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(UIButton* btn);

@interface UIButton (YLUtil)


/**
 button block  touchupinside

 @param block <#block description#>
 */
- (void)addAction:(ButtonBlock)block;

/**
 button block with controlEvent

 @param block <#block description#>
 @param controlEvents <#controlEvents description#>
 */
- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;


/**
 <#Description#>

 @param size <#size description#>
 */
- (void)setEnlargeEdge:(CGFloat) size;


/**
 <#Description#>

 @param top <#top description#>
 @param right <#right description#>
 @param bottom <#bottom description#>
 @param left <#left description#>
 */
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

/**
 左文右图
 
 @param spacing <#spacing description#>
 */
- (void)setImageRightPositionSpacing:(CGFloat)spacing;

/**
 上图下文字
 
 @param spacing <#spacing description#>
 */
- (void)verticalImageAndTitle:(CGFloat)spacing;

@end
