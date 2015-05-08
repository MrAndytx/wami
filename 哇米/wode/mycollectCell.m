//
//  mycollectCell.m
//  哇米
//
//  Created by wenga on 15/1/9.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "mycollectCell.h"

@implementation mycollectCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setData:(LBMyCollectionModel *)model
{
    [self.shop_photo setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.shop_photo]]]];
    [self.sh_name setText:model.sh_name];
    [self.cshop_score setText:[NSString stringWithFormat:@"%0.1f",[model.cshop_score floatValue]]];
    [self.shop_salse setText:[NSString stringWithFormat:@"%ld人吃过",(long)model.shop_salse]];
    [self.sh_address setText:model.sh_address];
    _sh_id = model.sh_id;
}

@end
