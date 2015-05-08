//
//  cantingcell.m
//  哇米
//
//  Created by wenga on 15/1/6.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "cantingcell.h"

@implementation cantingcell

- (void)awakeFromNib {
    // Initialization code
}

- (void)refreshwith:(NSString *)str{
    
}

- (void)reloadCellWithModel:(waimaimodel *)model
{
    [self.sh_name setText:model.sh_name];
    [self.capita_consum setText:[NSString stringWithFormat:@"￥%ld",(long)model.capita_consum]];
    [self.shop_salse setText:[NSString stringWithFormat:@"%ld",(long)model.shop_salse]];
    [self.sh_photo setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.shop_photo]]]];
    [self.shop_distance setText:[NSString stringWithFormat:@"%@",model.shop_distance]];
    self.sh_id = model.sh_id;
//    NSLog(@"%@",model.sh_id);
}
@end
