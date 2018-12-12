//
//  ViewController.m
//  UITableViewDemo
//
//  Created by 蔡强 on 2017/5/25.
//  Copyright © 2017年 caiqiang. All rights reserved.
//

#import "ViewController.h"
#import "CQNotifManager.h"

// 判断是否是iPhone X系列机型
#define iPhoneX (([[UIApplication sharedApplication] statusBarFrame].size.height == 44.0f) ? (YES):(NO))
// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UIView *naviView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //------- 接收状态栏点击的通知 -------//
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleStatusBarTaped) name:CQStatusBarDidTapNotification object:nil];
    
    //------- tableView -------//
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    //------- 表头 -------//
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.imageView.image = [UIImage imageNamed:@"tableview_header"];
    self.tableView.tableHeaderView = self.imageView;
    
    //------- 导航栏 -------//
    self.naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, NAVIGATION_BAR_HEIGHT)];
    self.naviView.backgroundColor = [UIColor greenColor];
    self.naviView.alpha = 0; // 默认透明
    [self.view addSubview:self.naviView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, self.view.frame.size.width, 44)];
    [self.naviView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"title";
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
}

#pragma mark - User Action

// 处理用户点击状态栏的事件
- (void)handleStatusBarTaped {
    self.tableView.scrollEnabled = NO;
    self.tableView.contentInset = UIEdgeInsetsZero;
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentOffset = CGPointZero;
    } completion:^(BOOL finished) {
        self.tableView.scrollEnabled = YES;
    }];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat tableHeaderViewHeight = CGRectGetHeight(self.tableView.tableHeaderView.bounds);
    // 修改导航栏透明度
    self.naviView.alpha = offsetY / tableHeaderViewHeight;
    // 修改组头悬停位置
    if (offsetY >= tableHeaderViewHeight) {
        // 留出导航栏的位置
        self.tableView.contentInset = UIEdgeInsetsMake(NAVIGATION_BAR_HEIGHT, 0, 0, 0);
    } else {
        self.tableView.contentInset = UIEdgeInsetsZero;
    }
}

#pragma mark - UITableView Delegate & DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellReuseID = @"cellReuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组", indexPath.section];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headerReuseID = @"headerReuseID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseID];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerReuseID];
    }
    headerView.textLabel.text = [NSString stringWithFormat:@"组头:第%ld组", section];
    headerView.backgroundView.backgroundColor = [UIColor redColor];
    return headerView;
}

// 组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

@end
