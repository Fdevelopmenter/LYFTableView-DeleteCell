//
//  LYFTableViewCell.h
//  UITableViewDeleteItem
//
//  Created by 李玉枫 on 2018/10/16.
//  Copyright © 2018年 李玉枫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LYFTableViewCellScrollAction)(void);
typedef void(^LYFTableViewCellDeleteAction)(NSIndexPath *indexPath);

@interface LYFTableViewCell : UITableViewCell

/// 删除事件
@property (nonatomic, copy) LYFTableViewCellDeleteAction deleteAction;
/// 滑动事件
@property (nonatomic, copy) LYFTableViewCellScrollAction scrollAction;
/// 滑动视图
@property (nonatomic, strong) UIScrollView *mainScrollView;
/// 组数行数
@property (nonatomic, strong) NSIndexPath *indexPath;
/// 打开状态
@property (nonatomic, assign) BOOL isOpen;
/// 名字
@property (nonatomic, copy) NSString *name;

@end
