//
//  TKTDaiJingQuanTableViewCell.m
//  哇米
//
//  Created by Apple on 15/4/28.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "TKTDaiJingQuanTableViewCell.h"

@implementation TKTDaiJingQuanTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(LBMyticketModel *)model
{
    _priceLabel.text = model.amount;
    _limitTimeLabel.text = [NSString stringWithFormat:@"%@到%@",model.start_time,model.end_time];
    _daijingId.text = [NSString stringWithFormat:@"券号: %@",model.id];
    if ([model.state isEqualToString:@"1"]) {
        _stateLabel.text = @"未使用";
    }else if ([model.state isEqualToString:@"2"])
    {
        _stateLabel.text = @"已使用";
    }else
    {
        _stateLabel.text = @"已过期";
    }
    

}
@end
