//
//  CQScrollMenuView.m
//  UITableViewDemo
//
//  Created by 蔡强 on 2017/5/26.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "CQScrollMenuView.h"
#import "UIView+frameAdjust.h"

@interface CQScrollMenuView ()

@end

@implementation CQScrollMenuView{
    /** 用于记录最后创建的控件 */
    UIView *_lastView;
    /** 按钮下面的横线 */
    UIView *_lineView;
}

#pragma mark - 重写构造方法
/** 重写构造方法 */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

#pragma mark - 赋值标题数组
/** 赋值标题数组 */
- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    
    // 先将所有子控件移除
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    // 将lastView置空
    _lastView = nil;
    
    // 遍历标题数组
    [_titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *menuButton = [[UIButton alloc]init];
        [self addSubview:menuButton];
        if (_lastView) {
            menuButton.frame = CGRectMake(_lastView.maxX + 10, 0, 100, self.height);
        }else{
            menuButton.frame = CGRectMake(0, 0, 100, self.height);
        }
        
        menuButton.tag = 100 + idx;
        [menuButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [menuButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [menuButton setTitle:obj forState:UIControlStateNormal];
        [menuButton addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        // 宽度自适应
        [menuButton sizeToFit];
        menuButton.height = self.height;
        
        [menuButton layoutIfNeeded];
        
        // 默认第一个按钮时选中状态
        if (idx == 0) {
            menuButton.selected = YES;
            _lineView = [[UIView alloc]init];
            [self addSubview:_lineView];
            _lineView.bounds = CGRectMake(0, 0, menuButton.titleLabel.width, 2);
            _lineView.center = CGPointMake(menuButton.centerX, self.height - 1);
            _lineView.backgroundColor = [UIColor redColor];
        }
        
        _lastView = menuButton;
    }];
    
    self.contentSize = CGSizeMake(CGRectGetMaxX(_lastView.frame), CGRectGetHeight(self.frame));
    
    // 如果内容总宽度不超过本身，平分各个模块
    if (_lastView.maxX < self.width) {
        int i = 0;
        for (UIButton *button in self.subviews) {
            if ([button isMemberOfClass:[UIButton class]]) {
                button.width = self.width / _titleArray.count;
                button.x = i * button.width;
                button.titleLabel.adjustsFontSizeToFitWidth = YES; // 开启，防极端情况
                if (i == 0) {
                    _lineView.width = button.titleLabel.width;
                    _lineView.centerX = button.centerX;
                }
                i ++;
            }
        }
    }
}

#pragma mark - 菜单按钮点击
/** 菜单按钮点击 */
- (void)menuButtonClicked:(UIButton *)sender{
    // 改变按钮的选中状态
    for (UIButton *button in self.subviews) {
        if ([button isMemberOfClass:[UIButton class]]) {
            button.selected = NO;
        }
    }
    sender.selected = YES;
    _lineView.maxY = self.height;
    
    // 将所点击的button移到中间
    if (_lastView.maxX > self.width) {
        if (sender.x >= self.width / 2 && sender.centerX <= self.contentSize.width - self.width/2) {
            [UIView animateWithDuration:0.3 animations:^{
                self.contentOffset = CGPointMake(sender.centerX - self.width / 2, 0);
                _lineView.centerX = sender.centerX;
            }];
        }else if (sender.frame.origin.x < self.width / 2){
            [UIView animateWithDuration:0.3 animations:^{
                self.contentOffset = CGPointMake(0, 0);
                _lineView.centerX = sender.centerX;
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                self.contentOffset = CGPointMake(self.contentSize.width - self.width, 0);
                _lineView.centerX = sender.centerX;
            }];
        }
    }
    
    if ([self.menuButtonClickedDelegate respondsToSelector:@selector(scrollMenuView:clickedButtonAtIndex:)]) {
        [self.menuButtonClickedDelegate scrollMenuView:self clickedButtonAtIndex:(sender.tag - 100)];
    }
}

@end
