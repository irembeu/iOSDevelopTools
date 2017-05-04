//
//  ViewController.m
//  iOSDevelopTools
//
//  Created by 劉光軍 on 2017/5/4.
//  Copyright © 2017年 劉光軍. All rights reserved.
//

#import "ViewController.h"
#import "ArcVC.h"
#import "RadioVC.h"

#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds
// 屏幕宽度
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy) NSArray *cellTitleArr;//标题数组

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
}


- (void)createTableView {
    
    _cellTitleArr = @[@"圆形渐变", @"单选按钮"];
    
    _tableView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

//MARK:- tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = [_cellTitleArr objectAtIndex:0];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = [_cellTitleArr objectAtIndex:1];
    }
    else {
        cell.textLabel.text = [NSString stringWithFormat:@"当前是第%ld行", indexPath.row+1];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self quickPushMethods:@"ArcVC"];
    } else if(indexPath.row == 1) {
        [self quickPushMethods:@"RadioVC"];
    }
    else {
        NSLog(@"点击了第%ld行", indexPath.row);
    }
}


- (void)quickPushMethods:(NSString *)vcName {
    id myVC = [[NSClassFromString(vcName) alloc] init];
    [self.navigationController pushViewController:myVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
