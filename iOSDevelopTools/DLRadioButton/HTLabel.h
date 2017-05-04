//
//  HTLabel.h
//  HTlvyou_ERP
//
//  Created by Alpha on 2017/2/16.
//  Copyright © 2017年 海涛旅游. All rights reserved.
//  垂直方向 可对其的 Label

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,VerticalAlignment)  {
    VerticalAlignmentTop = 0,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom
};

@interface HTLabel : UILabel

@property (nonatomic, assign) VerticalAlignment alignment;

@end
