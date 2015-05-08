//
//  LBMyCollectionModel.h
//  哇米
//
//  Created by Apple on 15/4/28.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "JSONModel.h"

@interface LBMyCollectionModel : JSONModel
@property (nonatomic,strong)NSString<Optional> *cshop_score;//评分
@property (nonatomic,strong)NSString<Optional> *sh_address;//地址
@property (nonatomic,strong)NSNumber<Optional> *sh_id;//店铺ID
@property (nonatomic,strong)NSString* sh_name;//店铺名称
@property (nonatomic,strong)NSString *shop_photo;//店铺形象照
@property (nonatomic,assign)NSInteger shop_salse;//销量
@property (nonatomic,strong)NSString *sub_name;//分店名称
@end
