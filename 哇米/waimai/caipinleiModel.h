//
//  caipinleiModel.h
//  哇米
//
//  Created by wenga on 15/1/30.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface caipinleiModel : NSObject

@property (nonatomic,strong)NSString *sort_id;
@property (nonatomic,strong)NSString *sort_name;
@property (nonatomic,strong)NSString *sort_order;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
