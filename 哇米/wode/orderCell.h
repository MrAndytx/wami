//
//  orderCell.h
//  哇米
//
//  Created by wenga on 15/1/13.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderDetaildetailModel.h"

@interface orderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsPic;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *sumPrice;

@property (nonatomic,strong) orderDetaildetailModel *model;

- (void)setData:(orderDetaildetailModel *)model;
@end
