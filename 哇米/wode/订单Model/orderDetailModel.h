//
//  orderDetailModel.h
//  哇米
//
//  Created by Apple on 15/4/22.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "JSONModel.h"

@protocol orderDetailModel <NSObject>



@end

@interface orderDetailModel : JSONModel
@property (nonatomic,strong) NSString<Optional> *cost_price;//原价
@property (nonatomic,strong) NSString<Optional> *goods_title;//菜品名字
@property (nonatomic,strong) NSString<Optional> *order_num;//数量
@property (nonatomic,strong) NSString<Optional> *real_price;//折扣价

@end
