//
//  ticketModel.h
//  哇米
//
//  Created by wenga on 15/3/6.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ticketModel : NSObject
@property (nonatomic,strong)NSString *amount;
@property (nonatomic,strong)NSString *condition_use;
@property (nonatomic,strong)NSString *coupon_type;
@property (nonatomic,strong)NSString *end_time;
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *sh_id;
@property (nonatomic,strong)NSString *sh_name;
@property (nonatomic,strong)NSString *start_time;
@property (nonatomic,strong)NSString *state;
@property (nonatomic,strong)NSString *uid;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
