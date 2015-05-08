//
//  LBMyticketModel.h
//  哇米
//
//  Created by Apple on 15/4/28.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "JSONModel.h"

@interface LBMyticketModel : JSONModel
@property (nonatomic,strong)NSString<Optional> *amount;//券金额
@property (nonatomic,strong)NSString<Optional> *condition_use;//使用标准
@property (nonatomic,strong)NSString<Optional> *coupon_type;//券类型
@property (nonatomic,strong)NSString<Optional> *end_time;//有效时间
@property (nonatomic,strong)NSString<Optional> *id;//券ID
@property (nonatomic,strong)NSString<Optional> *sh_id;//适用店铺
@property (nonatomic,strong)NSString<Optional> *sh_name;//店铺名称
@property (nonatomic,strong)NSString<Optional> *start_time;//有效期-开始
@property (nonatomic,strong)NSString<Optional> *state;//状态(1:正常 2:使用 -1:过期)
@property (nonatomic,strong)NSString<Optional> *uid;//用户ID
@end
