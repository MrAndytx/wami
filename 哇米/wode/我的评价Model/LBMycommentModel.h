//
//  LBMycommentModel.h
//  哇米
//
//  Created by Apple on 15/4/27.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "JSONModel.h"

@interface LBMycommentModel : JSONModel
@property (nonatomic,strong) NSString<Optional> *sh_ip;//店铺ID
@property (nonatomic,strong) NSString<Optional> *sh_name;//店铺名称
@property (nonatomic,strong) NSString<Optional> *addtime;//评论时间
@property (nonatomic,strong) NSString<Optional> *content;//评论内容
@property (nonatomic,strong) NSString<Optional> *order_goods;//菜单
@property (nonatomic,strong) NSString<Optional> *score;//菜单
@end
