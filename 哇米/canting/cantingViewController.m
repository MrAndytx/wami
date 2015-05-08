//
//  cantingViewController.m
//  哇米
//
//  Created by wenga on 15/1/5.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "cantingViewController.h"
#import "toptipview.h"
#import "cantingcell.h"
#import "storeViewController.h"
#import "MXPullDownMenu.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "mapViewController.h"
#import "storeViewController.h"
#import "common.h"

@interface cantingViewController ()<UITableViewDelegate,UITableViewDataSource,MXPullDownMenuDelegate,MJRefreshBaseViewDelegate>
{
    MJRefreshBaseView *_baseview;
    MJRefreshFooterView *_footerview;
    MJRefreshHeaderView *_headerview;
    
    NSMutableArray *shopDataSource;
    
    NSString *_morePage;
    
    MXPullDownMenu *caidanpull;
    
    NSMutableArray *array1;//口味
    NSMutableArray *arr1;//口味对应ID
    NSMutableArray *array2;//人均
    NSMutableArray *arr2;//人均对应ID
    NSMutableArray *array3;//距离
    NSMutableArray *arr3;//距离对应ID
    
    NSMutableArray *_listDataSource1;
    NSMutableArray *_listDataSource2;
    NSMutableArray *_listDataSource3;
    
    NSMutableArray *_pullmenukey;
    NSMutableArray *_pullmenuvalue;
    
    NSMutableDictionary *_option;

}
@property (weak, nonatomic) IBOutlet UITableView *cantingtableview;

@end

@implementation cantingViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
   }

- (void)viewDidLoad {
    [super viewDidLoad];
    _pullmenukey = [NSMutableArray arrayWithObjects:@"dishid",@"price_id",@"costs", nil];
    _pullmenuvalue = [NSMutableArray array];
    _option = [NSMutableDictionary dictionary];
    [self addtoptip];
    [self buildpull];
    [self initfooterview];
    [self initheaderview];
    [self getlist];
    shopDataSource = [NSMutableArray array];
    _listDataSource1 = [NSMutableArray array];
    _listDataSource2 = [NSMutableArray array];
    _listDataSource3 = [NSMutableArray array];
    [self sendRequest:@"http://www.waomi.com/mapi/androidPhone/wmshoplist" withKey:@"" andValue:@""];

    
}

- (void)getlist{
    //获取当前时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    //筛选
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *list_dic = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *listoption = [NSMutableDictionary dictionary];
    [listoption setObject:timeString forKey:@"tmp"];
    [listoption setObject:@"near" forKey:@"action"];
    [list_dic setObject:listoption forKey:@"option"];
//    NSLog(@"%@",list_dic);
    NSString *filterList = @"http://www.waomi.com/mapi/androidPhone/filterList";
    [manager POST:filterList parameters:list_dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                        NSLog(@"%@",responseObject);
        _listDataSource1 = responseObject[@"data"][@"option"][0][@"filter_list"];
        _listDataSource2 = responseObject[@"data"][@"option"][1][@"filter_list"];
        _listDataSource3 = responseObject[@"data"][@"option"][2][@"filter_list"];
        [self refreshpull];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
    }];
    
    
}


- (void)sendRequest:(NSString *)url withKey:(NSString *)key andValue:(NSString *)value
{
    
    //店铺列表
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    [_option setObject:value forKey:key];
    [dic_all setObject:_option forKey:@"option"];
    AFHTTPRequestOperationManager *manager2 = [[AFHTTPRequestOperationManager alloc]init];
    manager2.responseSerializer = [AFJSONResponseSerializer serializer];
    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager2 POST:url parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                NSLog(@"%@",responseObject);
        
        for (NSDictionary *dic in responseObject[@"data"][@"option"]) {
            waimaimodel *model = [waimaimodel messageWithDict:dic];
            [shopDataSource addObject:model];
//            NSLog(@"%@",shopDataSource);
            
        }
        [_cantingtableview reloadData];
        _morePage = [responseObject objectForKey:@"nexturl"];
//        NSLog(@"%@",_morePage);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc{
    [_footerview free];
    [_headerview free];
}

- (void)initfooterview{
    _footerview = [[MJRefreshFooterView alloc]initWithScrollView:_cantingtableview];
    _footerview.delegate = self;
}

- (void)initheaderview{
    _headerview = [[MJRefreshHeaderView alloc]initWithScrollView:_cantingtableview];
    _headerview.delegate = self;
}

//下拉刷新代理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    _baseview = refreshView;
    if (![_morePage  isEqual: @"null"]) {
        [self sendRequest:_morePage withKey:@"" andValue:@""];
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

//创建下拉菜单
- (void)buildpull{
    NSArray *caidanarr = @[@"口味不限" , @"人均不限", @"距离" ];
    
    caidanpull = [[MXPullDownMenu alloc]initWithArray:caidanarr Frame:(CGRect)CGRectMake(0, 94, self.view.bounds.size.width, 35) selectedColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]];
    caidanpull.delegate = self;
//    [caidanpull setFrame:CGRectMake(0, 94, self.view.bounds.size.width, 30)];
    [self.view addSubview:caidanpull];
}

//刷新下拉列表
- (void)refreshpull{
    array1 = [NSMutableArray array];
    arr1 = [NSMutableArray array];
    array2 = [NSMutableArray array];
    arr2 = [NSMutableArray array];
    array3 = [NSMutableArray array];
    arr3 = [NSMutableArray array];
    for (int i = 0; i<_listDataSource1.count; i++) {
        [array1 addObject:[_listDataSource1[i] objectForKey:@"item_name"]];
        NSString *id = [NSString stringWithFormat:@"%@",[_listDataSource1[i] objectForKey:@"item_id"]];
        [arr1 addObject:id];
    }
    [_pullmenuvalue addObject:arr1];
    
    for (int j= 0 ; j<_listDataSource2.count; j++) {
        [array2 addObject:[_listDataSource2[j] objectForKey:@"item_name"]];
        NSString *id = [NSString stringWithFormat:@"%@",[_listDataSource2[j] objectForKey:@"item_id"]];
        [arr2 addObject:id];
    }
    [_pullmenuvalue addObject:arr2];
    for (int k=0; k<_listDataSource3.count; k++) {
        [array3 addObject:[_listDataSource3[k] objectForKey:@"item_name"]];
        NSString *id = [NSString stringWithFormat:@"%@",[_listDataSource3[k] objectForKey:@"item_id"]];
        [arr3 addObject:id];
    }
    [_pullmenuvalue addObject:arr3];
    [caidanpull refreshListWithArray1:array1 Array2:array2 Array3:array3];
}

#pragma mark - 添加黄色顶部条
- (void)addtoptip{
    toptipview *waimaitoptip = [[toptipview alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 30)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width*0.7, 30)];
    [label setText: @"衡阳市雁峰区中山南路时代宾馆13号"];
    label.font = [UIFont systemFontOfSize:12.0f];
    [label setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]];

    UIImageView *toptipview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-10-15, 8, 13, 13)];
    [toptipview setImage:[UIImage imageNamed:@"wm_ic_map_location.png"]];
    
    UIView *buttomseperator = [[UIView alloc]initWithFrame:CGRectMake(0, 29.5, self.view.frame.size.width, 0.5)];
    [buttomseperator setBackgroundColor:[UIColor colorWithRed:253/255.0 green:226/255.0 blue:175/255.0 alpha:1]];
    [waimaitoptip addSubview:buttomseperator];

    [waimaitoptip addSubview:label];
    [waimaitoptip addSubview:toptipview];
    waimaitoptip.backgroundColor = [UIColor colorWithRed:253/255.0 green:249/255.0 blue:216/255.0 alpha:1];
    [self.view addSubview:waimaitoptip];
}


#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return shopDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    waimaimodel *model = shopDataSource[indexPath.row];
    
    cantingcell *cantingcell = [tableView dequeueReusableCellWithIdentifier:@"cantingcell1"];
    cantingcell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //添加分割线
    UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(0, cantingcell.buttonseperator.frame.size.height-0.5, cantingcell.buttonseperator.frame.size.width, 0.5)];
    [seperator setBackgroundColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1]];//[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [cantingcell.buttonseperator addSubview:seperator];
    
    [cantingcell reloadCellWithModel:model];
    
    return cantingcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *path = [_cantingtableview indexPathForSelectedRow];
    cantingcell *cell = (cantingcell *)[_cantingtableview cellForRowAtIndexPath:path];
    extern NSNumber *_sh_id;
//    NSLog(@"%@",cell.sh_id);
    _sh_id = cell.sh_id;
    
    UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    storeViewController *cantingshouye = [sto instantiateViewControllerWithIdentifier:@"cantingshouye"];
            cantingshouye.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cantingshouye animated:YES];
//    [self performSelector:@selector(changeCellColor:) withObject:cell afterDelay:1];
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)changeCellColor:(UITableViewCell*)cell
{
    cell.selected = NO;
    cell.backgroundColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
}

// 实现下拉菜单代理.
#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    NSString *key = _pullmenukey[column];
    NSString *value = _pullmenuvalue[column][row];
    [shopDataSource removeAllObjects];
    [self sendRequest:@"http://www.waomi.com/mapi/androidPhone/wmshoplist" withKey:key andValue:value];
}
@end
