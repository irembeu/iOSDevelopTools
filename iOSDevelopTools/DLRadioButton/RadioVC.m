//
//  RadioVC.m
//  iOSDevelopTools
//
//  Created by 劉光軍 on 2017/5/4.
//  Copyright © 2017年 劉光軍. All rights reserved.
//

#import "RadioVC.h"
#import "DLRadioButton.h"
#import "HTListButton.h"
#import "HTLabel.h"

#import "RCListButton.h"
#import "RCKeySelectView.h"

@interface RadioVC ()<KeySelectDelegate>

@end

@implementation RadioVC {
    DLRadioButton *_maleRadio;//男
    DLRadioButton *_femaleRadio;//女
    RCListButton *_selectBtn;//带有上弹列表的button
    RCKeySelectView *_selectView;
    NSArray *_selectArr;//选择列表中的选项字典数组 通过key取
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cofigSexButton];
    [self configSaveBtn];
    [self configLabel];
    [self configSelectListBtn];
}

//MARK:- 弹出选择列表按钮
- (void)configSelectListBtn {
    
    _selectArr = @[@{@"name":@"第一项"}, @{@"name":@"第二项"}, @{@"name":@"第三项"}, @{@"name":@"第四项"}, @{@"name":@"第五项"}, @{@"name":@"第六项"}, @{@"name":@"第七项"}];
    
    _selectBtn = [RCListButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn setDisplayTitle:@"请选择"];
    _selectBtn.frame = CGRectMake(50, 200, 80, 40);
    [_selectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _selectBtn.list = _selectArr;
    [self.view addSubview:_selectBtn];
    
}
- (void)selectBtnClick {
    [self configSelectView];
    _selectView.key = @"name";
    [_selectView showListViewFromBottomWith:_selectBtn title:@"请选择"];
}

// selectView代理方法
- (void)configSelectView {
    if (!_selectView) {
        _selectView = [[RCKeySelectView alloc]init];
        _selectView.delegate = self;
    }
}
- (void)updateTitleAtRow:(NSInteger)row {
    NSDictionary *dic = [_selectArr objectAtIndex:row];
    NSString *title = [dic objectForKey:@"name"];
    [_selectBtn setDisplayTitle: title];
    NSLog(@"选中了%@", title);
}



//MARK:- 垂直对齐的label
- (void)configLabel {
    HTLabel *label = [[HTLabel alloc] initWithFrame:CGRectMake(20, 150, 100, 30)];
    label.text = @"我是Label";
    label.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:label];
}
//MARK:- 单选按钮
- (void)cofigSexButton {
    // 性别
    _maleRadio= [[DLRadioButton alloc] initWithFrame:CGRectMake(50 , 100, 70, 40)];
    [_maleRadio setTitle:@"男" forState:UIControlStateNormal];
    [_maleRadio setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _maleRadio.icon = [UIImage imageNamed:@"radio_default"];
    _maleRadio.iconSelected = [UIImage imageNamed:@"radio_checked"];
    _maleRadio.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:_maleRadio];
    
    _femaleRadio= [[DLRadioButton alloc] initWithFrame:CGRectMake(130 , 100, 70, 40)];
    [_femaleRadio setTitle:@"女" forState:UIControlStateNormal];
    [_femaleRadio setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _femaleRadio.icon = [UIImage imageNamed:@"radio_default"];
    _femaleRadio.iconSelected = [UIImage imageNamed:@"radio_checked"];
    _femaleRadio.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:_femaleRadio];
    [_maleRadio setOtherButtons:@[_femaleRadio]];
    
}

- (void)configSaveBtn {
    HTListButton *saveBtn = [HTListButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(180, 100, 100, 40);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    saveBtn.backgroundColor = [UIColor greenColor];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}

- (void)saveBtnClick {
    if (_maleRadio.selected) {
        NSLog(@"选中性别男");
    } else if (_femaleRadio.selected) {
        NSLog(@"选中性别女");
    } else {
        NSLog(@"选中未知");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
