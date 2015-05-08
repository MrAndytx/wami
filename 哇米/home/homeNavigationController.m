//
//  homeNavigationController.m
//  wami
//
//  Created by wenga on 14/12/31.
//  Copyright (c) 2014年 wenga. All rights reserved.
//

#import "homeNavigationController.h"


@interface homeNavigationController ()

@end

@implementation homeNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topcolor.png"]]];;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
