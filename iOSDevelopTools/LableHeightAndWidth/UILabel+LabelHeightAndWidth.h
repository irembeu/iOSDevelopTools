//
//  UILabel+LabelHeightAndWidth.h
//  iOSDevelopTools
//
//  Created by 劉光軍 on 2017/5/4.
//  Copyright © 2017年 劉光軍. All rights reserved.
//  自动计算label的高度和宽度

#import <UIKit/UIKit.h>

@interface UILabel (LabelHeightAndWidth)

+ (CGFloat) getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

@end
