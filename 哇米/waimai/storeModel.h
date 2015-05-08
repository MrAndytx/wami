//
//  storeModel.h
//  哇米
//
//  Created by wenga on 15/1/29.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface storeModel : NSObject

@property (nonatomic,strong)NSArray *activityModelArr;
@property (nonatomic,strong)NSArray *shop_activity;
@property (nonatomic,strong)NSString *bus_time;
@property (nonatomic,assign)NSInteger capita_consum;
@property (nonatomic,assign)NSInteger distribution_costs;
@property (nonatomic,assign)NSInteger distribution_rule;
@property (nonatomic,assign)NSInteger sh_id;
@property (nonatomic,strong)NSString* sh_name;
@property (nonatomic,strong)NSString *shop_photo;
@property (nonatomic,assign)NSInteger shop_salse;
@property (nonatomic,strong)NSString *sub_name;
@property (nonatomic,strong)NSString *error;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,assign)NSNumber *comment_count;
@property (nonatomic,strong)NSString *map_x;
@property (nonatomic,strong)NSString *map_y;
@property (nonatomic,strong)NSString *sh_tel;
@property (nonatomic,assign)NSString *ship_time;
@property (nonatomic,strong)NSString *shop_address;
@property (nonatomic,strong)NSString *shop_detail;
@property (nonatomic,strong)NSString *shop_notice;
@property (nonatomic,strong)NSString *shop_score;
@property (nonatomic,strong)NSString *shop_service;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
