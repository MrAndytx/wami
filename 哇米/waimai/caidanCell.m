//
//  caidanCell.m
//  哇米
//
//  Created by wenga on 15/1/8.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "caidanCell.h"
#import "UIImageView+WebCache.h"

@implementation caidanCell

/*
- (void)reloadCellWithModel:(candanModel *)model{
    [self.goods_name setText:model.goods_name];
    if ([model.goods_pic_160 isEqual:@"http://www.waomi.com"]) {
        [self.goods_pic_160 setImage:[UIImage imageNamed:@"wm_defaultpic"]];
    }
    else{
    [self.goods_pic_160 setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.goods_pic_160]]]];
    }
    [self.goods_price setText:model.goods_price];
    if (model.ishot == 1) {
        self.ihot.hidden = NO;
    }
    if (model.isnew == 1) {
        self.inew.hidden = NO;
    }
}*/

- (void)awakeFromNib
{
    _numView.hidden = YES;
//    [_orderAdd addTarget:self action:@selector(goodsAddFunction) forControlEvents:UIControlEventTouchUpInside];
//    [_orderReduce addTarget:self action:@selector(goodsReduFunction) forControlEvents:UIControlEventTouchUpInside];
//    [_orderBtn addTarget:self action:@selector(numViewShow) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)prepareForReuse{
    _numView.hidden = YES;
    _orderBtn.hidden = NO;
}

- (void)setData:(LBCaidanGoodsListModel *)model
{
    _modelDic = (NSDictionary *)model;
    num =1;
    _goods_name.text = model.goods_name;
    _goods_price.text = model.goods_price;
    if ([model.goods_pic_160 isEqual:@"http://www.waomi.com"]) {
        [self.goods_pic_160 setImage:[UIImage imageNamed:@"wm_defaultpic"]];
    }
    else{
        [self.goods_pic_160 setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.goods_pic_160]]]];
    }
    if ([model.ishot isEqualToString:@"1"] ) {
        self.ihot.hidden = NO;
    }
    if ([model.isnew isEqualToString:@"1"]) {
        self.inew.hidden = NO;
    }
    
}


- (int)goodsAddFunction
{
    _numView.hidden = NO;
    num++;
   _orderNum.text = [NSString stringWithFormat:@"%d",num];
    return num;
    
}

- (int)goodsReduFunction
{
    
    if (num>1) {
        num--;
    }
    
//    int price = 0;
//    price+= num*[_goods_price.text intValue];
    _orderNum.text=[NSString stringWithFormat:@"%d",num];
    return num;
    
}

//cell点击添加至购物车代码
- (IBAction)addGoods:(id)sender {
    _orderView.hidden = NO;
    num++;
    _orderNum.text = [NSString stringWithFormat:@"%d",num];
//    return num;
    [_delegate setSelectedDic:_modelDic andStatus:1];
}

- (IBAction)ReduGoods:(id)sender {
    if (num>1) {
        num--;
    }else if (num < 1){
        _orderView.hidden = YES;
    }
    _orderNum.text=[NSString stringWithFormat:@"%d",num];
    [_delegate setSelectedDic:_modelDic andStatus:0];
}

- (IBAction)numViewChange:(id)sender {
    _numView.hidden = NO;
    _orderView.hidden = YES;
    [_delegate setSelectedDic:_modelDic andStatus:1];

}
@end
