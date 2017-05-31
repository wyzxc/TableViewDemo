//
//  CQScrollMenuView.h
//  UITableViewDemo
//
//  Created by 蔡强 on 2017/5/26.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CQScrollMenuView;
@protocol CQScrollMenuViewDelegate <NSObject>

/** 菜单按钮点击时回调 */
- (void)scrollMenuView:(CQScrollMenuView *)scrollMenuView clickedButtonAtIndex:(NSInteger)index;

@end

@interface CQScrollMenuView : UIScrollView

/** 菜单标题数组 */
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,weak) id <CQScrollMenuViewDelegate> menuButtonClickedDelegate;

@end
