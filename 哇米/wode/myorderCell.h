//
//  myorderCell.h
//  哇米
//
//  Created by wenga on 15/1/9.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderModel.h"

@interface myorderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *orderTime;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *coupon;
@property (weak, nonatomic) IBOutlet UILabel *pay;


@property (weak, nonatomic) IBOutlet UIButton *firstbtn;
@property (weak, nonatomic) IBOutlet UIButton *secondbtn;

@property (nonatomic,strong) orderModel *model;

- (void)setData:(orderModel *)model;
@end
