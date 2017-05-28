//
//  ViewController.m
//  ThreeCountdown
//
//  Created by 抬头看见柠檬树 on 2017/5/28.
//  Copyright © 2017年 抬头看见柠檬树. All rights reserved.
//

#import "ViewController.h"

#import "CountdownOneViewController.h"
#import "CountdownTwoViewController.h"
#import "CountdownThreeViewController.h"

static NSString *const cellId = @"cellId";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController {
    NSArray *_cellNameArr;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"倒计时的三种方法";
    
    [self.view addSubview:self.tableView];
    _cellNameArr = @[@"1.通过NSThread的performSelectorInBackground",@"2.通过定时器",@"3.通过GCD中的dispatch_source"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = _cellNameArr[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: {
            CountdownOneViewController *oneVC = [[CountdownOneViewController alloc] init];
            [self.navigationController pushViewController:oneVC animated:YES];
        }
            break;
            
        case 1: {
            CountdownTwoViewController *twoVC = [[CountdownTwoViewController alloc] init];
            [self.navigationController pushViewController:twoVC animated:YES];
        }
            break;
            
        case 2: {
            CountdownThreeViewController *threeVC = [[CountdownThreeViewController alloc] init];
            [self.navigationController pushViewController:threeVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    }
    return _tableView;
}


@end
