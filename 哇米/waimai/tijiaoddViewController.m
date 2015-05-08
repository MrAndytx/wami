//
//  tijiaoddViewController.m
//  哇米
//
//  Created by wenga on 15/1/8.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "tijiaoddViewController.h"
#import "tijiaoCell.h"
#import "LBAddressModel.h"

@interface tijiaoddViewController ()
{
    NSString *defaultString;
}
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userTel;
@property (weak, nonatomic) IBOutlet UILabel *userAddre;
@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;


@end

@implementation tijiaoddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _view1.hidden = NO;
    _view2.hidden = YES;
    _view3.hidden = YES;
    _view4.hidden = YES;
    _view5.hidden = YES;
    // Do any additional setup after loading the view.
    defaultString = @"1";
    [self addressRequest:defaultString];
}


#pragma mark 请求
- (void)addressRequest:(NSString *) defaultStr
{
    //送餐地址
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *option = [[NSMutableDictionary alloc]init];
    
    [option setObject:_userId forKey:@"uid"];
    [option setObject:defaultStr forKey:@"default"];
    
    [dic_all setObject:option forKey:@"option"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:@"http://www.waomi.com/mapi/androidPhone/userAddress" parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"res -%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
             LBAddressModel *addressModel = [[LBAddressModel alloc]initWithDictionary:responseObject[@"data"][@"account"] error:nil];
            
                _userName.text = [addressModel user_name];
                _userTel.text = [addressModel phone];
                _userAddre.text = [NSString stringWithFormat:@"%@%@%@%@",addressModel.prov,addressModel.city,addressModel.dist,addressModel.road_add];
           
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
    }];

}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickTopBtn:(UIButton *)sender {
    for (int i = 60; i<65; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        if (i!=sender.tag) {
            btn.selected = NO;
        }
    }
    switch (sender.tag) {
        case 60:
        {
            _view1.hidden = NO;
            _view2.hidden = YES;
            _view3.hidden = YES;
            _view4.hidden = YES;
            _view5.hidden = YES;
        }
            break;
        case 61:
        {
            _view1.hidden = YES;
            _view2.hidden = NO;
            _view3.hidden = YES;
            _view4.hidden = YES;
            _view5.hidden = YES;
        }
            break;
        case 62:
        {
            _view1.hidden = YES;
            _view2.hidden = YES;
            _view3.hidden = NO;
            _view4.hidden = YES;
            _view5.hidden = YES;
        }
            break;
        case 63:
        {
            _view1.hidden = YES;
            _view2.hidden = YES;
            _view3.hidden = YES;
            _view4.hidden = NO;
            _view5.hidden = YES;
        }
            break;

        case 64:
        {
            _view1.hidden = YES;
            _view2.hidden = YES;
            _view3.hidden = YES;
            _view4.hidden = YES;
            _view5.hidden = NO;
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   tijiaoCell *cell = nil;
    switch (indexPath.row) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"tijiaocell"];
            break;
            
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"jiancell"];
            break;
            
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"peisongcell"];
            break;
            
        case 3:
            cell = [tableView dequeueReusableCellWithIdentifier:@"dabaocell"];
            break;
            
        
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100;
    }
    else{
        return 44;
    }
}


@end
