//
//  UITabBar+YLUtil.h
//  YLUtilExample
//
//  Created by Yangli on 2018/3/12.
//  Copyright © 2018年 Yangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (YLUtil)


/**
 显示小红点

 @param index <#index description#>
 @param tabbarItemNums <#tabbarItemNums description#>
 */
- (void)showBadgeOnItemIndex:(int)index tabbarItemNums:(int)tabbarItemNums;


/**
 隐藏小红点

 @param index <#index description#>
 */
- (void)hideBadgeOnItemIndex:(int)index;

@end
