//
//  orderShopInfoModel.h
//  哇米
//
//  Created by Apple on 15/4/24.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "JSONModel.h"

@interface orderShopInfoModel : JSONModel
@property (nonatomic,strong) NSString<Optional> *sh_address;//店铺地址
@property (nonatomic,strong) NSString<Optional> *sh_name;//店铺名称
@property (nonatomic,strong) NSString<Optional> *sh_id;//店铺ID
@property (nonatomic,strong) NSString<Optional> *sh_tel;//店铺电话



@end
