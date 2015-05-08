//
//  rateViewController.m
//  哇米
//
//  Created by wenga on 15/1/14.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "rateViewController.h"
#import "CWStarRateView.h"

@interface rateViewController ()

@property (weak, nonatomic) IBOutlet CWStarRateView *star1;
@property (weak, nonatomic) IBOutlet CWStarRateView *star2;
@property (weak, nonatomic) IBOutlet CWStarRateView *star3;
@property (weak, nonatomic) IBOutlet CWStarRateView *star4;
@property (weak, nonatomic) IBOutlet CWStarRateView *star5;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;

@end

@implementation rateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_star1 initWithFrame:CGRectMake(0, 0, 20, 50) numberOfStars:5 bgImg:@"wm_score_b.png" foreImg:@"wm_score_a.png"];
    
    [_star2 initWithFrame:CGRectMake(0, 0, 0, 0) numberOfStars:5 bgImg:@"wm_score_b.png" foreImg:@"wm_score_a.png"];
    [_star3 initWithFrame:CGRectMake(0, 0, 0, 0) numberOfStars:5 bgImg:@"wm_score_b.png" foreImg:@"wm_score_a.png"];
    [_star4 initWithFrame:CGRectMake(0, 0, 0, 0) numberOfStars:5 bgImg:@"wm_score_b.png" foreImg:@"wm_score_a.png"];
    [_star5 initWithFrame:CGRectMake(0, 0, 0, 0) numberOfStars:5 bgImg:@"wm_score_b.png" foreImg:@"wm_score_a.png"];
//    CGRect frame = _view1.frame;
//    CWStarRateView *star1 = [[CWStarRateView alloc]initWithFrame:CGRectMake(85, (frame.size.height-20)/2, 150, 20) numberOfStars:5 bgImg:@"wm_score_b.png" foreImg:@"wm_score_a.png"];
//    [_view1 addSubview:star1];
//    
//    CWStarRateView *star2 = [[CWStarRateView alloc]initWithFrame:CGRectMake(85, (frame.size.height-20)/2, 150, 20) numberOfStars:5 bgImg:@"wm_score_b.png" foreImg:@"wm_score_a.png"];
//    [_view2 addSubview:star2];
//    
//    CWStarRateView *star3 = [[CWStarRateView alloc]initWithFrame:CGRectMake(85, (frame.size.height-20)/2, 150, 20) numberOfStars:5 bgImg:@"wm_score_b.png" foreImg:@"wm_score_a.png"];
//    [_view3 addSubview:star3];
//    
//    CWStarRateView *star4 = [[CWStarRateView alloc]initWithFrame:CGRectMake(85, (frame.size.height-20)/2, 150, 20) numberOfStars:5 bgImg:@"wm_score_b.png" foreImg:@"wm_score_a.png"];
//    [_view4 addSubview:star4];
//    
//    CWStarRateView *star5 = [[CWStarRateView alloc]initWithFrame:CGRectMake(85, (frame.size.height-20)/2, 150, 20) numberOfStars:5 bgImg:@"wm_score_b.png" foreImg:@"wm_score_a.png"];
//    [_view5 addSubview:star5];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
