//
//  waimaiCell.m
//  哇米
//
//  Created by wenga on 15/1/6.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "waimaiCell.h"
#import "UIColor+HexColor.h"

@implementation waimaiCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshwith:(NSString *)str{
    [self.saletime setText:str];
}

- (void)reloadCellWithModel:(waimaimodel *)model
{
    [self.sh_name setText:model.sh_name];
    if (model.distribution_costs == 0) {
        [self.distribution_costs setText:@"免费配送"];
      }else{
        [self.distribution_costs setText:[NSString stringWithFormat:@"%ld元配送",(long)model.distribution_costs]];
      }
    [self.distribution_rule setText:[NSString stringWithFormat:@"%ld元起送",(long)model.distribution_rule]];
    [self.capita_consum setText:[NSString stringWithFormat:@"%ld",(long)model.capita_consum]];
    [self.shop_salse setText:[NSString stringWithFormat:@"%ld",(long)model.shop_salse]];
    [self.sh_photo setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.shop_photo]]]];
    [self.bus_time setText:model.bus_time];
    [self.shop_distance setText:[NSString stringWithFormat:@"%@",model.shop_distance]];
    self.sh_id = model.sh_id;
    
    NSMutableArray *Item = [[NSMutableArray alloc]initWithObjects:self.firItem,self.secItem,self.thiItem,self.forItem,self.fitItem, nil];
    for (int i = 0; i<model.activityModelArr.count; i++) {
        activityModel *subModel = model.activityModelArr[i];
        [Item[i] setTitle:subModel.activity_key forState:UIControlStateNormal];
        [Item[i] setBackgroundColor:[UIColor colorWithHexString:subModel.activity_color]];
        
    }
}

@end
