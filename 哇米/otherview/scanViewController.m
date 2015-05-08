//
//  scanViewController.m
//  哇米
//
//  Created by wenga on 15/1/24.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "scanViewController.h"

@interface scanViewController ()<ZBarReaderViewDelegate>


@end

@implementation scanViewController

@synthesize readerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createReaderview];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [readerView start];
}

- (void)viewDidDisappear:(BOOL)animated{
    [readerView stop];
}


- (void)createReaderview{
    readerView = [[ZBarReaderView alloc]initWithFrame:CGRectMake( 0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    readerView.readerDelegate = self;
    [readerView setAllowsPinchZoom:YES];
    if (TARGET_IPHONE_SIMULATOR) {
        cameraSim = [[ZBarCameraSimulator alloc] initWithViewController:self];
        cameraSim.readerView = readerView;
    }

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 二维码扫描代理
- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image{
    NSString *codeData = [[NSString alloc]init];
    for (ZBarSymbol *sym in symbols) {
        codeData = sym.data;
        break;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:codeData delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 得到条形码结果
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    //获得到条形码
    //NSString *dataNum=symbol.data;
    //扫描界面退出
    [picker dismissModalViewControllerAnimated: YES];
}

@end
