//
//  mycollectCell.h
//  哇米
//
//  Created by wenga on 15/1/9.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "waimaimodel.h"
#import "LBMyCollectionModel.h"

@interface mycollectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shop_photo;
@property (weak, nonatomic) IBOutlet UILabel *sh_name;
@property (weak, nonatomic) IBOutlet UILabel *cshop_score;
@property (weak, nonatomic) IBOutlet UILabel *shop_salse;
@property (weak, nonatomic) IBOutlet UILabel *sh_address;
@property (nonatomic,assign)NSNumber *sh_id;

- (void)setData:(LBMyCollectionModel *)model;
@end
