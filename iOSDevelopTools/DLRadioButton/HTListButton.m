//
//  HTListButton.m
//  Test
//
//  Created by Alpha on 2017/2/16.
//  Copyright © 2017年 Alpha. All rights reserved.
//

#import "HTListButton.h"

@interface HTListButton()

@property (nonatomic, strong) CALayer *bottomLine;

@property (nonatomic, strong) CAShapeLayer *rightCorner;//右下角三角形

@end

@implementation HTListButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    HTListButton *btn = [super buttonWithType:buttonType];
    return btn;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setSubViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSubViews];
}

- (void)setSubViews {
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    _bottomLine = [[CALayer alloc]init];
    _bottomLine.backgroundColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:_bottomLine];
    _rightCorner = [[CAShapeLayer alloc]init];
    _rightCorner.fillColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:_rightCorner];
}

- (void)drawRect:(CGRect)rect {
    _bottomLine.frame = CGRectMake(0, CGRectGetMaxY(rect) - 1, CGRectGetWidth(rect), 1);
    
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat maxY = CGRectGetHeight(rect);
    UIBezierPath *path = [UIBezierPath bezierPath];

    [path moveToPoint:CGPointMake(maxX, maxY)];
    // 其他点
    [path addLineToPoint:CGPointMake(maxX, maxY-6)];
    [path addLineToPoint:CGPointMake(maxX-6, maxY)];
    [path closePath];
    _rightCorner.path = path.CGPath;
    
}

@end
