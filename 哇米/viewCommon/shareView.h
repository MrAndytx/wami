//
//  shareView.h
//  哇米
//
//  Created by wenga on 15/1/7.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shareView : UIView

@property(nonatomic)UIButton *Friends;
@property(nonatomic)UIButton *Webchat;
@property(nonatomic)UIButton *Sina;
@property(nonatomic)UIButton *QQ;
@property(nonatomic)UIButton *Qzone;
@property(nonatomic)UIButton *TXweibo;
@property(nonatomic)UIButton *Message;
@property(nonatomic)UIButton *Mail;
@property(nonatomic)UIButton *Url;
@property(nonatomic)UIButton *Content;
@property(nonatomic)UIButton *Cancel;

- (void)addsharebtn;

@end
