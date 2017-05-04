//
//  ArcVC.m
//  iOSDevelopTools
//
//  Created by 劉光軍 on 2017/5/4.
//  Copyright © 2017年 劉光軍. All rights reserved.
//

#import "ArcVC.h"
#import "NextViewController.h"

#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds
// 屏幕宽度
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface ArcVC ()<CAAnimationDelegate>

@end

@implementation ArcVC {
    UIImageView *_animationView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self cofigBtn];
    // Do any additional setup after loading the view.
}

- (void)cofigBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor blackColor];
    btn.titleLabel.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(kScreenWidth/2 - 50, kScreenHeight/2, 100, 60);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick {
    [self cofigAnimationView];
}

- (void)cofigAnimationView {
    _animationView =  [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    _animationView.image = [self getScreenSnapt];
    _animationView.image = [UIImage imageNamed:@"1"];
    [self.view addSubview:_animationView];
    [self animation];
}

- (UIImage *)getScreenSnapt {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kScreenWidth, kScreenHeight), NO, 1.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)animation {
    CGFloat radius = sqrtf(kScreenHeight * kScreenHeight + kScreenWidth * kScreenWidth) / 2 ;
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:3 startAngle:0 endAngle:M_PI*2 clockwise:NO];
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:NO];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = startPath.CGPath;
    maskLayer.backgroundColor = [UIColor blackColor].CGColor;
    _animationView.layer.mask = maskLayer;
    
    CABasicAnimation *pingAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pingAnimation.fromValue = (__bridge id)(startPath.CGPath);
    pingAnimation.toValue   = (__bridge id)(finalPath.CGPath);
    pingAnimation.duration = 0.35;
    pingAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseOut];
    [maskLayer addAnimation:pingAnimation forKey:@"pingInvert"];
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    fadeAnimation.toValue = [NSNumber numberWithFloat:0.5];
    fadeAnimation.duration = 0.3;
    fadeAnimation.delegate = self;
    fadeAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseIn];
    [_animationView.layer addAnimation:fadeAnimation forKey:@"fade"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [_animationView removeFromSuperview];
    NSLog(@"动画完成");
    
    NextViewController *nextVC = [[NextViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
