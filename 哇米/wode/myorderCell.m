//
//  myorderCell.m
//  哇米
//
//  Created by wenga on 15/1/9.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "myorderCell.h"
#import "orderDetailModel.h"

@implementation myorderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(orderModel *)model
{
    _model = model;
 
    
    _orderTime.text = [NSString stringWithFormat:@"下单时间: %@",_model.order_time ];
    _shopName.text = _model.sh_name;
    NSMutableArray *goodsNameArray = [NSMutableArray array];
    for (int i=0; i<_model.order_detail.count; i++) {
        orderDetailModel *detailModel = _model.order_detail[i];
        NSString *name = [NSString stringWithFormat:@"%@ (%@元*%@)",detailModel.goods_title,detailModel.cost_price,detailModel.order_num];
        [goodsNameArray addObject:name];
        
    }
    NSString *goodsName = [goodsNameArray componentsJoinedByString:@" "];
    _goodsName.text = [NSString stringWithFormat:@"菜单: %@",goodsName];
    _coupon.text= _model.order_discount;
    _pay.text = [NSString stringWithFormat:@"￥%@",_model.order_price];
    
}
@end
