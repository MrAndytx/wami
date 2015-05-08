//
//  ticketCell.h
//  哇米
//
//  Created by wenga on 15/1/12.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ticketModel.h"

@interface ticketCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *end_time;
@property (weak, nonatomic) IBOutlet UILabel *condition_use;
@property (weak, nonatomic) IBOutlet UILabel *ticketID;
@property (weak, nonatomic) IBOutlet UILabel *sh_name;
@property (weak, nonatomic) IBOutlet UILabel *vaildTime;

@property (weak, nonatomic) IBOutlet UILabel *state;

- (void)setData:(ticketModel *)model;

@end
