//
//  myrateViewController.m
//  哇米
//
//  Created by wenga on 15/1/16.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "myrateViewController.h"
#import "myrateCell.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "myRateModer.h"
#import "MJRefresh.h"
#import "LBMycommentModel.h"

#define URL @"http://www.waomi.com/mapi/androidPhone/mycomment"
@interface myrateViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>{
    MJRefreshBaseView *_baseview;
    MJRefreshFooterView *_footerview;
    MJRefreshHeaderView *_headerview;
    
    NSString *nexturl;
    
    NSMutableArray *dataArray;
}

@property (weak, nonatomic) IBOutlet UITableView *MyCommentTBV;

@end

@implementation myrateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = [NSMutableArray array];
    [self initfooterview];
    [self initheaderview];
    [self getMyCommentwithURL:URL];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
//    self.tabBarController.tabBar.hidden = YES;
}


- (void)getMyCommentwithURL:(NSString *)url
{
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *option = [[NSMutableDictionary alloc]init];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *user_uid = [userInfo objectForKey:@"user_uid"];
    [option setObject:user_uid forKey:@"uid"];
    [dic_all setObject:option forKey:@"option"];
    //    NSLog(@"%@",dic_all);
    AFHTTPRequestOperationManager *manager2 = [[AFHTTPRequestOperationManager alloc]init];
    manager2.responseSerializer = [AFJSONResponseSerializer serializer];
    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager2 POST:url parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"res---%@",responseObject);
        nexturl = responseObject[@"nexturl"];
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
           [dataArray addObjectsFromArray:[LBMycommentModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"option"] error:nil]];
            [_MyCommentTBV reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
    }];
    
}

//下拉刷新相关
- (void)dealloc{
    [_footerview free];
    [_headerview free];
}

- (void)initfooterview{
    _footerview = [[MJRefreshFooterView alloc]initWithScrollView:_MyCommentTBV];
    _footerview.delegate = self;
}

- (void)initheaderview{
    _headerview = [[MJRefreshHeaderView alloc]initWithScrollView:_MyCommentTBV];
    _headerview.delegate = self;
}

//下拉刷新代理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    _baseview = refreshView;
    if (_baseview == _footerview) {
    
    if (![nexturl isEqual:@"null"]) {
        [self getMyCommentwithURL:nexturl];
        
    }
        [self performSelector:@selector(hidden) withObject:nil afterDelay:1.5];
    }
        if (_baseview == _headerview) {
            dataArray = [NSMutableArray array];
            [self getMyCommentwithURL:URL];
            _baseview = refreshView;
            [self performSelector:@selector(hidden) withObject:nil afterDelay:1.5];
        }
    
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


- (IBAction)backbtn:(id)sender {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    int way = app.myordershowway;
    if (way == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }

}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - scrollview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myRateModer *model = dataArray[indexPath.row];
    myrateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mypingjia"];
    [cell reloadCellWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    return 0;
}
@end
