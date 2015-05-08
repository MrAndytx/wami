
//
//  leftViewController.m
//  哇米
//
//  Created by wenga on 15/1/12.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "leftViewController.h"
#import "AppDelegate.h"
#import "myorderViewController.h"
#import "mapViewController.h"
#import "mycollectViewController.h"
#import "myticketViewController.h"
#import "myrateViewController.h"
#import "TabBar.h"
#import "StyledPageControl.h"
#import "Reachability.h"
#import "toptipview.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "EScrollerView.h"
#import "adWebViewController.h"

#define SCROLLVIEWWIDTH [UIScreen mainScreen].bounds.size.width
#define SCROLLVIEWHEIGHT 126
@interface leftViewController ()<UIScrollViewDelegate,EScrollerViewDelegate>
{
    EScrollerView *scrollView;
    toptipview *_hometip;
    NSMutableArray *slideImages;
    NSMutableArray *openUrlArray;
}

@property (nonatomic)NetworkStatus netstatus;

@property (weak, nonatomic) IBOutlet UIView *firstview;
@property (weak, nonatomic) IBOutlet UIView *homepage;

@property (weak, nonatomic) IBOutlet UIView *btn1view;
@property (weak, nonatomic) IBOutlet UIView *btn2view;

@end

@implementation leftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setscrollview];
    [self addGestureRecognizer];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self addborderwidth];
    slideImages = [NSMutableArray array];
    openUrlArray = [NSMutableArray array];

    }

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    [self reachabilityChanged];
    //判断是否第一次登陆
    //    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    BOOL is_firstLaunch = [userdefault boolForKey:@"firstLaunch"];
    if (!is_firstLaunch) {
        
        [userdefault setBool:YES forKey:@"firstLaunch"];
        [userdefault synchronize];
    }
    
}

//添加边框
- (void)addborderwidth{
    CGSize size = self.view.frame.size;
    UIView *firsth = [[UIView alloc]initWithFrame:CGRectMake(0, 186, size.width, 0.5)];
    [firsth setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [self.view addSubview:firsth];
    
    UIView *midh = [[UIView alloc]initWithFrame:CGRectMake(0, (size.height-186)/4+186, size.width, 0.5)];
    [midh setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [self.view addSubview:midh];
    
    UIView *firstv = [[UIView alloc]initWithFrame:CGRectMake((size.width-0.5)/2, 186, 0.5, (size.height-186)*0.75)];
    [firstv setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [self.view addSubview:firstv];

    //第二个view
    UIView *thirdh = [[UIView alloc]initWithFrame:CGRectMake(0, (size.height-186)/2+186, size.width, 0.5)];
    [thirdh setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [self.view addSubview:thirdh];
    
//    UIView *midh2 = [[UIView alloc]initWithFrame:CGRectMake(0, (_btn2view.frame.size.height-0.5)/2, _btn2view.frame.size.width, 0.5)];
//    [midh setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
//    [_btn2view addSubview:midh2];
    
    UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(0, (size.height-186)/4*3+186, size.width, 9)];
    [seperator setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [self.view addSubview:seperator];
    
    UIView *secondv = [[UIView alloc]initWithFrame:CGRectMake((size.width-0.5)/2, (size.height-186)/4*3+186+9, 0.5, (size.height-186)/4)];
    [secondv setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]];
    [self.view addSubview:secondv];
    
}

 //添加滑动手势
- (void)addGestureRecognizer{
    //添加右滑动手势
    UISwipeGestureRecognizer *rightswith = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeframe)];
    rightswith.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightswith];
    
    //添加左滑动手势
    UISwipeGestureRecognizer *leftswith = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backframe)];
    leftswith.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftswith];

    
}
//判断是否有网络连接
-(void)reachabilityChanged{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([r currentReachabilityStatus] == 0) {
        [self addtoptip];
    }
    else{
        [_hometip removeFromSuperview];
    }
}

#pragma mark - 添加黄色顶部条
- (void)addtoptip{
    _hometip = [[toptipview alloc]initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, 30)];
    //添加黄色警告
    UIImageView *warningview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 13, 13)];
    [warningview setImage:[UIImage imageNamed:@"wm_warning"]];
    [_hometip addSubview:warningview];

    
    //添加文字
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, self.view.bounds.size.width*0.7, 30)];
    [label setText: @"当前网络不可用，请检查网络设置"];
    label.font = [UIFont systemFontOfSize:12.0f];
    [label setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]];
    [_hometip addSubview:label];
    
    //添加图片
     UIImageView *toptipview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-10-15, 9, 8, 12)];
    [toptipview setImage:[UIImage imageNamed:@"right arrow"]];
    [_hometip addSubview:toptipview];
    
    _hometip.backgroundColor = [UIColor colorWithRed:253/255.0 green:249/255.0 blue:216/255.0 alpha:1];
    [_firstview addSubview:_hometip];
}

- (IBAction)wamibtn:(id)sender {
    [self changeframe];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


//滑动
- (void)changeframe{
    [UIView animateWithDuration:0.5 animations:^{
       [_homepage setFrame:CGRectMake(self.view.bounds.size.width*0.6, self.view.bounds.size.height*0.05, self.view.bounds.size.width*0.6, self.view.bounds.size.height*0.7)];
        _homepage.transform = CGAffineTransformMakeScale(0.8, 0.8);
    }];
    
    
}

- (void)backframe{
    [UIView animateWithDuration:0.5 animations:^{
        _homepage.transform = CGAffineTransformMakeScale(1, 1);
        [_homepage setFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height-20)];
    }];

    }

- (IBAction)wodewami:(id)sender {
    self.tabBarController.selectedIndex = 3;
    UITabBarController *tabVC = self.tabBarController;
//    tabVC.selectedIndex = 1;
    
    NSArray *array = [tabVC.tabBar subviews];
    for (UIView *v in array)
    {
        if ([v isKindOfClass:[TabBar class]])
        {
            //            v.hidden = YES;
            NSArray *ary = [v subviews];
//            MyLog(@"%@",(TabBar *)v);
            [(TabBar *)v didClicked:(UIButton *)ary[3]];
        }
    }

}

- (IBAction)dianwaimai:(id)sender {
    self.tabBarController.selectedIndex = 1;
    UITabBarController *tabVC = self.tabBarController;
    //    tabVC.selectedIndex = 1;
    
    NSArray *array = [tabVC.tabBar subviews];
    for (UIView *v in array)
    {
        if ([v isKindOfClass:[TabBar class]])
        {
            //            v.hidden = YES;
            NSArray *ary = [v subviews];
            //            MyLog(@"%@",(TabBar *)v);
            [(TabBar *)v didClicked:(UIButton *)ary[1]];
        }
    }
}
- (IBAction)fujinmeishi:(id)sender {
    self.tabBarController.selectedIndex = 2;
    UITabBarController *tabVC = self.tabBarController;
    //    tabVC.selectedIndex = 1;
    
    NSArray *array = [tabVC.tabBar subviews];
    for (UIView *v in array)
    {
        if ([v isKindOfClass:[TabBar class]])
        {
            //            v.hidden = YES;
            NSArray *ary = [v subviews];
            //            MyLog(@"%@",(TabBar *)v);
            [(TabBar *)v didClicked:(UIButton *)ary[2]];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)waimaidingdan:(id)sender {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.myviewstr = @"外卖订单";
//    app.myordershowway = 1;
    UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    myorderViewController *myorderview = [sto instantiateViewControllerWithIdentifier:@"myorderview"];
//    [self presentViewController:myorderview animated:YES completion:nil];
    [self.navigationController pushViewController:myorderview animated:YES];
    [self backframe];
}
- (IBAction)yudingdingdan:(id)sender {
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.myviewstr = @"预订订单";
//    app.myordershowway = 1;
    UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    myorderViewController *myorderview = [sto instantiateViewControllerWithIdentifier:@"myorderview"];
//    [self presentViewController:myorderview animated:YES completion:nil];
    [self.navigationController pushViewController:myorderview animated:YES];
    [self backframe];

}
- (IBAction)diancaidingdan:(id)sender {
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.myviewstr = @"点菜订单";
//    app.myordershowway = 1;
    UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    myorderViewController *myorderview = [sto instantiateViewControllerWithIdentifier:@"myorderview"];
//    [self presentViewController:myorderview animated:YES completion:nil];
    [self.navigationController pushViewController:myorderview animated:YES];
    [self backframe];
    
}
- (IBAction)wodedizhi:(id)sender {
      UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    mapViewController *mapview = [sto instantiateViewControllerWithIdentifier:@"map"];
    [self.navigationController pushViewController:mapview animated:YES];
    [self backframe];
}

- (IBAction)wodeshoucang:(id)sender {
      UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    mycollectViewController *mycollectview = [sto instantiateViewControllerWithIdentifier:@"mycollectview"];
    [self.navigationController pushViewController:mycollectview animated:YES];
    [self backframe];
}
- (IBAction)wodequanbao:(id)sender {
    UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    myticketViewController *myticketview = [sto instantiateViewControllerWithIdentifier:@"myticketview"];
    [self.navigationController pushViewController:myticketview animated:YES];
    [self backframe];
}
- (IBAction)wodepingjia:(id)sender {
    UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    myrateViewController *myrateview = [sto instantiateViewControllerWithIdentifier:@"myrateview"];
    [self.navigationController pushViewController:myrateview animated:YES];
    [self backframe];
}

#pragma mark -设置首页的scrollview
- (void)setscrollview{
    //获取当前时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    NSMutableDictionary *dic_all = [NSMutableDictionary dictionaryWithDictionary:_commonDic];
    NSMutableDictionary *option = [[NSMutableDictionary alloc]init];
    [option setObject:timeString forKey:@"tmp"];
    [dic_all setObject:option forKey:@"option"];
    //    NSLog(@"%@",dic_all);
    AFHTTPRequestOperationManager *manager2 = [[AFHTTPRequestOperationManager alloc]init];
    manager2.responseSerializer = [AFJSONResponseSerializer serializer];
    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *urlString = [NSString stringWithFormat:@"http://www.waomi.com/mapi/androidPhone/mainfocusad"];
    [manager2 POST:urlString parameters:dic_all success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *adArray = responseObject[@"data"][@"option"][@"images_list"];
        for (int i=0; i<adArray.count; i++) {
            [slideImages addObject:adArray[i][@"fileurl"]];
            [openUrlArray addObject:adArray[i][@"openurl"]];
        }
        scrollView = [[EScrollerView alloc]initWithFrameRect:CGRectMake(0, 40, SCROLLVIEWWIDTH, SCROLLVIEWHEIGHT) ImageArray:slideImages];
        scrollView.delegate = self;
        [_firstview addSubview:scrollView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error :%@",error);
    }];

    
    
    
}

#pragma EscrollView 代理
- (void)EScrollerViewDidClicked:(NSUInteger)index
{
    NSLog(@"index--%lu",(unsigned long)index);
    if([openUrlArray[index] length] >0)
    {
        adWebViewController *adWebViewVC = [[adWebViewController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:adWebViewVC];
        adWebViewVC.urlString = openUrlArray[index];
        [self presentViewController:adWebViewVC animated:YES completion:nil];
    }
    
  
}



@end
