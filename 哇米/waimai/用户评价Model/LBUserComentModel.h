//
//  LBUserComentModel.h
//  哇米
//
//  Created by Apple on 15/5/3.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "JSONModel.h"

@interface LBUserComentModel : JSONModel
@property (nonatomic,strong) NSString<Optional> *user_name;
@property (nonatomic,strong) NSString<Optional> *addtime;//评论时间
@property (nonatomic,strong) NSString<Optional> *score;
@property (nonatomic,strong) NSString<Optional> *content;
@property (nonatomic,strong) NSString<Optional> *menu_str;
@end
