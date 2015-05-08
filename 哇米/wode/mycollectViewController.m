//
//  mycollectViewController.m
//  哇米
//
//  Created by wenga on 15/1/9.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "mycollectViewController.h"
#import "mycollectCell.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "LBMyCollectionModel.h"
#import "MJRefresh.h"
#import "common.h"

#define URL @"http://www.waomi.com/mapi/androidPhone/mycollect"
@interface mycollectViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{ 
  
    MJRefreshBaseView *_baseview;
    MJRefreshFooterView *_footerview;
    MJRefreshHeaderView *_headerview;
    NSMutableArray *dataArray;
    NSString *nexturl;
    CGPoint point;
}
@property (weak, nonatomic) IBOutlet UITableView *mycollectiontableview;
@property (weak, nonatomic) IBOutlet UIView *longPressView;
@property (weak, nonatomic) IBOutlet UIView *longPressViewWhite;

@end

@implementation mycollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initfooterview];
    [self initheaderview];
    
    UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(39.75, 0, 180, 0.5)];
    [seperator setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]];
    [_longPressViewWhite addSubview:seperator];
    dataArray = [NSMutableArray array];
    [self getUserCollection:URL];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//哇米提醒
- (IBAction)tip:(id)sender {
}

//删除店铺
- (IBAction)drop:(id)sender {
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *option = [NSMutableDictionary dictionary];
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *user_uid = [userInfo objectForKey:@"user_uid"];
    [option setObject:user_uid forKey:@"uid"];
    [option setObject:_sh_id forKey:@"sh_id"];
    [dic_all setObject:option forKey:@"option"];
    AFHTTPRequestOperationManager *CommentManager = [[AFHTTPRequestOperationManager alloc]init];
    CommentManager.responseSerializer = [AFJSONResponseSerializer serializer];
    CommentManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [CommentManager POST:@"http://www.waomi.com/mapi/androidPhone/delcollect" parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"collectionRES----%@",responseObject);
        
//        if ([responseObject[@"status"] isEqualToString:@"1"])
//         {
//
            [_longPressView setHidden:YES];
            [self getUserCollection:URL];
//        }
//        SHOW_ALERT(@"提示", responseObject[@"error"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error---%@",error);
    }];

    
}

- (void)getUserCollection:(NSString *)url
{
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *option = [[NSMutableDictionary alloc]init];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *user_uid = [userInfo objectForKey:@"user_uid"];
    [option setObject:user_uid forKey:@"uid"];
    [dic_all setObject:option forKey:@"option"];
    //    NSLog(@"%@",dic_all);
    AFHTTPRequestOperationManager *manager2 = [[AFHTTPRequestOperationManager alloc]init];
    manager2.responseSerializer = [AFJSONResponseSerializer serializer];
    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager2 POST:url parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        nexturl = responseObject[@"nexturl"];
        
        if ([responseObject[@"status"] isEqualToString:@"1"])
        {
            [dataArray addObjectsFromArray:[LBMyCollectionModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"option"] error:nil]];
            [_mycollectiontableview reloadData];
        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
    }];
    
}

- (IBAction)backbtn:(id)sender {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    int way = app.myordershowway;
    if (way == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (void)longPressTarget:(UILongPressGestureRecognizer *)gesture
{
    
   
//    if(gesture.state == UIGestureRecognizerStateBegan)
//    {
        CGPoint point2 = [gesture locationInView:_mycollectiontableview];
        
        NSIndexPath * indexPath = [_mycollectiontableview  indexPathForRowAtPoint:point2];
    
        mycollectCell *cell = (mycollectCell *)[_mycollectiontableview cellForRowAtIndexPath:indexPath];
      extern NSNumber *_sh_id;
    //    NSLog(@"%@",cell.sh_id);
    _sh_id = cell.sh_id;
        
        
        //add your code here
        
        
        
//    }
    _longPressView.hidden = NO;

}


//点击屏幕退出长按界面
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    if (!([touch.view isEqual:_longPressView])) {
        _longPressView.hidden = YES;
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark 刷新
//下拉刷新相关
- (void)dealloc{
    [_footerview free];
    [_headerview free];
}

- (void)initfooterview{
    _footerview = [[MJRefreshFooterView alloc]initWithScrollView:_mycollectiontableview];
    _footerview.delegate = self;
}

- (void)initheaderview{
    _headerview = [[MJRefreshHeaderView alloc]initWithScrollView:_mycollectiontableview];
    _headerview.delegate = self;
}

//下拉刷新代理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    _baseview = refreshView;
    if (_baseview == _footerview) {
        
        if (![nexturl isEqual:@"null"]) {
            [self getUserCollection:nexturl];
            
        }
        [self performSelector:@selector(hidden) withObject:nil afterDelay:1.5];
    }
    if (_baseview == _headerview) {
        dataArray = [NSMutableArray array];
        [self getUserCollection:URL];
        _baseview = refreshView;
        [self performSelector:@selector(hidden) withObject:nil afterDelay:1.5];
    }
    
}

- (void)hidden
{
    if (_baseview == _headerview)
    {
        [_headerview endRefreshing];
    }
    else
    {
        [_footerview endRefreshing];
    }
}


#pragma mark - tableview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    mycollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycollectcell"];
  
    [cell setData:dataArray[indexPath.row]];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressTarget:)];
//    longPress.view.tag = [[dataArray[indexPath.row] sh_id] intValue];
    
//    cell.sh_id = [dataArray[indexPath.row] sh_id];
    longPress.minimumPressDuration = 1.0;
    point = [longPress locationInView:self.view];
    [cell addGestureRecognizer:longPress];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *path = [_mycollectiontableview indexPathForSelectedRow];
    mycollectCell *cell = (mycollectCell *)[_mycollectiontableview cellForRowAtIndexPath:path];
    extern NSNumber *_sh_id;
    //    NSLog(@"%@",cell.sh_id);
    _sh_id = cell.sh_id;
}

@end
