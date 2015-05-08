//
//  myRateModer.m
//  哇米
//
//  Created by wenga on 15/3/6.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "myRateModer.h"

@implementation myRateModer

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
