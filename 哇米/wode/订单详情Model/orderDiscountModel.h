//
//  orderDiscountModel.h
//  哇米
//
//  Created by Apple on 15/4/24.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "JSONModel.h"

@protocol orderDiscountModel <NSObject>



@end

@interface orderDiscountModel : JSONModel
@property (nonatomic,strong) NSString<Optional> *discount_name;//优惠项目
@property (nonatomic,strong) NSString<Optional> *discount_sum;//优惠金额


@end
