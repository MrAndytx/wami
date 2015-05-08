//
//  orderBaseModel.h
//  哇米
//
//  Created by Apple on 15/4/24.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "JSONModel.h"

@interface orderBaseModel : JSONModel
@property (nonatomic,strong) NSString<Optional> *fare_price;//配送费
@property (nonatomic,strong) NSString<Optional> *is_comment;//
@property (nonatomic,strong) NSString<Optional> *ordain_date;//用餐时间
@property (nonatomic,strong) NSString<Optional> *order_address;//送餐地址
@property (nonatomic,strong) NSString<Optional> *order_id;//订单号
@property (nonatomic,strong) NSString<Optional> *order_name;//收货人
@property (nonatomic,strong) NSString<Optional> *order_num;//数量
@property (nonatomic,strong) NSString<Optional> *order_price;//订单金额
@property (nonatomic,strong) NSString<Optional> *order_state;//订单状态
@property (nonatomic,strong) NSString<Optional> *order_tel;//联系电话
@property (nonatomic,strong) NSString<Optional> *order_text;//留言
@property (nonatomic,strong) NSString<Optional> *order_time;//下单时间
@property (nonatomic,strong) NSString<Optional> *person_num;//用餐人数
@property (nonatomic,strong) NSString<Optional> *seats;//餐位
@property (nonatomic,strong) NSString<Optional> *state_name;//订单状态
@property (nonatomic,strong) NSString<Optional> *valid_code;//验证码


@end
