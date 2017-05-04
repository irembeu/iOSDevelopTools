//
//  RCKeySelectView.h
//  HTlvyou_ERP
//
//  Created by Developer on 15/8/24.
//  Copyright (c) 2015年 海涛旅游. All rights reserved.
//  有取值key 的选择器 类似于 RCSelectView

#import <UIKit/UIKit.h>

@class RCListButton;

@protocol KeySelectDelegate <NSObject>

- (void)updateTitleAtRow:(NSInteger)row;

@end

@interface RCKeySelectView : UIView

@property (nonatomic, weak)   id<KeySelectDelegate>delegate;

// 取数据 的 key
@property (nonatomic, copy)   NSString *key;

// 标题 选择的内容提示
@property (nonatomic, copy, readonly)   NSString *title;

- (void)showListViewFromBottomWith:(RCListButton*)btn title:(NSString*)title;

- (void)showListViewFromBottomWithArray:(NSArray *)array title:(NSString *)title;

@end
