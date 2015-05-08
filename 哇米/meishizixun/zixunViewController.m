//
//  zixunViewController.m
//  哇米
//
//  Created by wenga on 15/1/6.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "zixunViewController.h"
#import "zixunCell.h"
#import "MJRefresh.h"
#import "topnavigation.h"

@interface zixunViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    MJRefreshBaseView *_baseview;
    MJRefreshFooterView *_footerview;
    MJRefreshHeaderView *_headerview;
}

@property (weak, nonatomic) IBOutlet UITableView *zixuntableview;

@end

@implementation zixunViewController

- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
     self.navigationController.navigationBarHidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"美食咨询"];
    [self.navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"wm_top_arrow"]];
    [self initfooterview];
    [self initheaderview];


  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc{
    [_footerview free];
    [_headerview free];
}

- (void)initfooterview{
    _footerview = [[MJRefreshFooterView alloc]initWithScrollView:_zixuntableview];
    _footerview.delegate = self;
}

- (void)initheaderview{
    _headerview = [[MJRefreshHeaderView alloc]initWithScrollView:_zixuntableview];
    _headerview.delegate = self;
}

//下拉刷新代理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    _baseview = refreshView;
    [self performSelector:@selector(hidden) withObject:nil afterDelay:1.5];
}
- (void)hidden
{
    if (_baseview == _headerview)
    {
        [_headerview endRefreshing];
    }
    else
    {
        [_footerview endRefreshing];
    }
}

#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    zixunCell *zixuncell = nil;
    
   
    if (indexPath.row%3+1 == 1) {
       zixuncell = [tableView dequeueReusableCellWithIdentifier:@"zixuncell1" forIndexPath:indexPath];
    }
    else if(indexPath.row%3+1 == 2){
        zixuncell = [tableView dequeueReusableCellWithIdentifier:@"zixuncell3" forIndexPath:indexPath];    }
    else{
        zixuncell = [tableView dequeueReusableCellWithIdentifier:@"zixuncell2" forIndexPath:indexPath];
    }
       return zixuncell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row%3+1 == 1){
        return 60;
    }
    else if (indexPath.row%3+1 == 2){
        return 80;
    }
    else{
        return 120;
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(35, 0, tableView.frame.size.width-35-10, 20)];
//    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(35, 1, view.frame.size.width-35-30, 18)];
//    [label setText:@"2014.10.18 星期天"];
//    [label setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]];
//    [label setFont:[UIFont systemFontOfSize:11]];
//    [view addSubview:label];
//    
//    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width, 1, 30, 18)];
//    [time setText:@"昨天"];
//    [time setFont:[UIFont systemFontOfSize:11]];
//    [time setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]];
//    time.textAlignment=UITextAlignmentRight;
//    [view addSubview:time];
//    
//    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(35, 0, view.frame.size.width, 1)];
//    [line1 setBackgroundColor:[UIColor colorWithRed:235/255.000 green:235/255.000 blue:235/255.000 alpha:1]];
//    [view addSubview:line1];
//    
//    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(35, 19, view.frame.size.width, 1)];
////    [line1 setBackgroundColor:[UIColor redColor]];
//    [view addSubview:line2];
//    
//    return view;
//}
@end
