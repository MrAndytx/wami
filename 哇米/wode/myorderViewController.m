//
//  myorderViewController.m
//  哇米
//
//  Created by wenga on 15/1/9.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "myorderViewController.h"
#import "myorderCell.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "orderModel.h"
#import "JSONModel.h"
#import "MJRefresh.h"
#import "orderViewController.h"

#define URL @"http://www.waomi.com/mapi/androidPhone/myorder"
@interface myorderViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    MJRefreshBaseView *_baseview;
    MJRefreshFooterView *_footerview;
    MJRefreshHeaderView *_headerview;
    NSMutableArray *dataArray;
    NSString *tempStr;
    
    NSString *nextUrl;
    NSString *state;
    NSString *type;
}

@property (weak, nonatomic) IBOutlet UIView *daixiadanview;
@property (weak, nonatomic) IBOutlet UIView *daipingjiaview;
@property (weak, nonatomic) IBOutlet UIView *quanbudingdanview;
@property (weak, nonatomic) IBOutlet UITableView *myordertableview;
@property (weak, nonatomic) IBOutlet UIButton *allorder;
@property (weak, nonatomic) IBOutlet UIView *nonDataView;
@property (weak, nonatomic) IBOutlet UIButton *nonDataBtn;

@end

@implementation myorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = [NSMutableArray array];
    
    [self initfooterview];
    [self initheaderview];
    
    // Do any additional setup after loading the view.
    [_daixiadanview setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [_daipingjiaview setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [_quanbudingdanview setBackgroundColor:[UIColor redColor]];
    _allorder.selected = YES;
    
    _nonDataView.hidden = YES;
    _nonDataBtn.layer.cornerRadius = 4.0f;
    
    _nonDataBtn.layer.borderColor = [UIColor colorWithRed:206/255.0f green:122/255.0f blue:84/255.0f alpha:1.0].CGColor;
    _nonDataBtn.layer.borderWidth = 1.0f;
    
    
    [_nonDataBtn setTitleColor:[UIColor colorWithRed:206/255.0f green:122/255.0f blue:84/255.0f alpha:1.0] forState:UIControlStateNormal];
    
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    tempStr = app.myviewstr;
    [_myordertitle setText:[NSString stringWithFormat:@"%@",tempStr]];
    
    state = @"1";
    if ([tempStr isEqualToString:@"外卖订单"]) {
       type = @"1";
    }else if ([tempStr isEqualToString:@"点菜订单"])
    {
        type = @"2";
    }
    else if ([tempStr isEqualToString:@"预订订单"])
    {
        type = @"3";
    }
    [self sendRequest:type OrderState:@"1" url:URL];
    
//    [self setupRefresh];
}



- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}


- (void)sendRequest:(NSString *)types OrderState:(NSString *)states url:(NSString *)url
{
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *option = [[NSMutableDictionary alloc]init];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *user_uid = [userInfo objectForKey:@"user_uid"];
    [option setObject:user_uid forKey:@"uid"];
    
    [option setObject:types forKey:@"order_way"];
    [option setObject:states forKey:@"order_state"];
    [dic_all setObject:option forKey:@"option"];
    AFHTTPRequestOperationManager *manager2 = [[AFHTTPRequestOperationManager alloc]init];
    manager2.responseSerializer = [AFJSONResponseSerializer serializer];
    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager2 POST:url parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
//        for (NSDictionary *dic in responseObject[@"data"][@"option"]) {
//            orderModel *model = [[orderModel alloc]initWithDictionary:dic error:nil];
//            [dataArray addObject:model];
//        }
//            NSLog(@"dataArray---%@",dataArray);
       
//        [_myordertableview reloadData];
        
        NSLog(@"res -%@",responseObject);
        nextUrl = responseObject[@"nexturl"];
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [dataArray addObjectsFromArray:[orderModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"option"] error:nil]];
            
        }
        if (dataArray.count ==0) {
            _nonDataView.hidden = NO;
            _myordertableview.hidden = YES;
            if ([states isEqualToString:@"0"]) {
                [_nonDataBtn setTitle:@"立即点菜" forState:UIControlStateNormal];
            }else if ([states isEqualToString:@"1"]) {
                [_nonDataBtn setTitle:@"立即预定" forState:UIControlStateNormal];
            }else if ([states isEqualToString:@"2"]) {
                [_nonDataBtn setTitle:@"立即评价" forState:UIControlStateNormal];
            }
        }else
        {
            _nonDataView.hidden = YES;
            _myordertableview.hidden = NO;
        }
        [_myordertableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
    }];
}

#pragma mark action 方法
- (IBAction)nonDataAction:(id)sender {
    if ([state isEqualToString:@"0"]) {
        NSLog(@"跳转到点菜");
    }else if ([state isEqualToString:@"1"]) {
        NSLog(@"跳转到评价");
    }else if ([state isEqualToString:@"2"]) {
        NSLog(@"跳转预定");
    }
}


#pragma mark 刷新
//下拉刷新相关
- (void)dealloc{
    [_footerview free];
    [_headerview free];
}

- (void)initfooterview{
    _footerview = [[MJRefreshFooterView alloc]initWithScrollView:_myordertableview];
    _footerview.delegate = self;
}

- (void)initheaderview{
    _headerview = [[MJRefreshHeaderView alloc]initWithScrollView:_myordertableview];
    _headerview.delegate = self;
}

//下拉刷新代理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
     _baseview = refreshView;
    if (_baseview == _footerview) {

    if ([nextUrl length] >0) {
    [self sendRequest:type OrderState:state url:nextUrl];
        
    }
        [self performSelector:@selector(hidden) withObject:nil afterDelay:1.5];
 }
       if (_baseview == _headerview) {
           dataArray = [NSMutableArray array];
            [self sendRequest:type OrderState:state url:URL];
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


#pragma mark Segue传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    myorderCell *cell = (myorderCell *)sender;
    orderViewController *destinationVC = segue.destinationViewController;
    NSIndexPath *indexPath = [_myordertableview indexPathForCell:cell];
    
    orderModel *model = dataArray[indexPath.row];
    destinationVC.orderId = model.order_id;
    destinationVC.userId = model.uid;
    
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
- (IBAction)clickTopBtn:(UIButton *)sender {
    dataArray = [NSMutableArray array];
       for (int i = 40; i<43; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        if (i!=sender.tag) {
            btn.selected = NO;
        }
    }
    switch (sender.tag) {
        case 40:
        {
            state = @"0";
            
            [self sendRequest:type OrderState:state url:URL];
           
            
            [_daixiadanview setBackgroundColor:[UIColor redColor]];
            [_daipingjiaview setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
            [_quanbudingdanview setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
        }
            break;
        case 41:
        {
             state = @"2";
            [self sendRequest:type OrderState:state url:URL];
            
            [_daixiadanview setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
            [_daipingjiaview setBackgroundColor:[UIColor redColor]];
            [_quanbudingdanview setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
        }
            break;
        case 42:
        {
             state = @"1";
           [self sendRequest:type OrderState:state url:URL];

           
             [_daixiadanview setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
            [_daipingjiaview setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
            [_quanbudingdanview setBackgroundColor:[UIColor redColor]];
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
    myorderCell *cell = [[myorderCell alloc]init];
    cell = [tableView dequeueReusableCellWithIdentifier:@"myordercell"];
    if (dataArray.count !=0) {
        [cell setData:dataArray [indexPath.row]];
    }
    
    /*
    switch (indexPath.row%4) {
        case 0:{
        }
            break;
            
        case 1:{
            [cell.firstbtn setImage:[UIImage imageNamed:@"wm_order_operate_ok"] forState:UIControlStateNormal];
            [cell.secondbtn setImage:nil forState:UIControlStateNormal];
            cell.secondbtn.enabled = NO;
            [cell.secondbtn setTitle:@"消费中" forState:UIControlStateNormal];
            [cell.secondbtn setTitleColor:[UIColor colorWithRed:1 green:102/255.0 blue:0 alpha:1] forState:UIControlStateNormal];
            [cell.secondbtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
        }
            break;
            
        case 2:{
            [cell.firstbtn setImage:[UIImage imageNamed:@"a_ay"] forState:UIControlStateNormal];
            [cell.secondbtn setImage:nil forState:UIControlStateNormal];
            cell.secondbtn.enabled = NO;
            [cell.secondbtn setTitle:@"交易成功" forState:UIControlStateNormal];
            [cell.secondbtn setTitleColor:[UIColor colorWithRed:0 green:119/255.0 blue:16/255.0 alpha:1] forState:UIControlStateNormal];
            [cell.secondbtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
        }
            break;
            
        case 3:{
            [cell.secondbtn setImage:nil forState:UIControlStateNormal];
            cell.secondbtn.enabled = NO;
            [cell.secondbtn setTitle:@"交易成功" forState:UIControlStateNormal];
            [cell.secondbtn setTitleColor:[UIColor colorWithRed:0 green:119/255.0 blue:16/255.0 alpha:1]  forState:UIControlStateNormal];
            [cell.secondbtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
        }
            break;
        default:
            break;
    }*/
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 172;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    orderViewController *orderDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"orderdetailvc"];
    orderModel *model = dataArray[indexPath.row];
    orderDetailVC.orderId = model.order_id;
    orderDetailVC.userId = model.uid;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
    

}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
