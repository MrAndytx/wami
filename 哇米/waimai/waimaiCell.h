//
//  waimaiCell.h
//  哇米
//
//  Created by wenga on 15/1/6.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "waimaimodel.h"
#import "activityModel.h"

@interface waimaiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sh_name;
@property (weak, nonatomic) IBOutlet UILabel *saletime;
@property (weak, nonatomic) IBOutlet UIImageView *sh_photo;
@property (weak, nonatomic) IBOutlet UILabel *distribution_costs;
@property (weak, nonatomic) IBOutlet UILabel *distribution_rule;
@property (weak, nonatomic) IBOutlet UILabel *bus_time;
@property (weak, nonatomic) IBOutlet UILabel *capita_consum;
@property (weak, nonatomic) IBOutlet UILabel *shop_distance;
@property (weak, nonatomic) IBOutlet UILabel *shop_salse;

@property (weak, nonatomic) IBOutlet UIButton *firItem;
@property (weak, nonatomic) IBOutlet UIButton *secItem;
@property (weak, nonatomic) IBOutlet UIButton *thiItem;
@property (weak, nonatomic) IBOutlet UIButton *forItem;
@property (weak, nonatomic) IBOutlet UIButton *fitItem;
@property (nonatomic,assign)NSNumber *sh_id;

@property (weak, nonatomic) IBOutlet UIView *picture;


@property (weak, nonatomic) IBOutlet UIView *buttomseperator;

- (void)refreshwith:(NSString *)str;
- (void)reloadCellWithModel:(waimaimodel *)model;

@end
