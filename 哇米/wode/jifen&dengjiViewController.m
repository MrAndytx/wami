//
//  jifen&dengjiViewController.m
//  哇米
//
//  Created by wenga on 15/1/22.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "jifen&dengjiViewController.h"

#define URL @"http://www.waomi.com/mapi/androidPhone/integralgrade"
@interface jifen_dengjiViewController ()
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;//积分
@property (weak, nonatomic) IBOutlet UILabel *limitNote;

@end

@implementation jifen_dengjiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self AFNRequest:URL];
}

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)AFNRequest:(NSString *)url
{
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *option = [[NSMutableDictionary alloc]init];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *user_uid = [userInfo objectForKey:@"user_uid"];
    [option setObject:user_uid forKey:@"uid"];
    [dic_all setObject:option forKey:@"option"];
   
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:url parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"res ---%@",responseObject);
        if([responseObject[@"status"] isEqualToString:@"1"])
        {
            _integralLabel.text = responseObject[@"data"][@"option"][@"user_integral"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
    }];

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
