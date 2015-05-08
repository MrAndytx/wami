//
//  TKTCouponTableViewCell.h
//  哇米
//
//  Created by Apple on 15/4/28.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBMyticketModel.h"

@interface TKTCouponTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *useLimitLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;



- (void)setData:(LBMyticketModel *)model;
@end
