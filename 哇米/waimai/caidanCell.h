//
//  caidanCell.h
//  哇米
//
//  Created by wenga on 15/1/8.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBCaidanGoodsListModel.h"

@protocol caidanCellDelegate <NSObject>

- (void)setSelectedDic:(NSDictionary *)dic andStatus:(int)state;

@end

@interface caidanCell : UITableViewCell
{
    int num ;
}
@property (weak, nonatomic) IBOutlet UIView *picborderwidth;
@property (nonatomic,strong)NSDictionary *modelDic;
@property (weak, nonatomic) IBOutlet UIImageView *ihot;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UIImageView *goods_pic_160;
@property (weak, nonatomic) IBOutlet UILabel *goods_price;
@property (weak, nonatomic) IBOutlet UIButton *inew;

@property (weak, nonatomic) IBOutlet UIView *sepe;

@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (weak, nonatomic) IBOutlet UIView *numView;
@property (weak, nonatomic) IBOutlet UIView *orderView;

@property (weak, nonatomic) IBOutlet UILabel *orderNum;
@property (weak, nonatomic) IBOutlet UIButton *orderReduce;
@property (weak, nonatomic) IBOutlet UIButton *orderAdd;
@property (nonatomic,strong)id<caidanCellDelegate> delegate;
- (void)setData:(LBCaidanGoodsListModel *)model;

@end
