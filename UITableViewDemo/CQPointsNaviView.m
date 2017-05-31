//
//  CQPointsNaviView.m
//  UITableViewDemo
//
//  Created by 蔡强 on 2017/5/27.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "CQPointsNaviView.h"
#import "UIView+frameAdjust.h"

@implementation CQPointsNaviView

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // UI搭建
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI{
    self.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0];
    
    // 模糊效果
//    CALayer *layer = [CALayer layer];//也可以是UIView,但是不能装UIVisualEffectView
//    layer.frame = CGRectMake( 0, 0.5, self.width, 63);//每边最好小0.5个点，不然可能会看到阴影层的黑色“描边”
//    layer.shadowColor     = [UIColor blackColor].CGColor;
//    layer.shadowOffset    = CGSizeMake( 0, 0);
//    layer.shadowOpacity   = 1;
//    //    layer.cornerRadius    = 8;
//    layer.borderWidth     = 0;
//    layer.borderColor     = [UIColor blackColor].CGColor;
//    
//    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
//    effectview.frame = CGRectMake( 0, 0, self.width, 64);
//    
//    [self.layer addSublayer:layer];
//    [self addSubview:effectview];
    
    //------- 返回按钮 -------//
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 100, 44)];
    [self addSubview:backButton];
    backButton.backgroundColor = [UIColor orangeColor];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    //------- 标题 -------//
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, self.width - 200, 44)];
    [self addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"积分兑换";
    titleLabel.font = [UIFont systemFontOfSize:15];
}

#pragma mark - 返回按钮点击
/** 返回按钮点击 */
- (void)back:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(naviView:backButtonDidClick:)]) {
        [self.delegate naviView:self backButtonDidClick:sender];
    }
}

@end
