//
//  myViewController.m
//  哇米
//
//  Created by wenga on 15/1/5.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "myViewController.h"
#import "myCell.h"
#import "myrateViewController.h"
#import "myorderViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "NSString+DES.h"
#import "accountModel.h"
#import "accountViewController.h"
#import "myticketViewController.h"
#import "mycollectViewController.h"

@interface myViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //登录
    NSString *login_username;
    NSString *login_password;
    NSString *sign;
    
    NSMutableArray *_dataSource;
    int count;
    UILabel *countTimeLabel;
    NSString *dcredStr;
    NSString *wmredStr;
    NSString *ydredStr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *accountmanaview;//登录注册时旁边灰色区域
@property (weak, nonatomic) IBOutlet UIView *loginview;//登录框
@property (nonatomic,strong) UITextField *_field;
@property (weak, nonatomic) IBOutlet UIView *registerview;//注册框
@property (weak, nonatomic) IBOutlet UIButton *sendIdentityBtn;//发送验证码按钮
@property (weak, nonatomic) IBOutlet UIView *registerPhoneNumView;//手机号View
@property (weak, nonatomic) IBOutlet UITextField *identityMsgTextField;//验证手机号
@property (weak, nonatomic) IBOutlet UITextField *registerPwdTextField;//注册密码



@property (weak, nonatomic) IBOutlet UIView *ticket;//我的券包view
@property (weak, nonatomic) IBOutlet UIView *collection;//我的收藏view
@property (weak, nonatomic) IBOutlet UIView *collectionandticket;//券包收藏边背景view
@property (weak, nonatomic) IBOutlet UILabel *mycollectionnum;//收藏数量
@property (weak, nonatomic) IBOutlet UILabel *myticketnum;//券包数量

@property (weak, nonatomic) IBOutlet UITextField *login_username;//登录用户名textfile
@property (weak, nonatomic) IBOutlet UITextField *login_password;//登录密码textfile

@property (nonatomic,assign)int key;

@property (weak, nonatomic) IBOutlet UIView *hadlogin;//已登录界面（显示用户余额、积分）
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *user_grade;
@property (weak, nonatomic) IBOutlet UILabel *user_cash_sum;
@property (weak, nonatomic) IBOutlet UILabel *user_integral;
@property (weak, nonatomic) IBOutlet UIImageView *user_profile;

@property (nonatomic,assign)NSMutableDictionary *user_info;

@property (weak, nonatomic) IBOutlet UIView *didnotlogin;//未登录（显示登录注册按钮）
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;//登录密码、账户错误

@property (weak, nonatomic) IBOutlet UILabel *loginTip;//未登录提示先登录

@property (weak, nonatomic) IBOutlet UITextField *identityTextField;//手机号码


@end

@implementation myViewController

- (void)viewWillAppear:(BOOL)animated{
     self.navigationController.navigationBarHidden = YES;
      self.tabBarController.tabBar.hidden = NO;
     _key = 0;
    [self addseperator];
    [self redLightRequest];
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    if ([userdefault objectForKey:@"user_uid"]) {
        [self getUserInfo];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _user_profile.layer.cornerRadius = 30;
    _user_profile.layer.borderColor = [[UIColor whiteColor]CGColor];
    _user_profile.layer.borderWidth = 5;
    _user_profile.clipsToBounds = YES;

    _user_info = [NSMutableDictionary dictionary];
    _dataSource = [NSMutableArray array];
    _accountmanaview.hidden = YES;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard) name:UIKeyboardWillChangeFrameNotification object:nil];
  
    count = 0;
    countTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 8, 60, 24)];
    countTimeLabel.font = [UIFont systemFontOfSize:12];
//   NSString *str = [NSString encryptUseDES:@"addsifjid" key:@"edqHZr6Rmarq2tYC3wTzPS5acZNGBirp" ];
//   NSLog(@"%@",str);
}


#pragma mark Custom 
- (IBAction)registerBtn:(UIButton *)sender {
    if ([_identityMsgTextField.text isEqualToString:@""]) {
        SHOW_ALERT(@"提示", @"手机验证码不能为空");
    }else if ([_registerPwdTextField.text isEqualToString:@""])
    {
        SHOW_ALERT(@"提示", @"密码不能为空");
    }else
    {
        
       
     
      
                //手机注册接口
                NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
                NSMutableDictionary *listoption = [[NSMutableDictionary alloc]init];
                
                NSString *registerPwd = [NSString base64StringFromText:_identityMsgTextField.text withKey:@"edqHZr6Rmarq2tYC3wTzPS5acZNGBirp"];
                [listoption setObject:_identityTextField.text forKey:@"hefan_mobile"];
                [listoption setObject:_identityMsgTextField.text forKey:@"verify_code"];
                [listoption setObject:registerPwd forKey:@"hefan_password"];
                [dic_all setObject:listoption forKey:@"option"];
                
                AFHTTPRequestOperationManager *registerManager = [AFHTTPRequestOperationManager manager];
                registerManager.responseSerializer = [AFJSONResponseSerializer serializer];
                registerManager.requestSerializer = [AFJSONRequestSerializer serializer];
                NSString *urlString2 = [NSString stringWithFormat:@"http://www.waomi.com/mapi/androidPhone/register"];
                [registerManager POST:urlString2 parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    //            NSLog(@"res---%@",responseObject);
                    if([responseObject[@"status"] isEqualToString:@"0"])
                    {
                        SHOW_ALERT(@"提示", responseObject[@"error"]);
                        _identityMsgTextField.text = @"";
                        _registerPwdTextField.text = @"";
                    }else
                    {
                        NSLog(@"成功后的res ---%@",responseObject);
                        _registerview.hidden = YES;
                        _loginview.hidden = NO;
                    }
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"error :%@",error);
                }];

        }
    
}


//忘记密码按钮
- (IBAction)forgetPwdBtn:(id)sender
{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *array = @[@"1",@"2",@"3",@"4",@"3"];
    for (int i=0; i<array.count; i++) {
        if ([array[i] intValue]>=2) {
            if (!([dataArray containsObject:array[i]])) {
                [dataArray addObject:array[i]];
            }
            
            NSLog(@"dataArray is--%@",dataArray);
        }
    }
    /*
    if ([_login_username.text length] !=11)
    {
        SHOW_ALERT(@"提示", @"手机码号无效")
        
    }else
    {
        //找回登陆密码短信验证码
        NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
        NSMutableDictionary *listoption = [[NSMutableDictionary alloc]init];
        NSString *commit = [NSString stringWithFormat:@"%@%@",_identityTextField.text,@"smsRuleWithForgetPwd"];
        NSString *signature = [NSString base64StringFromText:commit withKey:@"edqHZr6Rmarq2tYC3wTzPS5acZNGBirp"];
        [listoption setObject:_identityTextField.text forKey:@"mobile"];
        [listoption setObject:@"smsRuleWithForgetPwd" forKey:@"action"];
        [listoption setObject:signature forKey:@"sign"];
        [dic_all setObject:listoption forKey:@"option"];
        
        AFHTTPRequestOperationManager *identityManager = [[AFHTTPRequestOperationManager alloc]init];
        identityManager.responseSerializer = [AFJSONResponseSerializer serializer];
        identityManager.requestSerializer = [AFJSONRequestSerializer serializer];
        NSString *urlString = [NSString stringWithFormat:@"http://www.waomi.com/mapi/androidPhone/sendVerifyCode"];
        [identityManager POST:urlString parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //            NSLog(@"res---%@",responseObject);
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                _sendIdentityBtn.hidden = YES;
                
                [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daojishi:) userInfo:nil repeats:YES];
                [_registerPhoneNumView addSubview:countTimeLabel];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error :%@",error);
        }];

    }*/
}





- (void)sendRequest:(NSString *)url withKey:(NSString *)key andValue:(NSString *)value
{
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *option = [[NSMutableDictionary alloc]init];
    [option setObject:login_username forKey:@"hefan_username"];
    [option setObject:login_password forKey:@"hefan_password"];
    [option setObject:sign forKey:@"sign"];
    [dic_all setObject:option forKey:@"option"];
//    NSLog(@"%@",dic_all);
    AFHTTPRequestOperationManager *manager2 = [[AFHTTPRequestOperationManager alloc]init];
    manager2.responseSerializer = [AFJSONResponseSerializer serializer];
    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager2 POST:url parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        if ([responseObject[@"data"] objectForKey:@"account"]) {
        NSUserDefaults *accountdefault = [NSUserDefaults standardUserDefaults];
        [accountdefault setObject:responseObject[@"data"][@"account"][@"uid"] forKey:@"user_uid"];
        [self.view endEditing:YES];
        [self getUserInfo];
    }
        else{
            _errorLabel.hidden = NO;
            [_errorLabel setText:responseObject[@"error"]];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:3.0];

        }
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
            }];

}

//错误信息消失
- (void)dismiss{
    _errorLabel.hidden = YES;
    _loginTip.hidden = YES;
}
- (void)getUserInfo{
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
    [manager2 POST:@"http://www.waomi.com/mapi/androidPhone/userinfo" parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _user_info = responseObject[@"data"][@"option"];
        

        _accountmanaview.hidden = YES;
        _didnotlogin.hidden = YES;
        _hadlogin.hidden = NO;
        [self updateUserActivityState];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
    }];

}

#pragma 红点提示请求
- (void)redLightRequest
{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    if ([userInfo objectForKey:@"user_uid"])
    {
        NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
        NSMutableDictionary *option = [[NSMutableDictionary alloc]init];
        
        NSString *user_uid = [userInfo objectForKey:@"user_uid"];
        [option setObject:user_uid forKey:@"uid"];
        [dic_all setObject:option forKey:@"option"];
        AFHTTPRequestOperationManager *manager2 = [[AFHTTPRequestOperationManager alloc]init];
        manager2.responseSerializer = [AFJSONResponseSerializer serializer];
        manager2.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager2 POST:@"http://www.waomi.com/mapi/androidPhone/checkpoint" parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"red---%@",responseObject);
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                NSDictionary *redDic = responseObject[@"data"][@"option"];
                dcredStr = redDic[@"dc_order"];
                wmredStr = redDic[@"wm_order"];
                ydredStr = redDic[@"yd_order"];
                }
            [_tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"error: %@",error);
        }];

    }
    
    
}

//登录后更新界面
- (void)updateUserActivityState{
    [_username setText:_user_info[@"nick_name"]];
    [_user_grade setImage:[UIImage imageNamed:[NSString stringWithFormat:@"wm_user_v%@",_user_info[@"user_grade"]]]];
    [_user_cash_sum setText:[NSString stringWithFormat:@"余额：%@元",_user_info[@"cash_sum"]]];
    [_user_integral setText:[NSString stringWithFormat:@"积分：%@",_user_info[@"user_integral"]]];
    [_user_profile setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_user_info[@"profile"]]]]];
    [_mycollectionnum setText:_user_info[@"collect_total"]];
    [_myticketnum setText:_user_info[@"coupon_total"]];
}

//我的账户详情
- (IBAction)myaccountBtn:(id)sender {
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    if ([userinfo objectForKey:@"user_uid"]) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        accountViewController *viewCtr = [story instantiateViewControllerWithIdentifier:@"accountViewController"];
        [self.navigationController pushViewController:viewCtr animated:YES];
    }
    else{
        _loginTip.hidden = NO;
        _loginTip.layer.cornerRadius = 5;;
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:3];
    }
}

//添加收藏、券包边框
- (void)addseperator{
    _collectionandticket.layer.borderWidth = 0.5;
    _collectionandticket.layer.borderColor = [[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1] CGColor];
    
    UIView *mid = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-16.5)/2, 0, 0.5, _collectionandticket.frame.size.height)];
    [mid setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]];
    [_collectionandticket addSubview:mid];
    }

//我的收藏按钮
- (IBAction)mycollectionBtn:(id)sender {
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    if ([userinfo objectForKey:@"user_uid"]) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        mycollectViewController *viewCtr = [story instantiateViewControllerWithIdentifier:@"mycollectview"];
        [self.navigationController pushViewController:viewCtr animated:YES];
    }
    else{
        _loginTip.hidden = NO;
        _loginTip.layer.cornerRadius = 5;;
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:3];
    }

}

//我的券包按钮
- (IBAction)myticketBtn:(id)sender {
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    if ([userinfo objectForKey:@"user_uid"]) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        myticketViewController *viewCtr = [story instantiateViewControllerWithIdentifier:@"myticketview"];
        [self.navigationController pushViewController:viewCtr animated:YES];
    }
    else{
        _loginTip.hidden = NO;
        _loginTip.layer.cornerRadius = 5;;
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:3];
    }

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//点击弹出登录界面
- (IBAction)loginButtonClick:(id)sender {
    _accountmanaview.hidden = NO;
    _registerview.hidden = YES;
    _loginview.hidden = NO;
    //[_field resignFirstResponder];
}

- (void)keyboard{
    _key = 1;
}
//快速订餐按钮
- (IBAction)kuaisudingcan:(id)sender {
    
}

//用户登录
- (IBAction)userLogin:(id)sender {
    if (![_login_username.text isEqual:@""]&&![_login_password.text isEqual:@""]) {
        login_username = _login_username.text;
        
      login_password = [NSString md5_base64:_login_password.text];
//        login_password = [NSString base64StringFromText:_login_password.text withKey:@"edqHZr6Rmarq2tYC3wTzPS5acZNGBirp"];

        NSString *commit = [NSString stringWithFormat:@"%@%@",login_username,login_password];
       sign = [NSString base64StringFromText:commit withKey:@"edqHZr6Rmarq2tYC3wTzPS5acZNGBirp"];
//        sign = [NSString md5_base64:commit];
        [self sendRequest:@"http://www.waomi.com/mapi/androidPhone/login" withKey:@"" andValue:@""];
    }
    
}

//手机注册按钮
- (IBAction)toregisterview:(id)sender {
    [_loginview setHidden:YES];
    [_registerview setHidden:NO];
}

//发送验证码按钮
- (IBAction)identityCodeBtn:(id)sender {
    
    if ([_identityTextField.text length] !=11) {
        SHOW_ALERT(@"提示", @"您的手机号码不合法");
    }else
    {
        NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
        NSMutableDictionary *listoption = [[NSMutableDictionary alloc]init];
        NSString *commit = [NSString stringWithFormat:@"%@%@",_identityTextField.text,@"mobileApplyReg"];
        NSString *signature = [NSString base64StringFromText:commit withKey:@"edqHZr6Rmarq2tYC3wTzPS5acZNGBirp"];
        [listoption setObject:_identityTextField.text forKey:@"mobile"];
        [listoption setObject:@"mobileApplyReg" forKey:@"action"];
        [listoption setObject:signature forKey:@"sign"];
        [dic_all setObject:listoption forKey:@"option"];
        
        AFHTTPRequestOperationManager *identityManager = [[AFHTTPRequestOperationManager alloc]init];
        identityManager.responseSerializer = [AFJSONResponseSerializer serializer];
        identityManager.requestSerializer = [AFJSONRequestSerializer serializer];
        NSString *urlString = [NSString stringWithFormat:@"http://www.waomi.com/mapi/androidPhone/sendVerifyCode"];
        [identityManager POST:urlString parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"res---%@",responseObject);
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                _sendIdentityBtn.hidden = YES;
                
                [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daojishi:) userInfo:nil repeats:YES];
                [_registerPhoneNumView addSubview:countTimeLabel];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error :%@",error);
        }];
    }
  
}

//返回登录按钮
- (IBAction)backlogin:(id)sender {
    [_registerview setHidden:YES];
    [_loginview setHidden:NO];
}

#pragma mark 倒计时方法
- (void)daojishi:(NSTimer *)thistimer
{
    count ++;
    
    countTimeLabel.text = [NSString stringWithFormat:@"%ds后",120-count];
    
    while(count == 120){
        count = 0;
        countTimeLabel.hidden = YES;
        _sendIdentityBtn.hidden = NO;
        [thistimer invalidate];
        break;
    }
}
//点击屏幕退出登录界面
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch *touch = [touches anyObject];
    if (!([touch.view isEqual:_loginview]&&[touch.view isEqual:_registerview])) {
        if (_key == 1) {
            [self.view endEditing:YES];
            _key = 0;
        }
        else{
        _accountmanaview.hidden = YES;
        }
    }

}



#pragma mark UITableView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *title = [[NSArray alloc]initWithObjects:@"外卖订单",@"预订订单",@"点菜订单",@"我的评价",@"客服热线", nil];
     myCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    [cell.title setText:title[indexPath.row]];
    if (indexPath.row==0) {
        [cell showRedLight:wmredStr];
    }else if(indexPath.row==1)
    {
        [cell showRedLight:ydredStr];
    }else if (indexPath.row ==2)
    {
        [cell showRedLight:dcredStr];
    }
    
    //添加边框
    UIView *left = [[UIView alloc]initWithFrame:CGRectMake(8, 0, 0.5, 44)];
    [left setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]];
    [cell.contentView addSubview:left];
    
    UIView *right = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-8.5, 0, 0.5, 44)];
    [right setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]];
    [cell.contentView addSubview:right];
    
    UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(8, 43.5, self.view.frame.size.width-16, 0.5)];
    [bottom setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]];
    [cell.contentView addSubview:bottom];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    if ([userinfo objectForKey:@"user_uid"]) {

    if (indexPath.row == 3) {
        myrateViewController *myrateview = [sto instantiateViewControllerWithIdentifier:@"myrateview"];
        [self.navigationController pushViewController:myrateview animated:YES];
    }
    else if(indexPath.row == 4){
        
    }
    else{
        myorderViewController *myorder = [sto instantiateViewControllerWithIdentifier:@"myorderview"];
        [self.navigationController pushViewController:myorder animated:YES];
        switch (indexPath.row) {
            case 0:
            {
                AppDelegate *app = [UIApplication sharedApplication].delegate;
                app.myviewstr = @"外卖订单";
                app.myordershowway = 2;
            }
                break;
                
            case 1:
            {
                AppDelegate *app = [UIApplication sharedApplication].delegate;
                app.myviewstr = @"预订订单";
                 app.myordershowway = 2;
            }

            break;
                
            case 2:
            {
                AppDelegate *app = [UIApplication sharedApplication].delegate;
                app.myviewstr = @"点菜订单";
                 app.myordershowway = 2;
            }
                break;
                
            default:
                break;
       
       }
    }
    }
    else{
        _loginTip.hidden = NO;
        _loginTip.layer.cornerRadius = 5;;
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:3];
    }
}
@end
