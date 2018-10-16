//
//  LYFTableViewCell.m
//  UITableViewDeleteItem
//
//  Created by 李玉枫 on 2018/10/16.
//  Copyright © 2018年 李玉枫. All rights reserved.
//

#import "LYFTableViewCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface LYFTableViewCell() <UIScrollViewDelegate>

/// 标题的背景
@property (nonatomic, strong) UIView *backView;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 删除按钮
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation LYFTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCell];
    }
    
    return self;
}

#pragma mark - 设置事件
-(void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    /// 在cell上先添加滑动视图
    [self.contentView addSubview:self.mainScrollView];
    
    /// 再在滑动视图上添加背景视图（就是cell主要显示的内容）
    [self.mainScrollView addSubview:self.backView];
    [self.mainScrollView addSubview:self.deleteButton];
    [self.backView addSubview:self.titleLabel];
    
    self.deleteButton.frame = CGRectMake(kScreenWidth, 0, [self deleteButtonWdith], 40.f);
    self.mainScrollView.frame = CGRectMake(0, 0, kScreenWidth, 40);
    self.backView.frame = CGRectMake(0, 0, kScreenWidth, 40.f);
    self.titleLabel.frame = CGRectMake(10, 0, 200, 40);
}

#pragma mark - Set方法
-(void)setName:(NSString *)name {
    _name = name;
    
    self.titleLabel.text = [NSString stringWithFormat:@"这里有个%@", self.name];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint movePoint = self.mainScrollView.contentOffset;
    if (movePoint.x < 0) {
        [self.mainScrollView setContentOffset:CGPointMake(0, 0)];
    }
    
    if (movePoint.x > [self deleteButtonWdith]) {
        self.deleteButton.frame = CGRectMake(kScreenWidth, 0, movePoint.x, 40.f);
    } else {
        self.deleteButton.frame = CGRectMake(kScreenWidth, 0, [self deleteButtonWdith], 40.f);
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGPoint endPoint = self.mainScrollView.contentOffset;
    if (endPoint.x < self.deleteButtonWdith) {
        [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    if (self.scrollAction) {
        self.scrollAction();
    }
}

#pragma mark - 点击事件
-(void)deleteAction:(UIButton *)button {
    if (self.deleteAction) {
        self.deleteAction(self.indexPath);
    }
}

#pragma mark - Get方法
-(CGFloat)deleteButtonWdith {
    return 70.0 * (kScreenWidth / 375.0);
}

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    
    return _backView;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    
    return _titleLabel;
}

-(UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        /// 设置滑动视图的偏移量是：屏幕宽+删除按钮宽
        _mainScrollView.contentSize = CGSizeMake(self.deleteButtonWdith + kScreenWidth, 0);
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.userInteractionEnabled = YES;
    }
    
    return _mainScrollView;
}

-(UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleteButton.backgroundColor = [UIColor redColor];
        [_deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _deleteButton;
}

/// 判断是否被打开了
-(BOOL)isOpen {
    return self.mainScrollView.contentOffset.x >= self.deleteButtonWdith;
}

@end
