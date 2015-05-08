//
//  candanModel.h
//  哇米
//
//  Created by wenga on 15/1/30.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface candanModel : NSObject

@property (nonatomic,strong)NSString *goods_id;
@property (nonatomic,strong)NSString *goods_sort;
@property (nonatomic,strong)NSString *goods_name;
@property (nonatomic,strong)NSString *goods_pic;
@property (nonatomic,strong)NSString *goods_pic_160;
@property (nonatomic,strong)NSString *goods_price;
@property (nonatomic,assign)int isnew;
@property (nonatomic,assign)int ishot;
@property (nonatomic,assign)NSNumber *sh_id;
@property (nonatomic,strong)NSMutableArray *images_list;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
