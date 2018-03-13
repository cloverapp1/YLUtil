//
//  UITextField+YLUtil.m
//  YLUtilExample
//
//  Created by Yangli on 2018/3/12.
//  Copyright © 2018年 Yangli. All rights reserved.
//

#import "UITextField+YLUtil.h"
#import <objc/runtime.h>


static char ActionTag;

@implementation UITextField (YLUtil)

- (void)addActiontextFieldChanged:(TextFieldBlock)block{
    objc_setAssociatedObject(self, &ActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (void)textFieldChanged:(id)sender{
    TextFieldBlock blockAction = (TextFieldBlock)objc_getAssociatedObject(self, &ActionTag);
    if (blockAction){
        blockAction(self);
    }
}
- (void)addLeftPaddingWithWidth:(CGFloat) width{
    [self setLeftView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 1)]];
    self.leftViewMode=UITextFieldViewModeAlways;
}


@end
