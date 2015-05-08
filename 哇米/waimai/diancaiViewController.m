//
//  diancaiViewController.m
//  哇米
//
//  Created by wenga on 15/1/8.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "diancaiViewController.h"
#import "diancaiCell.h"

@interface diancaiViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation diancaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - tableview代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    diancaiCell *cell = nil;
    if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cuxiaocell"];
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"diancaicell"];
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
