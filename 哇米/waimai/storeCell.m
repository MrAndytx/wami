//
//  storeCell.m
//  哇米
//
//  Created by wenga on 15/1/8.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "storeCell.h"

@implementation storeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(LBUserComentModel *)model
{
    _commentContent.text = model.content;
    _commentScore.text = model.score;
    _commentMenu.text = [NSString stringWithFormat:@"菜单: %@",model.menu_str];
    _commentTime.text = model.addtime;
    _userName.text = model.user_name;
}

@end
