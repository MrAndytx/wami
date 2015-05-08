//
//  pingjiaViewController.m
//  哇米
//
//  Created by wenga on 15/1/7.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "pingjiaViewController.h"
#import "pingjiaCell.h"

@interface pingjiaViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation pingjiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didKeyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.navigationController.navigationBarHidden = YES;
}
- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///点击退出键盘
- (IBAction)didTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    
}

//弹出键盘改变高度
- (void)didKeyboardChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    //键盘尺寸
    NSValue *bFrame = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [bFrame CGRectValue];
    
    //动画时间
    //    NSString *dStr = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //    CGFloat duration = [dStr floatValue];
    
    CGRect rect = self.view.bounds;
    
    //键盘隐藏，视图恢复正常位置
    if (keyboardFrame.origin.y >= self.view.frame.size.height) {
        self.view.frame = CGRectMake(0, 0, rect.size.width, rect.size.height + keyboardFrame.size.height);
    }
    else {
        
        self.view.frame = CGRectMake(0, 0, rect.size.width, rect.size.height - keyboardFrame.size.height);
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - Tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    pingjiaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pingjiacell"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:cell.neirong.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, cell.neirong.text.length)];
    cell.neirong.attributedText = attributedString;
    return cell;
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
