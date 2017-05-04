//
//  RCListButton.h
//  HTlvyou_ERP
//
//  Created by 游侠 on 15/7/25.
//  Copyright © 2015年 海涛旅游. All rights reserved.
//  背景为(下拉列表背景)的 button

#import <UIKit/UIKit.h>

@interface RCListButton : UIButton

@property (nonatomic, copy)   NSArray  *list;/**< 筛选条件 */
@property (nonatomic, copy)   NSString *displayTitle; /**< 显示的文字 */

- (void)titleFont:(CGFloat)fontSize;

@end
