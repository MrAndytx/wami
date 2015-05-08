//
//  TKTDaiJingQuanTableViewCell.h
//  哇米
//
//  Created by Apple on 15/4/28.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBMyticketModel.h"

@interface TKTDaiJingQuanTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *daijingId;

- (void)setData:(LBMyticketModel *)model;
@end
