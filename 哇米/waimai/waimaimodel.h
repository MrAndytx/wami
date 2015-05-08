//
//  waimaimodel.h
//  哇米
//
//  Created by wenga on 15/1/26.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface waimaimodel : NSObject

@property (nonatomic,strong)NSArray *activityModelArr;
@property (nonatomic,strong)NSArray *shop_activity;
@property (nonatomic,strong)NSDictionary *data;
@property (nonatomic,strong)NSString *bus_time;
@property (nonatomic,assign)NSInteger capita_consum;
@property (nonatomic,assign)NSInteger distribution_costs;
@property (nonatomic,assign)NSInteger distribution_rule;
@property (nonatomic,strong)NSString *map_x;
@property (nonatomic,strong)NSString *map_y;
@property (nonatomic,strong)NSNumber *sh_id;
@property (nonatomic,strong)NSString* sh_name;
@property (nonatomic,strong)NSString *shop_distance;
@property (nonatomic,strong)NSString *shop_photo;
@property (nonatomic,assign)NSInteger shop_salse;
@property (nonatomic,strong)NSString *sub_name;
@property (nonatomic,strong)NSString *error;
@property (nonatomic,strong)NSString *nexturl;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSArray *option;
@property (nonatomic,assign)float cshop_score;
@property (nonatomic,strong)NSString *sh_address;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
