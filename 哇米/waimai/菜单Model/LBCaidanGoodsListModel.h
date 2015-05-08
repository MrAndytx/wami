//
//  LBCaidanGoodsListModel.h
//  哇米
//
//  Created by Apple on 15/5/4.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "JSONModel.h"

@protocol LBCaidanGoodsListModel <NSObject>



@end

@interface LBCaidanGoodsListModel : JSONModel
@property (nonatomic,strong)NSString<Optional> *goods_id;
@property (nonatomic,strong)NSString<Optional> *goods_sort;
@property (nonatomic,strong)NSString<Optional> *goods_name;
@property (nonatomic,strong)NSString<Optional> *goods_pic;
@property (nonatomic,strong)NSString<Optional> *goods_pic_160;
@property (nonatomic,strong)NSString<Optional> *goods_price;
@property (nonatomic,strong)NSString<Optional> *isnew;
@property (nonatomic,strong)NSString<Optional> *ishot;
@property (nonatomic,strong)NSString<Optional> *sh_id;
@end
