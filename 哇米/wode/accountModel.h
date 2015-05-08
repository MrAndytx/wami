//
//  accountModel.h
//  哇米
//
//  Created by wenga on 15/2/2.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface accountModel : NSObject

@property (nonatomic,assign)NSString *cash_sum;
@property (nonatomic,strong)NSString *collect_total;
@property (nonatomic,strong)NSString *coupon_total;
@property (nonatomic,strong)NSString *mobile_audit;
@property (nonatomic,strong)NSString *nick_name;
@property (nonatomic,strong)NSString *payment_pass_se;
@property (nonatomic,strong)NSString *profile;
@property (nonatomic,strong)NSString *real_name;
@property (nonatomic,assign)NSString *sex;
@property (nonatomic,assign)NSString *user_grade;
@property (nonatomic,assign)NSString *user_integral;
@property (nonatomic,strong)NSString *user_name;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
