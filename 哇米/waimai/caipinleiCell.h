//
//  caipinleiCell.h
//  哇米
//
//  Created by wenga on 15/1/19.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBCaidanModel.h"

@interface caipinleiCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *caifenlei;
@property (weak, nonatomic) IBOutlet UILabel *hadordernum;
@property (weak, nonatomic) IBOutlet UIImageView *leftarrowimage;

@property (weak, nonatomic) IBOutlet UIView *rightred;
@property (weak, nonatomic) IBOutlet UIView *rightsep;
@property (weak, nonatomic) IBOutlet UIView *bottomsep;

@property (nonatomic,strong)NSString *sort_id;

- (void)setTypeData:(LBCaidanModel *)model;
@end
