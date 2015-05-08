//
//  LBCaidanModel.h
//  哇米
//
//  Created by Apple on 15/5/5.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "JSONModel.h"
#import "LBCaidanGoodsListModel.h"

@interface LBCaidanModel : JSONModel
@property (nonatomic,strong) NSArray<LBCaidanGoodsListModel,Optional> *goods_list;
@property (nonatomic,strong) NSString<Optional> *sort_id;
@property (nonatomic,strong) NSString<Optional> *sort_name;
@property (nonatomic,strong) NSString<Optional> *sort_order;
@end
