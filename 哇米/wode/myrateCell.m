//
//  myrateCell.m
//  哇米
//
//  Created by wenga on 15/1/16.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "myrateCell.h"

@implementation myrateCell

- (void)refreshwith:(NSString *)str{
    
}

- (void)reloadCellWithModel:(LBMycommentModel *)model
{
    [self.sh_name setText:model.sh_name];
    [self.addtime setText:model.addtime];
    [self.order_goods setText:[NSString stringWithFormat:@"菜单:%@",model.order_goods]];
    [self.content setText:model.content];
    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 20, 20)];
//    imageView.backgroundColor = [UIColor blueColor];
//    [_starView addSubview:imageView];
    
    for (int i=0; i<5; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(4+i*20, 0, 20, 15)];
//        imageView.backgroundColor = [UIColor blueColor];
        imageView.image = [UIImage imageNamed:@"grayStar"];
        [_starView addSubview:imageView];
    }
    
   [self setselectStar:[model.score intValue]];
}
- (void)setselectStar:(int) num
{
    for (int i=0; i<num; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(4+i*20, 0, 20, 15)];
        imageView.image = [UIImage imageNamed:@"lightStar"];
        [_starView addSubview:imageView];
    }
}
@end
