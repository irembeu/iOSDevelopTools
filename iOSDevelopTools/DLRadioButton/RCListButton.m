//
//  RCListButton.m
//  HTlvyou_ERP
//
//  Created by 游侠 on 15/7/25.
//  Copyright © 2015年 海涛旅游. All rights reserved.
//

#import "RCListButton.h"

@implementation RCListButton
{
    UILabel *displayLabel;/**< 显示 */
    UIView*bg;
    UIView*bottomLine;
    UIImageView*trigle;
}
- (void)awakeFromNib {
     [super awakeFromNib];
    [self setDisplayTitle:@""];
}

- (void)layoutSubviews {
    displayLabel.frame = CGRectMake(0, 5, self.frame.size.width-10, self.frame.size.height-10);
    bg.frame = self.bounds;
    bottomLine.frame = CGRectMake(0, CGRectGetHeight(self.frame)-5, CGRectGetWidth(self.frame), 1);
    trigle.frame = CGRectMake(CGRectGetWidth(self.frame)-7, CGRectGetHeight(self.frame)-11, 7, 7);
}

- (void)setDisplayTitle:(NSString *)displayTitle {
    if (![_displayTitle isEqualToString:displayTitle]) {
        _displayTitle = displayTitle;
        if (!displayLabel) {
            displayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.frame.size.width-10, self.frame.size.height-10)];
            displayLabel.textColor = [UIColor blackColor];
            displayLabel.font = [UIFont systemFontOfSize:15];
            [self addSubview:displayLabel];
            
            bg = [[UIView alloc]initWithFrame:self.bounds];
            bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-5, CGRectGetWidth(self.frame), 1)];
            bottomLine.backgroundColor = [UIColor grayColor];
            [bg addSubview:bottomLine];
            trigle = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-7, CGRectGetHeight(self.frame)-11, 7, 7)];
            trigle.image = [UIImage imageNamed:@"select_dropdown"];
            [bg addSubview:trigle];
            bg.userInteractionEnabled = NO; //需禁用,否则截获点击事件
    
            [self addSubview:bg];
            [self sendSubviewToBack:bg];
        }
    }
    displayLabel.text = displayTitle;
}

- (void)titleFont:(CGFloat)fontSize {
    displayLabel.textColor = [UIColor greenColor];
    displayLabel.textAlignment = NSTextAlignmentRight;
    displayLabel.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setEnabled:(BOOL)enabled {
    if (enabled) {
        displayLabel.textColor = [UIColor redColor];
    }
    else {
        displayLabel.textColor = [UIColor blackColor];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
