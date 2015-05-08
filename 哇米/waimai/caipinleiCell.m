//
//  caipinleiCell.m
//  哇米
//
//  Created by wenga on 15/1/19.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "caipinleiCell.h"

@implementation caipinleiCell



- (void)setTypeData:(LBCaidanModel *)model
{
    _caifenlei.text = model.sort_name;
    _rightred.hidden = YES;
    _hadordernum.hidden = YES;
    
}
@end
