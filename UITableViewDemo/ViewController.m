//
//  ViewController.m
//  UITableViewDemo
//
//  Created by 蔡强 on 2017/5/25.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "ViewController.h"
#import "UIView+frameAdjust.h"
#import "FirstCell.h"
#import "CQScrollMenuView.h"
#import "CQPointsNaviView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,CQScrollMenuViewDelegate,CQPointsNaviViewDelegate>

@property (nonatomic,strong) CQPointsNaviView *naviView;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //------- 导航栏 -------//
    self.naviView = [[CQPointsNaviView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    [self.view addSubview:self.naviView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view sendSubviewToBack:self.tableView];
    
    //------- 表头 -------//
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
    self.imageView.image = [UIImage imageNamed:@"head"];
    
    self.tableView.tableHeaderView = self.imageView;
}

#pragma mark - Delegate - 导航栏
/** 导航栏返回按钮点击时回调 */
- (void)naviView:(CQPointsNaviView *)naviView backButtonDidClick:(UIButton *)sender{
    NSLog(@"返回上一页");
}

#pragma mark - Delegate - 菜单栏
/** 菜单栏点击 */
- (void)scrollMenuView:(CQScrollMenuView *)scrollMenuView clickedButtonAtIndex:(NSInteger)index{
    NSLog(@"tag:%ld",index);
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 修改导航栏透明度
    self.naviView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:((offsetY - 64) / 150.0)];
    
    // 修改组头悬挂位置
    if (offsetY >= 200) {
        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }else{
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}

#pragma mark - UITableView Delegate & DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID = @"reuseID";
    FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[FirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    switch (indexPath.section) {
        case 0:
        {
            cell.backgroundColor = [UIColor redColor];
            cell.textLabel.text = @"1";
        }
            break;
            
        case 1:
        {
            cell.backgroundColor = [UIColor blueColor];
            cell.textLabel.text = @"2";
        }
            break;
            
        case 2:
        {
            cell.backgroundColor = [UIColor orangeColor];
        }
            break;
            
        default:
            break;
    }
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CQScrollMenuView *buleView = [[CQScrollMenuView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    buleView.menuButtonClickedDelegate = self;
    buleView.titleArray = @[@"标题1",@"title2",@"title3",@"title2",@"title3",@"title2",@"title3",@"title2",@"title3",@"title2",@"title3",@"title2",@"title3",@"title2",@"title3",@"title2",@"title3",@"title2",@"title3",@"title2",@"title3",@"title2",@"title3",@"title2",@"title3",@"title2",@"title3",@"title2",@"title3",@"title2",@"title3",@"title2",@"title3"];
    if (section == 0) {
        buleView = nil;
    }else{
        if (section == 1) {
            buleView.backgroundColor = [UIColor yellowColor];
        }else{
            buleView.backgroundColor = [UIColor purpleColor];
        }
        
    }
    
    return buleView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 50;
}

@end
