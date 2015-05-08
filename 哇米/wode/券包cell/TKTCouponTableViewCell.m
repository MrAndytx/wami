//
//  TKTCouponTableViewCell.m
//  哇米
//
//  Created by Apple on 15/4/28.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "TKTCouponTableViewCell.h"

@implementation TKTCouponTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(LBMyticketModel *)model
{
    _shopNameLabel.text = model.sh_name;
    _priceLabel.text = model.amount;
    _limitTimeLabel.text = [NSString stringWithFormat:@"有效时间: %@到%@",model.start_time,model.end_time];
    _useLimitLabel.text = [NSString stringWithFormat:@"使用限制：单笔满%@元即可使用（不含配送费）",model.condition_use];
    if ([model.state isEqualToString:@"1"]) {
        _stateLabel.text = @"立即使用";
    }else if ([model.state isEqualToString:@"2"])
    {
        _stateLabel.text = @"已经使用";
    }else
    {
        _stateLabel.text = @"已经过期";
    }
}
@end
