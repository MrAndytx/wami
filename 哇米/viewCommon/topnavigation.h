//
//  topnavigation.h
//  哇米
//
//  Created by wenga on 15/1/15.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface topnavigation : UIView

@property (nonatomic,copy)UILabel *label;
@property (nonatomic)UIImageView *imageview;
@property (nonatomic)UIButton *button;

- (void)initwithFrame:(CGRect)Frame withTitle:(NSString *)title;


@end
