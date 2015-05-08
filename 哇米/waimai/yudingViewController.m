//
//  yudingViewController.m
//  哇米
//
//  Created by wenga on 15/1/8.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "yudingViewController.h"
#import "yudingCell.h"

@interface yudingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation yudingViewController

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    yudingCell *cell = nil;
    if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cexiaocell"];
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"yudingcell"];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return 44;
    }
    else{
        return 100;
    }
}
@end
