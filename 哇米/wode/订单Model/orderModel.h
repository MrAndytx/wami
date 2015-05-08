//
//  orderModel.h
//  哇米
//
//  Created by Apple on 15/4/22.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "JSONModel.h"
#import "orderDetailModel.h"

@interface orderModel : JSONModel
@property (nonatomic,strong) NSString<Optional> *order_discount;
@property (nonatomic,strong) NSString<Optional> *order_id;//订单号
@property (nonatomic,strong) NSString<Optional> *order_price;//订单金额
@property (nonatomic,strong) NSString<Optional> *order_state;//订单状态
@property (nonatomic,strong) NSString<Optional> *order_time;//下单时间
@property (nonatomic,strong) NSString<Optional> *state_name;//订单状态
@property (nonatomic,strong) NSString<Optional> *sh_id;//店铺ID
@property (nonatomic,strong) NSString<Optional> *sh_name;//店铺名称
@property (nonatomic,strong) NSString<Optional> *uid;//用户Id
@property (nonatomic,strong) NSArray<Optional,orderDetailModel> *order_detail;
@end
