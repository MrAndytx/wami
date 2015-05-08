//
//  AppDelegate.h
//  哇米
//
//  Created by wenga on 15/1/4.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import <AdSupport/ASIdentifierManager.h>
#import "common.h"

static NSString *_myLocation;
static NSString *_userID;
//static NSDictionary *_commonDic;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager *_MapManager;
    BMKLocationService *_locService;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,copy)NSString *myviewstr;
@property (nonatomic,assign)int storenum;
@property (nonatomic,assign)int myordershowway;


@end

