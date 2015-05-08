//
//  storeViewController.m
//  哇米
//
//  Created by wenga on 15/1/6.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "storeViewController.h"
#import "caidanViewController.h"
#import "storeCell.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "AppDelegate.h"
#import "storeModel.h"
#import "activityModel.h"
#import "common.h"
#import "UIImageView+WebCache.h"
#import "LBUserComentModel.h"
#import "MJRefresh.h"

#define URL @"http://www.waomi.com/mapi/androidPhone/shopIndex"
#define COMURL @"http://www.waomi.com/mapi/androidPhone/shopComment"
@interface storeViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    MJRefreshBaseView *_baseview;
    MJRefreshFooterView *_footerview;
    MJRefreshHeaderView *_headerview;
    NSDictionary *dataDic;
    NSMutableArray *commentArray;
    NSString *nextUrl;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UILabel *waimaiyouhui;
@property (weak, nonatomic) IBOutlet UILabel *waimaiyouhui2;
@property (weak, nonatomic) IBOutlet UILabel *waimaiyouhui3;

@property (weak, nonatomic) IBOutlet UILabel *waimaitip;

@property (weak, nonatomic) IBOutlet UIView *btnview;
@property (weak, nonatomic) IBOutlet UIView *yellowView;
@property (weak, nonatomic) IBOutlet UIView *CTJJview;
@property (weak, nonatomic) IBOutlet UIView *phoneaddressview;
@property (weak, nonatomic) IBOutlet UIView *celltopview;


//相关数据控件
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopMainBusiness;
@property (weak, nonatomic) IBOutlet UILabel *shopPerPrice;
@property (weak, nonatomic) IBOutlet UILabel *shopAdress;
@property (weak, nonatomic) IBOutlet UILabel *shopTel;
@property (weak, nonatomic) IBOutlet UILabel *shopInfo;
@property (weak, nonatomic) IBOutlet UILabel *shopSale;

//用户评价部分




@property (nonatomic,assign)NSMutableArray *shopDataSource;

@property (nonatomic, assign) NSInteger index;
@end

@implementation storeViewController

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addbtnbordarwidth];
    [self addyellowviewborderwidth];
    [self addcelltopseperator];
    [self addCTJJborderwidth];
    [self addseperator];
    NSLog(@"%@",_sh_id);
    [self sendRequest:URL];
    [self AFNCommentRequest:COMURL];

    [self initfooterview];
    [self initheaderview];
    
    commentArray = [NSMutableArray array];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_waimaitip.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _waimaitip.text.length)];
    _waimaitip.attributedText = attributedString;
    
}

#pragma mark 请求方法
- (void)sendRequest:(NSString *)url
{
    
    //店铺首页
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
//    NSLog(@"%@",dic_all);
    
    NSMutableDictionary *option = [NSMutableDictionary dictionary];
    [option setObject:_sh_id forKey:@"sh_id"];
    [dic_all setObject:option forKey:@"option"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:url parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
    NSLog(@"%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            dataDic = responseObject[@"data"][@"option"];
            
            NSURL *imageUrl = [NSURL URLWithString:dataDic[@"shop_photo"]];
            [_shopImage sd_setImageWithURL:imageUrl placeholderImage:nil];
            
            _shopNameLabel.text = dataDic[@"sh_name"];
            _shopScoreLabel.text = [NSString stringWithFormat:@"%.1f",[dataDic[@"shop_score"] floatValue]];
            _shopPerPrice.text = [NSString stringWithFormat:@"人均: %@元",dataDic[@"capita_consum"]];
            _shopSale.text = dataDic[@"shop_salse"];
            _shopAdress.text = dataDic[@"shop_address"];
            _shopTel.text = [NSString stringWithFormat:@"电话: %@",dataDic[@"sh_tel"]];
            _waimaitip.text = dataDic[@"shop_notice"];
            _shopMainBusiness.text = [NSString stringWithFormat:@"主营: %@",dataDic[@"shop_caixi"]];
            
            if([dataDic[@"shop_activity"] count] ==0)
            {
                _waimaiyouhui.hidden = YES;
                _waimaiyouhui2.hidden = YES;
                _waimaiyouhui3.hidden = YES;
            }else if([dataDic[@"shop_activity"] count] ==1)
            {
                _waimaiyouhui.text = [NSString stringWithFormat:@"外卖: %@",dataDic[@"shop_activity"][0][@"activity_detail"] ];
                _waimaiyouhui2.hidden = YES;
                _waimaiyouhui3.hidden = YES;
            }else if([dataDic[@"shop_activity"] count] ==2)
            {
                _waimaiyouhui.text = [NSString stringWithFormat:@"外卖: %@",dataDic[@"shop_activity"][0][@"activity_detail"] ];
                _waimaiyouhui2.text = [NSString stringWithFormat:@"外卖: %@",dataDic[@"shop_activity"][1][@"activity_detail"] ];
                _waimaiyouhui3.hidden = YES;
            }else if([dataDic[@"shop_activity"] count] ==3)
            {
                _waimaiyouhui.text = [NSString stringWithFormat:@"外卖: %@",dataDic[@"shop_activity"][0][@"activity_detail"] ];
                _waimaiyouhui2.text = [NSString stringWithFormat:@"外卖: %@",dataDic[@"shop_activity"][1][@"activity_detail"] ];
                _waimaiyouhui3.text = [NSString stringWithFormat:@"外卖: %@",dataDic[@"shop_activity"][2][@"activity_detail"] ];
            }
            
//            _commentCount.text = [NSString stringWithFormat:@"(%@)",dataDic[@"comment_count"]];
        }else
        {
            SHOW_ALERT(@"提示", responseObject[@"error"]);
        }
        
     /*   NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"data"][@"option"]) {
            storeModel *model = [storeModel messageWithDict:dic];
            for (NSDictionary *subDic in model.shop_activity) {
                activityModel *model2  = [activityModel messageWithDict:subDic];
                [arr addObject:model2];
                //                NSLog(@"%@",model2.activity_color);
            }
            model.activityModelArr = arr;
            [_shopDataSource addObject:model];
                        NSLog(@"%@",model.activityModelArr);

        }
//        [_waimaitableview reloadData];
      */
  
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
        NSString *str = [NSString stringWithFormat:@"%@",error];
        NSLog(@"%@",str);
       
    }];
}

- (void)AFNCommentRequest:(NSString *)url
{
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *option = [NSMutableDictionary dictionary];
    [option setObject:_sh_id forKey:@"sh_id"];
    [dic_all setObject:option forKey:@"option"];
    AFHTTPRequestOperationManager *CommentManager = [[AFHTTPRequestOperationManager alloc]init];
    CommentManager.responseSerializer = [AFJSONResponseSerializer serializer];
    CommentManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [CommentManager POST:url parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"commentRES----%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"])
        {
            nextUrl = responseObject[@"nexturl"];
            
            [commentArray addObjectsFromArray:[LBUserComentModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"option"] error:nil]];
            [_tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error---%@",error);
    }];
}


#pragma mark 刷新
//下拉刷新相关
- (void)dealloc{
    [_footerview free];
    [_headerview free];
}

- (void)initfooterview{
    _footerview = [[MJRefreshFooterView alloc]initWithScrollView:_tableView];
    _footerview.delegate = self;
}

- (void)initheaderview{
    _headerview = [[MJRefreshHeaderView alloc]initWithScrollView:_tableView];
    _headerview.delegate = self;
}

//下拉刷新代理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    _baseview = refreshView;
    if (_baseview == _footerview) {
        
        if ([nextUrl length] >0) {
            [self AFNCommentRequest:nextUrl];
            
        }
        [self performSelector:@selector(hidden) withObject:nil afterDelay:1.5];
    }
    if (_baseview == _headerview) {
        commentArray = [NSMutableArray array];
        [self sendRequest:URL];
        [self AFNCommentRequest:COMURL];
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

#pragma mark 常用方法
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//添加按钮边框
- (void)addbtnbordarwidth{
    UIView *midh1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _btnview.frame.size.width, 0.5)];
    [midh1 setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [_btnview addSubview:midh1];
    
    UIView *midh2 = [[UIView alloc]initWithFrame:CGRectMake(0, (_btnview.frame.size.height-0.5)/2, _btnview.frame.size.width, 0.5)];
    [midh2 setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [_btnview addSubview:midh2];
    
    UIView *midh3 = [[UIView alloc]initWithFrame:CGRectMake(0, _btnview.frame.size.height-0.5, _btnview.frame.size.width, 0.5)];
    [midh3 setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [_btnview addSubview:midh3];
    
    UIView *firstv = [[UIView alloc]initWithFrame:CGRectMake((_btnview.frame.size.width-0.5)/2, 0, 0.5, _btnview.frame.size.height)];
    [firstv setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [_btnview addSubview:firstv];

}

//添加黄色区域边框
- (void)addyellowviewborderwidth{
    UIView *midh1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _yellowView.frame.size.width, 0.5)];
    [midh1 setBackgroundColor:[UIColor colorWithRed:253/255.0 green:226/255.0 blue:175/255.0 alpha:1]];
    [_yellowView addSubview:midh1];
    
    UIView *midh2 = [[UIView alloc]initWithFrame:CGRectMake(0, (_yellowView.frame.size.height-0.5)/2+8, _yellowView.frame.size.width, 0.5)];
    [midh2 setBackgroundColor:[UIColor colorWithRed:253/255.0 green:226/255.0 blue:175/255.0 alpha:1]];
    [_yellowView addSubview:midh2];
    
    UIView *midh3 = [[UIView alloc]initWithFrame:CGRectMake(0, _yellowView.frame.size.height-0.5, _yellowView.frame.size.width, 0.5)];
    [midh3 setBackgroundColor:[UIColor colorWithRed:253/255.0 green:226/255.0 blue:175/255.0 alpha:1]];
    [_yellowView addSubview:midh3];
    
    UIView *firstv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, _yellowView.frame.size.height)];
    [firstv setBackgroundColor:[UIColor colorWithRed:253/255.0 green:226/255.0 blue:175/255.0 alpha:1]];
    [_yellowView addSubview:firstv];

    
    UIView *firstv2 = [[UIView alloc]initWithFrame:CGRectMake(_yellowView.frame.size.width-0.5, 0, 0.5, _yellowView.frame.size.height)];
    [firstv2 setBackgroundColor:[UIColor colorWithRed:253/255.0 green:226/255.0 blue:175/255.0 alpha:1]];
    [_yellowView addSubview:firstv2];


}

//cell顶部分割线
- (void)addcelltopseperator{
    UIView *midh1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _celltopview.frame.size.width, 0.5)];
    [midh1 setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [_celltopview addSubview:midh1];
}

//地址电话边框
- (void)addseperator{
    _phoneaddressview.layer.borderWidth = 0.5;
    _phoneaddressview.layer.borderColor = [[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]CGColor];
    
    UIView *midh2 = [[UIView alloc]initWithFrame:CGRectMake(0, (_phoneaddressview.frame.size.height-0.5)/2, _phoneaddressview.frame.size.width, 0.5)];
    [midh2 setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [_phoneaddressview addSubview:midh2];
}

//餐厅简介边框
- (void)addCTJJborderwidth{
    _CTJJview.layer.borderWidth = 0.5;
    _CTJJview.layer.borderColor = [[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]CGColor];
    
    UIView *midh2 = [[UIView alloc]initWithFrame:CGRectMake(0, (_CTJJview.frame.size.height-0.5)/2-10, _CTJJview.frame.size.width, 0.5)];
    [midh2 setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [_CTJJview addSubview:midh2];
}

- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)dianwaimaibtn:(id)sender {
    if ([dataDic[@"shop_service"] isEqualToString:@"1"]) {
        _index = 0;
        [self performSegueWithIdentifier :@"caiDan" sender:self];
    }else
    {
        SHOW_ALERT(@"提示", @"暂未开通此服务");
    }
   
}

- (IBAction)yudingbtn:(id)sender {
    if ([dataDic[@"shop_service"] isEqualToString:@"3"]) {
        _index = 1;
        [self performSegueWithIdentifier :@"caiDan" sender:self];
    }else
    {
        SHOW_ALERT(@"提示", @"暂未开通此服务");
    }
    
}

- (IBAction)diancaibtn:(id)sender {
    if ([dataDic[@"shop_service"] isEqualToString:@"2"]) {
        _index = 2;
        [self performSegueWithIdentifier :@"caiDan" sender:self];
    }else
    {
        SHOW_ALERT(@"提示", @"暂未开通此服务");
    }
    
}

- (IBAction)addCollectionFunction:(id)sender {
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
    [CommentManager POST:@"http://www.waomi.com/mapi/androidPhone/addcollect" parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"collectionRES----%@",responseObject);
        SHOW_ALERT(@"提示", responseObject[@"error"]);
       /* if ([responseObject[@"status"] isEqualToString:@"1"])
        {
            nextUrl = responseObject[@"nexturl"];
            
            [commentArray addObjectsFromArray:[LBUserComentModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"option"] error:nil]];
            [_tableView reloadData];
        }*/
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error---%@",error);
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    caidanViewController *caiDanVC = segue.destinationViewController;
    caiDanVC.index = _index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 3;
    }
    else{
        return commentArray.count+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    storeCell *cell = [[storeCell alloc]init];
    
    
    if (indexPath.row==0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"storecell"];
        cell.borderwidth.layer.borderWidth = 0.5;
        cell.borderwidth.layer.borderColor = [[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]CGColor];
        cell.commentCount.text = [NSString stringWithFormat:@"(%@)",dataDic[@"comment_count"]];
    }
    
    else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"pingjia"];
        
        [cell setData:commentArray[indexPath.row-1]];
        //添加边框
        UIView *left = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, cell.leftseperator.frame.size.height)];
        [left setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
        [cell.leftseperator addSubview:left];
        
        UIView *right = [[UIView alloc]initWithFrame:CGRectMake(0, 0.5, 0.5, cell.rightseperator.frame.size.height)];
        [right setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
        [cell.rightseperator addSubview:right];
        
        UIView *buttom = [[UIView alloc]initWithFrame:CGRectMake(0, 0.5, cell.bottomseperator.frame.size.width, 0.5)];
        [buttom setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
        [cell.bottomseperator addSubview:buttom];

        }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 44;
    }
    else{
        return 80;
    }
    }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    viewHeader.backgroundColor = [UIColor colorWithRed:1-100/255 green:1-100/255 blue:1-100/255 alpha:1];
    return viewHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *viewfooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 10)];
    viewfooter.backgroundColor = [UIColor colorWithRed:1-160/255 green:1-160/255 blue:1-160/255 alpha:1];
    return viewfooter;
}
@end
