//
//  myrateCell.h
//  哇米
//
//  Created by wenga on 15/1/16.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myRateModer.h"
#import "LBMycommentModel.h"

@interface myrateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sh_name;
@property (weak, nonatomic) IBOutlet UILabel *addtime;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *order_goods;
@property (weak, nonatomic) IBOutlet UIView *starView;


- (void)reloadCellWithModel:(LBMycommentModel *)model;
- (void)refreshwith:(NSString *)str;

@end
