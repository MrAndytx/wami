//
//  myCell.h
//  哇米
//
//  Created by wenga on 15/1/9.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIView *bordenWidth;
@property (weak, nonatomic) IBOutlet UIImageView *redLight;

-(void)showRedLight:(NSString *)num;
@end
