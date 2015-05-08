//
//  myCell.m
//  哇米
//
//  Created by wenga on 15/1/9.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "myCell.h"

@implementation myCell

- (void)awakeFromNib {
    // Initialization code
    _redLight.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showRedLight:(NSString *)num
{
    if ([num isEqualToString:@"0"]) {
        _redLight.hidden = YES;
    }else
    {
        _redLight.hidden = NO;
    }
}
@end
