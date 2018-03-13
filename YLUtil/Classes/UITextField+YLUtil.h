//
//  UITextField+YLUtil.h
//  YLUtilExample
//
//  Created by Yangli on 2018/3/12.
//  Copyright © 2018年 Yangli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextFieldBlock)(UITextField* textField);

@interface UITextField (YLUtil)

/**
 textfield block

 @param block <#block description#>
 */
- (void)addActiontextFieldChanged:(TextFieldBlock)block;

/**
 左侧占位

 @param width <#width description#>
 */
- (void)addLeftPaddingWithWidth:(CGFloat) width;

@end
