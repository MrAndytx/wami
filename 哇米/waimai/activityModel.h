//
//  activityModel.h
//  哇米
//
//  Created by 大洋 on 15/1/28.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface activityModel : NSObject

@property (nonatomic,strong)NSString *activity_color;
@property (nonatomic,strong)NSString *activity_detail;
@property (nonatomic,strong)NSString *activity_key;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
