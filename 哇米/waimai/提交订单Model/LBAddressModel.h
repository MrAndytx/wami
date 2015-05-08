//
//  LBAddressModel.h
//  哇米
//
//  Created by Apple on 15/5/5.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "JSONModel.h"

@interface LBAddressModel : JSONModel
@property (nonatomic,strong) NSString<Optional> *prov;
@property (nonatomic,strong) NSString<Optional> *city;
@property (nonatomic,strong) NSString<Optional> *dist;
@property (nonatomic,strong) NSString<Optional> *road_add;
@property (nonatomic,strong) NSString<Optional> *user_name;
@property (nonatomic,strong) NSString<Optional> *phone;
@property (nonatomic,strong) NSString<Optional> *is_default;
@end
