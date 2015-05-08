//
//  cantingcell.h
//  哇米
//
//  Created by wenga on 15/1/6.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "waimaimodel.h"

@interface cantingcell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *buttonseperator;
@property (weak, nonatomic) IBOutlet UILabel *sh_name;
@property (weak, nonatomic) IBOutlet UIImageView *sh_photo;
@property (weak, nonatomic) IBOutlet UILabel *shop_salse;
@property (weak, nonatomic) IBOutlet UILabel *capita_consum;
@property (weak, nonatomic) IBOutlet UILabel *shop_distance;
@property (nonatomic,strong) NSNumber *sh_id;

- (void)reloadCellWithModel:(waimaimodel *)model;
- (void)refreshwith:(NSString *)str;

@end
