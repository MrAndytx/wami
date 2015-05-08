//
//  adWebViewController.m
//  哇米
//
//  Created by Apple on 15/4/19.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "adWebViewController.h"

@interface adWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation adWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
  
    
    self.navigationController.navigationBar.hidden = YES;
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:73/255.0f green:52/255.0f  blue:40/255.0f  alpha:1.0]];
    
//    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBarButton setBackgroundImage:[UIImage imageNamed:@"wm_top_arrow"] forState:UIControlStateNormal];
//    
//    [leftBarButton addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
//    [leftBarButton setFrame:CGRectMake(10, 10, 12, 12)];
//    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:leftBarButton]];

}


#pragma mark - Custom Method
//- (void)backBtn {
//   [self dismissViewControllerAnimated:YES completion:nil];
//}
- (IBAction)back:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}


@end
