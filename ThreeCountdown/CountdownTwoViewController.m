//
//  CountdownTwoViewController.m
//  ThreeCountdown
//
//  Created by 抬头看见柠檬树 on 2017/5/28.
//  Copyright © 2017年 抬头看见柠檬树. All rights reserved.
//

#import "CountdownTwoViewController.h"

@interface CountdownTwoViewController ()

/** 显示倒计时效果的按钮 */
@property (nonatomic, strong) UIButton *btn;

@end

@implementation CountdownTwoViewController {
    int _count; // 倒计时数字
    NSTimer *_timer; // 定时器
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.btn];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 私有方法
- (void)btnAction
{
    _count = 59;
    [self handleTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
}

- (void)handleTimer
{
    if (_count > 0) {
        [self.btn setUserInteractionEnabled:NO];
        [self.btn setTitle:[NSString stringWithFormat:@"(%d)重发验证码",_count] forState:UIControlStateNormal];
    } else {
        [self.btn setUserInteractionEnabled:YES];
        [self.btn setTitle:[NSString stringWithFormat:@"重发验证码"] forState:UIControlStateNormal];
   
        [_timer invalidate];
    }
    _count -= 1;
}

#pragma mark - 懒加载
- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        _btn.frame = CGRectMake(10, 200, 300, 50);
        [_btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end
