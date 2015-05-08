//
//  orderCell.m
//  哇米
//
//  Created by wenga on 15/1/13.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "orderCell.h"
#import "UIImageView+WebCache.h"

@implementation orderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(orderDetaildetailModel *)model
{
    _model = model;
    
    NSString *imageString = _model.goods_pic;
    NSURL *url = [NSURL URLWithString:imageString];
    [_goodsPic sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"a_ba"]];
    
    _goodsName.text = [NSString stringWithFormat:@"%@  %@份",_model.goods_title,_model.order_num];
    _price.text = _model.cost_price;
    _sumPrice.text = [NSString stringWithFormat:@"￥%.1f",[_model.cost_price floatValue]*[_model.order_num intValue]];
}
@end
