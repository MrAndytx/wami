//
//  orderViewController.m
//  哇米
//
//  Created by wenga on 15/1/12.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "orderViewController.h"
#import "orderCell.h"
#import "MyOrderDetailModel.h"
#import "orderDetaildetailModel.h"
#import "orderBaseModel.h"
#import "orderShopInfoModel.h"
#import "orderDiscountModel.h"

#define URL @"http://www.waomi.com/mapi/androidPhone/orderdetail"
@interface orderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataArray;
    NSArray *discountArray;
    orderShopInfoModel *shopModel;
    orderBaseModel *baseModel;
    
}
@property (weak, nonatomic) IBOutlet UIView *buttom;
@property (weak, nonatomic) IBOutlet UIView *juchi;
@property (weak, nonatomic) IBOutlet UITableView *ordertableview;

@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopTel;
@property (weak, nonatomic) IBOutlet UITextField *shopTime;
@property (weak, nonatomic) IBOutlet UILabel *shopAddress;
@property (weak, nonatomic) IBOutlet UILabel *sendAddress;
@property (weak, nonatomic) IBOutlet UILabel *notes;

@property (weak, nonatomic) IBOutlet UILabel *discountName;
@property (weak, nonatomic) IBOutlet UILabel *discountMoney;
@property (weak, nonatomic) IBOutlet UILabel *farePrice;
@property (weak, nonatomic) IBOutlet UILabel *packPrice;

@property (weak, nonatomic) IBOutlet UILabel *sumofpeice;
@property (weak, nonatomic) IBOutlet UILabel *sumofMoney;
@property (weak, nonatomic) IBOutlet UILabel *sumoffarePrice;
@property (weak, nonatomic) IBOutlet UILabel *expenseCode;

@end

@implementation orderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    [_ordertableview.tableFooterView addSubview:view];
//   NSLog(@"订单号是--%@++%@",_userId,_orderId);
    [self AFNRequest:URL];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
   

}

- (void)AFNRequest:(NSString *)url
{
   
    
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *option = [[NSMutableDictionary alloc]init];
    [option setObject:_userId forKey:@"uid"];
    [option setObject:_orderId forKey:@"order_id"];
    [dic_all setObject:option forKey:@"option"];
    AFHTTPRequestOperationManager *manager2 = [[AFHTTPRequestOperationManager alloc]init];
    manager2.responseSerializer = [AFJSONResponseSerializer serializer];
    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager2 POST:url parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"reshhhh ---%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            dataArray = [orderDetaildetailModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"option"][@"order_detail"] error:nil];
            int sumofPecie=0;
            float sumofPrice = 0.0;
            
            if (dataArray.count !=0) {
                for (int i=0; i<dataArray.count; i++) {
                    sumofPecie+= [[dataArray[i] order_num] intValue];
                    sumofPrice+= [[dataArray[i] cost_price] floatValue];
                }
                _sumofpeice.text = [NSString stringWithFormat:@"合计:%d份",sumofPecie];
            }
            
            
            
            discountArray = [orderDiscountModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"option"][@"order_discount"] error:nil];
            
            shopModel = [[orderShopInfoModel alloc]initWithDictionary:responseObject[@"data"][@"option"][@"shop_info"] error:nil];
            baseModel = [[orderBaseModel alloc]initWithDictionary:responseObject[@"data"][@"option"][@"order_base"] error:nil];
            
            _shopName.text = shopModel.sh_name;
            _shopTel.text = shopModel.sh_tel;
            _shopAddress.text = shopModel.sh_address;
            
            _shopTime.text = [NSString stringWithFormat:@"下单时间: %@",baseModel.order_time];
            _sendAddress.text = [NSString stringWithFormat:@"收货地址: %@",baseModel.order_address];
            _farePrice.text = [NSString stringWithFormat:@"￥%@",baseModel.fare_price];
            _expenseCode.text = [NSString stringWithFormat:@"消费劵号: %@",baseModel.order_id];
            if ([baseModel.order_text length] <=0) {
                 _notes.text = @"留言: 暂无留言";
            }else
            {
                 _notes.text = [NSString stringWithFormat:@"留言: %@",baseModel.order_text];
            }
           
            float sum=0.0;
             NSMutableArray *nameMutablArray = [NSMutableArray array];
            if (discountArray.count !=0) {
               
                
                for (int i=0; i<discountArray.count; i++) {
                    [nameMutablArray addObject:[discountArray[i] discount_name]];
                    sum+= [[discountArray[i] discount_sum] floatValue];
                }
                
                _discountName.text = [nameMutablArray componentsJoinedByString:@","];
                _discountMoney.text = [NSString stringWithFormat:@"￥%.1f",sum];

            }else
            {
                _discountName.text = @"暂无信息";
                _discountMoney.text = @"￥0.0";
            }
            
            float fare = [baseModel.fare_price floatValue];
            float pack = [[_packPrice.text substringFromIndex:1] floatValue];
           _sumofMoney.text = [NSString stringWithFormat:@"￥%.1f元",sumofPrice-sum-fare-pack];
            _sumoffarePrice.text = [NSString stringWithFormat:@"(含配送费%.1f元)",fare];
            [_ordertableview reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
    }];

}

- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - scrollview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 2;
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    orderCell *cell = [[orderCell alloc]init];
    cell = [tableView dequeueReusableCellWithIdentifier:@"ordercell"];
   
    [cell setData:dataArray[indexPath.row]];
    return cell;
}

@end
