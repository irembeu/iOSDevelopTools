//
//  RCKeySelectView.m
//  HTlvyou_ERP
//
//  Created by Developer on 15/8/24.
//  Copyright (c) 2015年 海涛旅游. All rights reserved.
//

#import "RCKeySelectView.h"

#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds
// 屏幕宽度
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// 背景灰
#define kBackColor [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1]
// 标题的颜色
#define kTitleColor [UIColor colorWithRed:64.0/255 green:64.0/255 blue:64.0/255 alpha:1]
//  海涛绿
#define kGreen [UIColor colorWithRed:35.0/255 green:178.0/255 blue:150.0/255 alpha:1]
#define kGreenPressed [UIColor colorWithRed:25.0/255 green:171.0/255 blue:142.0/255 alpha:1]
//  常规红色
#define kRedShow [UIColor colorWithRed:242.0/255 green:91.0/255 blue:66.0/255 alpha:1]
//  文字颜色
#define kWordColor [UIColor colorWithRed:128.0/255 green:128.0/255 blue:128.0/255 alpha:1]
#import "RCListButton.h"

@interface RCKeySelectView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSString *title;

@end

#define kSelectMaxRows  8

@implementation RCKeySelectView
{
    UITableView     *_listView;     /**< 表  */
    CGFloat          _viewHeight;   /**< 表高度,根据内容计算  */
    UILabel         *_tableHeader;  /**< 标题  */
    NSMutableArray  *_array;        /**< 显示的数据  */
    UIView          *_contentView;  /**< 承载视图  */
}

- (id)init {
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        self.backgroundColor = [UIColor clearColor];
        _array = [[NSMutableArray alloc]init];
        [self configSubView];
    }
    return self;
}


//设置子视图
- (void)configSubView {
    
    UIControl *control = [[UIControl alloc]initWithFrame:self.bounds];
    control.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [control addTarget:self action:@selector(cancelSelect) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:control];
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenHeight, 6*40)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    //标题
    _tableHeader = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    _tableHeader.textAlignment = NSTextAlignmentCenter;
    _tableHeader.backgroundColor = kBackColor;
    _tableHeader.textColor = kTitleColor;
    [_contentView addSubview:_tableHeader];

    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, kScreenWidth, 1)];
    line.image = [UIImage imageNamed:@"line"];
    [_tableHeader addSubview:line];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 40);
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:kGreen forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelSelect) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:btn];

    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 5*40) style:UITableViewStylePlain];
    _listView.delegate = self;
    _listView.dataSource = self;
    [_contentView addSubview:_listView];
}
//list view 从底部划出
- (void)showListViewFromBottomWith:(RCListButton*)btn title:(NSString *)title {
    NSArray *list = btn.list;
    [self showListViewFromBottomWithArray:list title:title];
}

- (void)showListViewFromBottomWithArray:(NSArray *)array title:(NSString *)title {
    //计算listView 高度
    if(array.count <= 5){
        _viewHeight = 6* 40;
    }else if(array.count > 5 && array.count <= 8){
        _viewHeight = (array.count + 1)*40;
    }else {
        _viewHeight = 9*40;
    }
    [_array removeAllObjects];
    [_array addObjectsFromArray:array];
    [_listView reloadData];
    _listView.frame  = CGRectMake(0, 40, kScreenWidth, _viewHeight-40);
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    
    _tableHeader.text = title;
    _title = title;
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _contentView.frame = CGRectMake(0, kScreenHeight-_viewHeight, kScreenWidth, _viewHeight);
        _listView.frame = CGRectMake(0, 40, kScreenWidth, _viewHeight-40);
    } completion:^(BOOL finished) {

    }];
}


- (void)resetViewFrame {
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 6*40);
        _listView.frame = CGRectMake(0, 40, kScreenWidth, 200);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
//取消选择
- (void)cancelSelect{
    [self resetViewFrame];
}
#pragma mark-  table view  data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * scellid = @"keyselectedcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:scellid];
        cell.textLabel.highlightedTextColor = kRedShow;
        cell.textLabel.textColor = kWordColor;
    }
    NSDictionary *dict = [_array objectAtIndex:indexPath.row];
    NSString *name = [dict objectForKey:_key];
    cell.textLabel.text = name;
    return cell;
}
#pragma mark- table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(updateTitleAtRow:)]) {
        [self.delegate updateTitleAtRow:indexPath.row];
    }
    [self resetViewFrame];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}




@end
