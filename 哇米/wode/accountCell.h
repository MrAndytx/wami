//
//  accountCell.h
//  哇米
//
//  Created by wenga on 15/1/9.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface accountCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *accountlab;
@property (weak, nonatomic) IBOutlet UIButton *switchbtn;
@property (weak, nonatomic) IBOutlet UILabel *shuoming;
@property (weak, nonatomic) IBOutlet UIImageView *rightarrow;

@property (weak, nonatomic) IBOutlet UIView *bottomline;

@end
