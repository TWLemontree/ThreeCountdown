//
//  CountdownThreeViewController.m
//  ThreeCountdown
//
//  Created by 抬头看见柠檬树 on 2017/5/28.
//  Copyright © 2017年 抬头看见柠檬树. All rights reserved.
//

#import "CountdownThreeViewController.h"

@interface CountdownThreeViewController ()

/** 显示倒计时效果的按钮 */
@property (nonatomic, strong) UIButton *btn;

@end

@implementation CountdownThreeViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.btn];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 私有方法
- (void)btnAction
{
    __block NSInteger second = 60;
    //全局队列    默认优先级
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //定时器模式  事件源
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //NSEC_PER_SEC是秒，＊1是每秒
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    dispatch_source_set_event_handler(timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second >= 0) {
                [self.btn setTitle:[NSString stringWithFormat:@"(%ld)重发验证码",second] forState:UIControlStateNormal];
                second--;
            }
            else
            {
                //这句话必须写否则会出问题
                dispatch_source_cancel(timer);
                [self.btn setTitle:@"获取验证码" forState:UIControlStateNormal];
                
            }
        });
    });
    //启动源
    dispatch_resume(timer);
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
