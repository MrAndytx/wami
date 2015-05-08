//
//  topnavigation.m
//  哇米
//
//  Created by wenga on 15/1/15.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "topnavigation.h"

@implementation topnavigation

- (void)initwithFrame:(CGRect)Frame withTitle:(NSString *)title{
    _button = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
    [_button setImage:[UIImage imageNamed:@"wm_top_arrow"] forState:UIControlStateNormal];
    [self addSubview:_button];
    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(44, 0, 2, 44)];
    [_imageview setImage:[UIImage imageNamed:@"wm_tablecenter_bg"]];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 100, 30)];
    [_label setText:title];
    [_label setTextAlignment:NSTextAlignmentLeft];
    [_label setTextColor:[UIColor whiteColor]];
    [_label setFont:[UIFont systemFontOfSize:12]];
    [self setFrame:Frame];
}


@end
