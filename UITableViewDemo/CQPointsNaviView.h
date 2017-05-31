//
//  CQPointsNaviView.h
//  UITableViewDemo
//
//  Created by 蔡强 on 2017/5/27.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CQPointsNaviView;
@protocol CQPointsNaviViewDelegate <NSObject>

/** 返回按钮点击时回调 */
- (void)naviView:(CQPointsNaviView *)naviView backButtonDidClick:(UIButton *)sender;

@end

@interface CQPointsNaviView : UIView

@property (nonatomic,weak) id <CQPointsNaviViewDelegate> delegate;

@end
