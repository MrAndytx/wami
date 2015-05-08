//
//  myticketViewController.m
//  哇米
//
//  Created by wenga on 15/1/9.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "myticketViewController.h"
#import "ticketCell.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "ticketModel.h"
#import "TKTHongBaoTableViewCell.h"
#import "TKTCouponTableViewCell.h"
#import "TKTDaiJingQuanTableViewCell.h"
#import "MJRefresh.h"

#define URL @"http://www.waomi.com/mapi/androidPhone/mycoupon"
@interface myticketViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    MJRefreshBaseView *baseView;
    MJRefreshHeaderView *headerView;
    MJRefreshFooterView *footerView;
}

@property (weak, nonatomic) IBOutlet UITableView *tickettableview;
@property (weak, nonatomic) IBOutlet UIImageView *backredline1;
@property (weak, nonatomic) IBOutlet UIImageView *backredline2;
@property (weak, nonatomic) IBOutlet UIImageView *backredline3;
@property (weak, nonatomic) IBOutlet UIButton *youhuiquanbtn;

@end

@implementation myticketViewController
{
    NSString *flag;
    NSMutableArray *dataArray;
    NSString *nextUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = @"1";
    _youhuiquanbtn.selected = YES;
    _backredline1.backgroundColor = [UIColor redColor];
    self.tabBarController.tabBar.hidden = YES;
    
    
    [_tickettableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self getTicketwithType:flag url:URL];
    
    [self initfooterview];
    [self initheaderview];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
}

#pragma mark 刷新
//下拉刷新相关
- (void)dealloc{
    [footerView free];
    [headerView free];
}

- (void)initfooterview{
    footerView = [[MJRefreshFooterView alloc]initWithScrollView:_tickettableview];
    footerView.delegate = self;
}

- (void)initheaderview{
    headerView = [[MJRefreshHeaderView alloc]initWithScrollView:_tickettableview];
    headerView.delegate = self;
}

//下拉刷新代理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    baseView = refreshView;
    if (baseView == footerView) {
        
        if ([nextUrl length] >0) {
//            [self sendRequest:type OrderState:state url:nextUrl];
            [self getTicketwithType:flag url:nextUrl];
        }
        [self performSelector:@selector(hidden) withObject:nil afterDelay:1.5];
    }
    if (baseView == headerView) {
        dataArray = [NSMutableArray array];
        [self getTicketwithType:flag url:URL];
        baseView = refreshView;
        [self performSelector:@selector(hidden) withObject:nil afterDelay:1.5];
    }
    
}

- (void)hidden
{
    if (baseView == headerView)
    {
        [headerView endRefreshing];
    }
    else
    {
        [footerView endRefreshing];
    }
}

#pragma mark 请求方法
- (void)getTicketwithType:(NSString *)type url:(NSString *)url
{
    
    
    
    dataArray = [NSMutableArray array];
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *option = [[NSMutableDictionary alloc]init];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *user_uid = [userInfo objectForKey:@"user_uid"];
    [option setObject:user_uid forKey:@"uid"];
    [option setObject:type forKey:@"coupon_type"];
    [dic_all setObject:option forKey:@"option"];
    //    NSLog(@"%@",dic_all);
    AFHTTPRequestOperationManager *manager2 = [[AFHTTPRequestOperationManager alloc]init];
    manager2.responseSerializer = [AFJSONResponseSerializer serializer];
    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager2 POST:url parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
       NSLog(@"券包---%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            
                //红包
            [dataArray addObjectsFromArray:[LBMyticketModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"option"] error:nil]];
            
           [_tickettableview reloadData];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
    }];
    
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



- (IBAction)clickTopBtn:(UIButton *)sender {
    for (int i = 50; i<53; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        if (i!=sender.tag) {
            btn.selected = NO;
        }
    }
    switch (sender.tag) {
        case 50:
        {
            flag = @"1";
            [self getTicketwithType:flag url:URL];
            [_backredline1 setBackgroundColor:[UIColor redColor]];
            [_backredline2 setBackgroundColor:[UIColor clearColor]];
            [_backredline3 setBackgroundColor:[UIColor clearColor]];
         
        }
            break;
        case 51:
        {
            [_backredline1 setBackgroundColor:[UIColor clearColor]];
            [_backredline2 setBackgroundColor:[UIColor redColor]];
            [_backredline3 setBackgroundColor:[UIColor clearColor]];
            flag = @"2";
            [self getTicketwithType:flag url:URL];
           
        }
            break;
        case 52:
        {
            [_backredline1 setBackgroundColor:[UIColor clearColor]];
            [_backredline2 setBackgroundColor:[UIColor clearColor]];
            [_backredline3 setBackgroundColor:[UIColor redColor]];
            flag = @"3";
             [self getTicketwithType:flag url:URL];
           
        }
            break;
        default:
            break;
    }
    if (sender.selected) {
        sender.selected = NO;
        
    }
    else{
        sender.selected = YES;
    }
}


#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([flag isEqualToString:@"1"]) {
       TKTHongBaoTableViewCell *hongbaoCell = [tableView dequeueReusableCellWithIdentifier:@"hongbaoCell"];
        if (hongbaoCell ==nil) {
            hongbaoCell = [[[NSBundle mainBundle]loadNibNamed:@"TKTHongBaoTableViewCell" owner:self options:nil]firstObject];
        }
        [hongbaoCell setData:dataArray[indexPath.row]];
        return hongbaoCell;
        
    }else if ([flag isEqualToString:@"2"])
    {
        TKTCouponTableViewCell *couponCell = [tableView dequeueReusableCellWithIdentifier:@"couponCell"];
        if (couponCell ==nil) {
            couponCell = [[[NSBundle mainBundle]loadNibNamed:@"TKTCouponTableViewCell" owner:self options:nil]firstObject];
        }
        [couponCell setData:dataArray[indexPath.row]];
        return couponCell;
    }else
    {
        TKTDaiJingQuanTableViewCell *daijingCell = [tableView dequeueReusableCellWithIdentifier:@"daijingCell"];
        if (daijingCell ==nil) {
            daijingCell = [[[NSBundle mainBundle]loadNibNamed:@"TKTDaiJingQuanTableViewCell" owner:self options:nil]lastObject];
        }
        [daijingCell setData:dataArray[indexPath.row]];
        return daijingCell;
    }
    /*ticketCell *cell = nil;
    ticketModel *model = nil;
    
    
    UIView *buttomLine = [[UIView alloc]initWithFrame:CGRectMake(0, cell.contentView.frame.size.height-0.5, cell.contentView.frame.size.width, 0.5)];
    [buttomLine setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [cell.contentView addSubview:buttomLine];
    
    if ([flag isEqualToString:@"1"]) {
        model = hbArr[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:@"youhuiquan"];
        
    }
    else if([flag isEqualToString:@"2"]){
        model = yhqArr[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:@"hongbao"];
        

    }
    else{
        model = djqArr[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:@"daijinquan"];
        
    }
    [cell setData:model];
    return cell;*/
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
@end
