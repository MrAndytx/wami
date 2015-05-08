//
//  meishiquanViewController.m
//  哇米
//
//  Created by wenga on 15/1/13.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "meishiquanViewController.h"
#import "meishiquanCell.h"

@interface meishiquanViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *meishiquantableview;

@end

@implementation meishiquanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationItem setTitle:@"美食圈"];
    self.tabBarController.tabBar.hidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    meishiquanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meishiquancell"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:cell.neirong.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, cell.neirong.text.length)];
    cell.neirong.attributedText = attributedString;

    return cell;
}

@end
