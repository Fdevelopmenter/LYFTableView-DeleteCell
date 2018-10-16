//
//  ViewController.m
//  UITableViewDeleteItem
//
//  Created by 李玉枫 on 2018/10/16.
//  Copyright © 2018年 李玉枫. All rights reserved.
//

#import "ViewController.h"
#import "LYFTableView.h"

@interface ViewController ()

/// 列表
@property (nonatomic, strong) LYFTableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Get方法
-(LYFTableView *)tableView {
    if (!_tableView) {
        _tableView = [[LYFTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    }
    
    return _tableView;
}

@end
