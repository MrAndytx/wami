//
//  MyOrderDetailModel.h
//  哇米
//
//  Created by Apple on 15/4/24.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "JSONModel.h"
#import "orderBaseModel.h"
#import "orderDiscountModel.h"
#import "orderDetaildetailModel.h"
#import "orderShopInfoModel.h"

@interface MyOrderDetailModel : JSONModel
@property (nonatomic,strong) orderBaseModel<Optional> *order_base;
@property (nonatomic,strong) NSArray<orderDetaildetailModel,Optional> *order_detail;
@property (nonatomic,strong) NSArray<orderDiscountModel,Optional> *order_discount;

@property (nonatomic,strong) orderShopInfoModel<Optional> *shop_info;
@end
