//
//  FirstCell.m
//  UITableViewDemo
//
//  Created by 蔡强 on 2017/5/25.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "FirstCell.h"

@implementation FirstCell

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // UI搭建
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI{
    self.backgroundColor = [UIColor redColor];
}

@end
