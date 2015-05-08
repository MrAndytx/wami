//
//  scanViewController.h
//  哇米
//
//  Created by wenga on 15/1/24.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface scanViewController : UIViewController
{
    ZBarReaderView *readerView;
    ZBarCameraSimulator *cameraSim;
}
@property (retain, nonatomic) IBOutlet ZBarReaderView *readerView;
@end
