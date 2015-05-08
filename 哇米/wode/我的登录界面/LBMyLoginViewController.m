//
//  LBMyLoginViewController.m
//  哇米
//
//  Created by Apple on 15/4/30.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "LBMyLoginViewController.h"
#import "AFNetworking.h"
#import "NSString+DES.h"

#define TITLECOLOR [UIColor colorWithRed:241/255.0f green:70/255.0f blue:0 alpha:1.0]
#define NOMALTITLECOLOR [UIColor colorWithRed:75/255.0f green:75/255.0f blue:75/255.0f alpha:1.0]
@interface LBMyLoginViewController ()
{
    int count;
}
@property (weak, nonatomic) IBOutlet UIButton *phoneLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *accountLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *identityBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *identityCode;


@end

@implementation LBMyLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    count = 0;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark 常规方法
- (void)reDirectBtn
{
    [_phoneLoginBtn setTitleColor:TITLECOLOR forState:UIControlStateSelected];
    [_accountLoginBtn setTitleColor:TITLECOLOR forState:UIControlStateSelected];
    _identityBtn.layer.cornerRadius = 4.0f;
    _loginBtn.layer.cornerRadius = 4.0f;
}

#pragma mark action 方法
- (IBAction)phoneLoginAction:(id)sender {
    [_phoneLoginBtn setSelected:YES];
    [_accountLoginBtn setSelected:NO];
    if (_phoneLoginBtn.selected ==YES) {
        [_phoneLoginBtn setBackgroundColor:[UIColor colorWithRed:224/255.0f green:224/255.0f  blue:224/255.0f  alpha:1.0]];
    }
}
- (IBAction)accountLoginAction:(id)sender {
    [_phoneLoginBtn setSelected:NO];
    [_accountLoginBtn setSelected:YES];
}
- (IBAction)getIdentityCodeAction:(id)sender {
    if ([_phoneNum.text length] !=11) {
        SHOW_ALERT(@"提示", @"您的手机号码不合法");
    }else
    {
        NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
        NSMutableDictionary *listoption = [[NSMutableDictionary alloc]init];
        NSString *commit = [NSString stringWithFormat:@"%@%@",_phoneNum.text,@"mobileApplyReg"];
        NSString *signature = [NSString base64StringFromText:commit withKey:@"edqHZr6Rmarq2tYC3wTzPS5acZNGBirp"];
        [listoption setObject:_phoneNum.text forKey:@"mobile"];
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
                _identityBtn.enabled = NO;
                
                
                [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daojishi:) userInfo:nil repeats:YES];
               
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error :%@",error);
        }];
    }

}
- (IBAction)loginAction:(id)sender {
}

#pragma mark 倒计时方法
- (void)daojishi:(NSTimer *)thistimer
{
    count ++;
    
    
    NSString *daojishi = [NSString stringWithFormat:@"%ds后",120-count];
    [_identityBtn setTitle:daojishi forState:UIControlStateNormal];
    
    while(count == 0){

        _identityBtn.enabled = YES;
        [_identityBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [thistimer invalidate];
        break;
    }
}
@end
