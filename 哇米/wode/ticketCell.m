//
//  ticketCell.m
//  哇米
//
//  Created by wenga on 15/1/12.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "ticketCell.h"

@implementation ticketCell

- (void)setData:(ticketModel *)model
{
    _amount.text = model.amount;
    _vaildTime.text = [NSString stringWithFormat:@"有效时间: %@到%@",model.start_time,model.end_time];
    _condition_use.text = [NSString stringWithFormat:@"使用限制:单笔满%@元即可使用(不含配送费)",model.condition_use];
    _ticketID.text = [NSString stringWithFormat:@"券号:%@",model.id];
    _sh_name.text = model.sh_name;
    _end_time.text = [NSString stringWithFormat:@"有效期: %@到%@",model.start_time,model.end_time];
}




@end
