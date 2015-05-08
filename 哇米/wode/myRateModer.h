//
//  myRateModer.h
//  哇米
//
//  Created by wenga on 15/3/6.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myRateModer : NSObject

@property (nonatomic,strong)NSString *addtime;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *order_goods;
@property (nonatomic,strong)NSString *score;
@property (nonatomic,strong)NSString *sh_id;
@property (nonatomic,strong)NSString *sh_name;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
