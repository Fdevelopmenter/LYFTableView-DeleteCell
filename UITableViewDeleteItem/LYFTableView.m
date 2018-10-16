//
//  LYFTableView.m
//  UITableViewDeleteItem
//
//  Created by 李玉枫 on 2018/10/16.
//  Copyright © 2018年 李玉枫. All rights reserved.
//

#import "LYFTableView.h"
#import "LYFTableViewCell.h"

@interface LYFTableView() <UITableViewDataSource, UITableViewDelegate>

/// 数据源
@property (nonatomic, strong) NSMutableArray<NSString *> *dataList;

@end

static NSString *tableViewCellId = @"LYFTableViewCell";

@implementation LYFTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        
        self.rowHeight = 40.f;
        
        [self registerClass:[LYFTableViewCell class] forCellReuseIdentifier:tableViewCellId];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource / UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYFTableViewCell *cell = [[LYFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellId];
    
    cell.name = self.dataList[indexPath.row];
    cell.indexPath = indexPath;
    typeof(self) __weak weakSelf = self;
    cell.deleteAction = ^(NSIndexPath *indexPath) {
        /// 删除逻辑
        [weakSelf.dataList removeObjectAtIndex:indexPath.row];
        
        [weakSelf reloadData];
    };
    
    cell.scrollAction = ^{
        for (LYFTableViewCell *tableViewCell in weakSelf.visibleCells) {
            /// 当屏幕滑动时，关闭不是当前滑动的cell
            if (tableViewCell.isOpen == YES && tableViewCell != cell) {
                [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
    };
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (LYFTableViewCell *tableViewCell in self.visibleCells) {
        /// 当屏幕滑动时，关闭被打开的cell
        if (tableViewCell.isOpen == YES) {
            [tableViewCell.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}

#pragma mark - Get方法
-(NSMutableArray<NSString *> *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithArray:@[@"中国人", @"日本人", @"美国人", @"英国人", @"德国人", @"越南人", @"印度人", @"西班牙人", @"法国人", @"意大利人"]];
    }
    
    return _dataList;
}

@end
