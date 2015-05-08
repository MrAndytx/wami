//
//  storeCell.h
//  哇米
//
//  Created by wenga on 15/1/8.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBUserComentModel.h"

@interface storeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIView *borderwidth;
@property (weak, nonatomic) IBOutlet UIView *bottomseperator;
@property (weak, nonatomic) IBOutlet UIView *leftseperator;
@property (weak, nonatomic) IBOutlet UIView *rightseperator;


@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *commentTime;
@property (weak, nonatomic) IBOutlet UILabel *commentContent;
@property (weak, nonatomic) IBOutlet UILabel *commentMenu;
@property (weak, nonatomic) IBOutlet UILabel *commentScore;

- (void)setData:(LBUserComentModel *)model;
@end
