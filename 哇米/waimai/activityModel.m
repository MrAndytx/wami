//
//  activityModel.m
//  哇米
//
//  Created by 大洋 on 15/1/28.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "activityModel.h"

@implementation activityModel

+ (instancetype)messageWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
