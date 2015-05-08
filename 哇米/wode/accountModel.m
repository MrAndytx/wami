//
//  accountModel.m
//  哇米
//
//  Created by wenga on 15/2/2.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "accountModel.h"

@implementation accountModel

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
