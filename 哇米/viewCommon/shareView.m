//
//  shareView.m
//  哇米
//
//  Created by wenga on 15/1/7.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "shareView.h"

@implementation shareView

- (void)addsharebtn{
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _Friends = [[UIButton alloc]initWithFrame:CGRectMake(width*0.15, height*0.1, 30, 30)];
    [_Friends setImage:[UIImage imageNamed:@"pengyouquan_shar.png"] forState:UIControlStateNormal];
    UILabel *friendlabel = [[UILabel alloc]initWithFrame:CGRectMake(width*0.15, height*0.1+30+5, 30, 10)];
    [friendlabel setText:@"朋友圈"];
    [friendlabel setTextAlignment:NSTextAlignmentCenter];
    [friendlabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self addSubview:_Friends];
    [self addSubview:friendlabel];
}

- (void)addwebchatbtn{
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _Webchat = [[UIButton alloc]initWithFrame:CGRectMake(width*0.35, height*0.1, 30, 30)];
    [_Webchat setImage:[UIImage imageNamed:@"duanxin_shar.png"] forState:UIControlStateNormal];
    UILabel *webchatlabel = [[UILabel alloc]initWithFrame:CGRectMake(width*0.35, height*0.1+30+5, 30, 10)];
    [webchatlabel setText:@"微信好友"];
    [webchatlabel setTextAlignment:NSTextAlignmentCenter];
    [webchatlabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self addSubview:_Webchat];
    [self addSubview:webchatlabel];
}

- (void)addsinabtn{
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _Sina = [[UIButton alloc]initWithFrame:CGRectMake(width*0.55, height*0.1, 30, 30)];
    [_Sina setImage:[UIImage imageNamed:@"sina_weibo_shar.png"] forState:UIControlStateNormal];
    UILabel *sinalabel = [[UILabel alloc]initWithFrame:CGRectMake(width*0.55, height*0.1+30+5, 30, 10)];
    [sinalabel setText:@"新浪微博"];
    [sinalabel setTextAlignment:NSTextAlignmentCenter];
    [sinalabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self addSubview:_Sina];
    [self addSubview:sinalabel];
}

- (void)addQQbtn{
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _QQ = [[UIButton alloc]initWithFrame:CGRectMake(width*0.75, height*0.1, 30, 30)];
    [_QQ setImage:[UIImage imageNamed:@"qq_shar.png"] forState:UIControlStateNormal];
    UILabel *qqlabel = [[UILabel alloc]initWithFrame:CGRectMake(width*0.75, height*0.1+30+5, 30, 10)];
    [qqlabel setText:@"新浪微博"];
    [qqlabel setTextAlignment:NSTextAlignmentCenter];
    [qqlabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self addSubview:_QQ];
    [self addSubview:qqlabel];
}

- (void)addQzonebtn{
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _Qzone = [[UIButton alloc]initWithFrame:CGRectMake(width*0.15, height*0.35, 30, 30)];
    [_Qzone setImage:[UIImage imageNamed:@"qq_zone_shar.png"] forState:UIControlStateNormal];
    UILabel *qzonelabel = [[UILabel alloc]initWithFrame:CGRectMake(width*0.15, height*0.35+30+5, 30, 10)];
    [qzonelabel setText:@"QQ空间"];
    [qzonelabel setTextAlignment:NSTextAlignmentCenter];
    [qzonelabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self addSubview:_Qzone];
    [self addSubview:qzonelabel];
}

- (void)addTXweibobtn{
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _TXweibo = [[UIButton alloc]initWithFrame:CGRectMake(width*0.35, height*0.35, 30, 30)];
    [_TXweibo setImage:[UIImage imageNamed:@"qq_weibo_shar.png"] forState:UIControlStateNormal];
    UILabel *TXweibolabel = [[UILabel alloc]initWithFrame:CGRectMake(width*0.35, height*0.35+30+5, 30, 10)];
    [TXweibolabel setText:@"腾讯微博"];
    [TXweibolabel setTextAlignment:NSTextAlignmentCenter];
    [TXweibolabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self addSubview:_TXweibo];
    [self addSubview:TXweibolabel];
}

//- (void)addMessagebobtn{
//    
//    CGFloat width = self.bounds.size.width;
//    CGFloat height = self.bounds.size.height;
//    _Message = [[UIButton alloc]initWithFrame:CGRectMake(width*0.35, height*0.35, 30, 30)];
//    [_Message setImage:[UIImage imageNamed:@"qq_weibo_shar.png"] forState:UIControlStateNormal];
//    UILabel *Messagelabel = [[UILabel alloc]initWithFrame:CGRectMake(width*0.35, height*0.35+30+5, 30, 10)];
//    [Messagelabel setText:@"腾讯微博"];
//    [Messagelabel setTextAlignment:NSTextAlignmentCenter];
//    [Messagelabel setFont:[UIFont systemFontOfSize:12.0f]];
//    [self addSubview:_Message];
//    [self addSubview:Messagelabel];
//}

@end
