//
//  caidanViewController.m
//  哇米
//
//  Created by wenga on 15/1/8.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "caidanViewController.h"
#import "yudingViewController.h"
#import "diancaiViewController.h"
#import "tijiaoddViewController.h"
#import "toptipview.h"
#import "caidanCell.h"
#import "MJRefresh.h"
#import "caipinleiCell.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "candanModel.h"
#import "common.h"
#import "caipinleiModel.h"
#import "LBCaidanModel.h"

@interface caidanViewController ()<UITableViewDataSource,UITableViewDelegate,caidanCellDelegate>
{
   
    NSMutableArray *dataArray;
    NSMutableArray *typeArray;
    NSMutableArray *caidanArray;
    NSString *_morePage;
    
    NSString *_sortId;
    int selectNum;
    NSString *orderState;
    NSString *checkString;
    
    BOOL selectStatus;
    int goodsNum;
    int selectTag;
    NSMutableArray *selectArray;
}

@property (weak, nonatomic) IBOutlet UITableView *candantableview;
@property (weak, nonatomic) IBOutlet UITableView *caipinleitableview;
@property (weak, nonatomic) IBOutlet UIButton *reordertn;
@property (weak, nonatomic) IBOutlet UIButton *finishorderbtn;

@property (weak, nonatomic) IBOutlet UIView *pinleirightsepe;
@property (weak, nonatomic) IBOutlet UILabel *sumofcount;
@property (weak, nonatomic) IBOutlet UILabel *sumofPrice;

@end

@implementation caidanViewController

- (void)viewWillAppear:(BOOL)animated{
   
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addtoptip];
//    [self initfooterview];
//    [self initheaderview];
    
    selectNum = 0;
    goodsNum =1;
    dataArray = [NSMutableArray array];
    typeArray = [NSMutableArray array];
    selectArray = [NSMutableArray array];
    caidanArray = [NSMutableArray array];
    [self sendRequest:@"http://www.waomi.com/mapi/androidPhone/goodsList"];
//    [self getlist];
    _reordertn.layer.cornerRadius = 2;
    _finishorderbtn.layer.cornerRadius = 2;
    
    UIView *sepe = [[UIView alloc]initWithFrame:CGRectMake(0.5, 0,0.5,  _pinleirightsepe.frame.size.height)];
    [sepe setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [_pinleirightsepe addSubview:sepe];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [_caipinleitableview selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    if ([_caipinleitableview.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        
        [_caipinleitableview.delegate tableView:self.caipinleitableview didSelectRowAtIndexPath:indexPath];
        
    }
}

- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)sendRequest:(NSString *)url
{
    //菜单
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *option = [NSMutableDictionary dictionaryWithObjectsAndKeys:_sh_id,@"sh_id", nil];

    [dic_all setObject:option forKey:@"option"];
    AFHTTPRequestOperationManager *manager2 = [[AFHTTPRequestOperationManager alloc]init];
    manager2.responseSerializer = [AFJSONResponseSerializer serializer];
    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager2 POST:url parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            dataArray = [LBCaidanModel arrayOfModelsFromDictionaries:responseObject[@"data"][@"option"] error:nil];
            
            orderState = responseObject[@"data"][@"ordering"];
            checkString = responseObject[@"data"][@"checkShipTime"];
//            if ([checkString isEqualToString:@"1"]) {
//                _finishorderbtn.enabled = YES;
//            }else
//            {
//                _finishorderbtn.enabled = NO;
//            }
            
            [_caipinleitableview reloadData];
            [_candantableview reloadData];
        }
        
        
//        for (NSDictionary *dic in responseObject[@"data"][@"option"]) {
//            candanModel *model = [candanModel messageWithDict:dic];
//            [_dataSource addObject:model];
//        }
////        NSLog(@"%@",_dataSource);
//        [_candantableview reloadData];
//        _morePage = [responseObject objectForKey:@"nexturl"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@",error);
    }];
}



#pragma mark - 添加黄色顶部条
- (void)addtoptip{
    toptipview *caidantip = [[toptipview alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 30)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width-0-30, 30)];
    [label setText: @"1、10元起送，请提前45分钟下单，点菜送饮料加多宝"];
    [label setTextColor:[UIColor colorWithRed:235/255.0 green:97/255.0 blue:0/255.0 alpha:1]];
    label.font = [UIFont systemFontOfSize:11.0f];
    UIImageView *toptipview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-10-12, 12, 8, 8)];
    [toptipview setImage:[UIImage imageNamed:@"wm_notice_close.png"]];
    
    UIView *sepe = [[UIView alloc]initWithFrame:CGRectMake(0, 29.5, self.view.bounds.size.width, 0.5)];
    [sepe setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    
    [caidantip addSubview:label];
    [caidantip addSubview:toptipview];
    [caidantip addSubview:sepe];
    caidantip.backgroundColor = [UIColor colorWithRed:253/255.0 green:249/255.0 blue:216/255.0 alpha:1];
    [self.view addSubview:caidantip];
}

#pragma mark 点好了
- (IBAction)dianHaoBtn:(UIButton *)sender
{

    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if(_index==0)
    {
        tijiaoddViewController *dianWaiMaiVC = [story instantiateViewControllerWithIdentifier:@"dianWaiMaiSID"];
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        NSString *user_uid = [userInfo objectForKey:@"user_uid"];
        dianWaiMaiVC.userId = user_uid;
        
        [self.navigationController pushViewController:dianWaiMaiVC animated:YES];
    }
    else if (_index==1)
    {
        yudingViewController *yudingVC = [story instantiateViewControllerWithIdentifier:@"yuDingsId"];
        [self.navigationController pushViewController:yudingVC animated:YES];
    }
    else
    {
        diancaiViewController *yudingVC = [story instantiateViewControllerWithIdentifier:@"dianCaiSID"];
        [self.navigationController pushViewController:yudingVC animated:YES];
    }
}

#pragma mark Cell里面Btn 方法
- (void)numViewShow:(UIButton *)button
{
    selectStatus = YES;
    selectTag = button.tag;
    [selectArray addObject:[NSNumber numberWithInt:selectTag]];
    [_candantableview reloadData];
}
- (void)goodsAddFunction:(UIButton *)button
{
    for (int i=0; i<selectArray.count; i++) {
        if (button.tag == [selectArray[i] intValue]) {
            if (goodsNum<99) {
                goodsNum++;
            }
            
            [_candantableview reloadData];
        }
    }
    
    
    
}

- (void)setSelectedDic:(NSDictionary *)dic andStatus:(int)state{
    if (state == 1) {
        [caidanArray addObject:dic];
    }else{
        [caidanArray removeObject:dic];
    }
}

- (void)goodsReduFunction:(UIButton *)button
{
    
    for (int i=0; i<selectArray.count; i++) {
        if (button.tag == [selectArray[i] intValue]) {
                if (goodsNum>1) {
                    goodsNum--;
                }
                [_candantableview reloadData];
            
        }
    }
    //    int price = 0;
    //    price+= num*[_goods_price.text intValue];
    
    
}
#pragma mark - tableview代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (tableView == _candantableview) {
            
//        candanModel *model = _dataSource[indexPath.row];
    
        caidanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"caidancell"];
            cell.delegate = self;
        cell.picborderwidth.layer.borderWidth = 0.5;
        cell.picborderwidth.layer.borderColor = [[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]CGColor];
        
        UIView *sepe = [[UIView alloc]initWithFrame:CGRectMake(0, 0.5, cell.sepe.frame.size.width, 0.5)];
        [sepe setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
        [cell.sepe addSubview:sepe];
        
//        [self listCell:cell];
            [cell setData:[dataArray[selectNum] goods_list][indexPath.row] ];
//            [cell.orderBtn addTarget:self action:@selector(numViewShow:) forControlEvents:UIControlEventTouchUpInside];
//            cell.orderBtn.tag = indexPath.row;
//            cell.orderNum.text = [NSString stringWithFormat:@"%d",goodsNum];
//            
//            if (selectStatus) {
//                if (indexPath.row == selectTag) {
//                    cell.numView.hidden = NO;
//                    cell.orderView.hidden = YES;
//                    [cell.orderAdd addTarget:self action:@selector(goodsAddFunction:) forControlEvents:UIControlEventTouchUpInside];
//                    cell.orderAdd.tag = indexPath.row;
//                    [cell.orderReduce addTarget:self action:@selector(goodsReduFunction:) forControlEvents:UIControlEventTouchUpInside];
//                    cell.orderReduce.tag = indexPath.row;
//                }
//                
//                
//            }
//            if (orderState) {
//                cell.orderBtn.hidden = NO;
//            }else
//            {
//                cell.orderBtn.hidden = YES;
//            }
        return cell;
    }
    else {
//       caipinleiModel *model = _listDataSource[indexPath.row];
        caipinleiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"caipinleicell"];
        cell.rightred.layer.cornerRadius = 5;
      
        UIView *sepe = [[UIView alloc]initWithFrame:CGRectMake(0, 0.5, cell.bottomsep.frame.size.width, 0.5)];
        [sepe setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
        [cell.bottomsep addSubview:sepe];
        
        UIView *sepe1 = [[UIView alloc]initWithFrame:CGRectMake(0.5, 0, 0.5, cell.rightsep.frame.size.height)];
        [sepe1 setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
        [cell.rightsep addSubview:sepe1];
        
        if (cell.selected == YES) {
            [cell.leftarrowimage setHidden:NO];
        }
        
        [cell setTypeData:dataArray[indexPath.row]];
//        if (indexPath.row == 0) {
//            [cell.contentView setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]];
//            [cell.leftarrowimage setHidden:NO];
//        }
        
        if (!(indexPath.row == 1)) {
            [cell.rightred setHidden:YES];
        }
            return cell;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _candantableview) {
        
       if(dataArray.count !=0)
       {
           return [self listNum:selectNum];
       }else
       {
           return 0;
       }
        
    }
    else{
        return dataArray.count;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _caipinleitableview){
        NSIndexPath *path = [_caipinleitableview indexPathForSelectedRow];
        caipinleiCell *cell = (caipinleiCell *)[_caipinleitableview cellForRowAtIndexPath:path];
        cell.leftarrowimage.hidden = NO;
        [cell.contentView setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]];
        _sortId = cell.sort_id;
        selectNum = indexPath.row;
//        [_dataSource removeAllObjects];
        NSLog(@"%@",_sortId);
//        [self sendRequest:@"http://www.waomi.com/mapi/androidPhone/goodsList"];
        [_caipinleitableview reloadData];
        [_candantableview reloadData];
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _caipinleitableview){
        caipinleiCell *cell = (caipinleiCell *)[_caipinleitableview cellForRowAtIndexPath:indexPath];
        cell.leftarrowimage.hidden = YES;
        cell.contentView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    }
}

- (int) listNum:(int)selectRow
{
    int num =0;
    num = [dataArray[selectRow] goods_list].count;
    return num;
    
}
- (void)listCell:(caidanCell *)cell
{
    for(int i=0;i<[self listNum:selectNum];i++)
    {
        [cell setData:[dataArray[selectNum] goods_list][i] ];
    }
}
@end
