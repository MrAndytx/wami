
//
//  accountViewController.m
//  哇米
//
//  Created by wenga on 15/1/9.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "accountViewController.h"
#import "accountCell.h"
#import "jifen&dengjiViewController.h"
#import "common.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "myViewController.h"

@interface accountViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *passwordbg;
@property (weak, nonatomic) IBOutlet UIView *passwordview;

@property (nonatomic,assign)NSMutableDictionary* user_info;
@property (nonatomic,assign)NSMutableArray *arr;

@property (weak, nonatomic) IBOutlet UITableView *settingtableview;

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (nonatomic,assign) int key;
@end

@implementation accountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _user_info = [NSMutableDictionary dictionary];
    _arr = [NSMutableArray array];
    NSArray *array = [[NSArray alloc]initWithObjects:@"未绑定手机", @"未设置支付密码",@"我的送餐地址",@"积分与等级",@"接收新消息提醒",@"帮助与反馈",@"关于哇米",@"退出",nil];
    for (int i = 0; i<array.count; i++) {
        [_arr addObject:array[i]];
    }
    [_passwordbg setHidden:YES];
    _key = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self getUserInfo];
    
   }
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [_passwordbg setHidden:YES];
    self.tabBarController.tabBar.hidden = YES;
    
}

#pragma mark action 方法
- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)resetpassword:(id)sender {
    [_passwordbg setHidden:NO];
}

- (IBAction)sureBtn:(id)sender
{
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *option = [[NSMutableDictionary alloc]init];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *user_uid = [userInfo objectForKey:@"user_uid"];
    [option setObject:user_uid forKey:@"uid"];
    [dic_all setObject:option forKey:@"option"];
    AFHTTPRequestOperationManager *manager2 = [[AFHTTPRequestOperationManager alloc]init];
    manager2.responseSerializer = [AFJSONResponseSerializer serializer];
    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager2 POST:@"http://www.waomi.com/mapi/androidPhone/userinfo" parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"%@",responseObject);
        _user_info = responseObject[@"data"][@"option"];
        [_username setText:[NSString stringWithFormat:@"用户名:%@",_user_info[@"nick_name"]]];
        
        //        [_settingtableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
    }];

    
}


- (void)keyboard{
    _key = 1;
}

- (void)getUserInfo{
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *option = [[NSMutableDictionary alloc]init];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *user_uid = [userInfo objectForKey:@"user_uid"];
    [option setObject:user_uid forKey:@"uid"];
    [dic_all setObject:option forKey:@"option"];
    AFHTTPRequestOperationManager *manager2 = [[AFHTTPRequestOperationManager alloc]init];
    manager2.responseSerializer = [AFJSONResponseSerializer serializer];
    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager2 POST:@"http://www.waomi.com/mapi/androidPhone/userinfo" parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        _user_info = responseObject[@"data"][@"option"];
        [_username setText:[NSString stringWithFormat:@"用户名:%@",_user_info[@"nick_name"]]];
        
//        [_settingtableview reloadData];
        
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
    }];
    
}


//点击屏幕退出登录界面
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    if (!([touch.view isEqual:_passwordview])) {
        if (_key == 1) {
            [self.view endEditing:YES];
            _key = 0;
        }
        else{
            _passwordbg.hidden = YES;
        }
    }
}

#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    accountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accountcell"];
    [cell.switchbtn setFrame:CGRectMake(0, 0, 40, 20)];
    //设置label
//    if ([_user_info objectForKey:@"nick_name"]) {
//        [_username setText:[NSString stringWithFormat:@"用户名:%@",_user_info[@"nick_name"]]];
//    };
//    
        if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell.shuoming setText:@"(绑定手机号码，账户更安全)"];
        }
        else if (indexPath.row == 1){
            [cell.shuoming setText:@"(设置支付密码后，可以使用余额支付)"];
        }
        else{
            cell.shuoming.hidden = YES;
        }
    }
    
    //设置右边箭头和开关
    if (indexPath.section == 1&&indexPath.row == 0) {
        cell.rightarrow.hidden = YES;
    }
    else{
        [cell.switchbtn setHidden:YES];
    }
    [cell.accountlab setText:_arr[indexPath.section*4+indexPath.row]];
    
    //设置底部分割线
    if (indexPath.row != 3) {
        cell.bottomline.hidden = YES;
    }

    return cell;
    
    }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    else{
        return 10;
    };
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 5;
    }
    else{
        return 0;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (indexPath.section == 0 && indexPath.row == 3) {
        jifen_dengjiViewController *jifenview = [sto instantiateViewControllerWithIdentifier:@"jifenview"];
        [self.navigationController pushViewController:jifenview animated:YES];
    }
    
//    if (indexPath.section == 1&&indexPath.row == 3) {
//        NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
//        [userinfo removeObjectForKey:@"user_uid"];
//        [self.navigationController popViewControllerAnimated:YES];
//        
//    }
}
@end
