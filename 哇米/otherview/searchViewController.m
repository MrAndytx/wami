//
//  searchViewController.m
//  哇米
//
//  Created by wenga on 15/1/5.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "searchViewController.h"
#import "AFNetworking.h"

@interface searchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@end

@implementation searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBarHidden = YES;
    
   

    

}
- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)searchBtn:(id)sender {
    if ([_searchTextField.text isEqualToString:@""]) {
        SHOW_ALERT(@"提示", @"搜索内容不能为空");
    }else
    {
        NSLog(@"search--%@",_searchTextField.text);
        NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
        NSMutableDictionary *option = [[NSMutableDictionary alloc]init];
        [option setObject:_searchTextField.text forKey:@"keyword"];
        [dic_all setObject:option forKey:@"option"];
        //    NSLog(@"%@",dic_all);
        AFHTTPRequestOperationManager *searchManager = [[AFHTTPRequestOperationManager alloc]init];
        searchManager.responseSerializer = [AFJSONResponseSerializer serializer];
        searchManager.requestSerializer = [AFJSONRequestSerializer serializer];
        NSString *urlString = [NSString stringWithFormat:@"http://www.waomi.com/mapi/androidPhone/search"];
        [searchManager POST:urlString parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"res----%@",responseObject);
            if([responseObject[@"status"] isEqualToString:@"0"])
            {
                SHOW_ALERT(@"提示", responseObject[@"error"]);
            }else
            {
                NSLog(@"成功");
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error :%@",error);
        }];

    }
    
}



- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
