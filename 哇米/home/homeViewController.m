//
//  homeViewController.m
//  wami
//
//  Created by wenga on 14/12/30.
//  Copyright (c) 2014年 wenga. All rights reserved.
//

#import "homeViewController.h"
#import "zixunViewController.h"
#import "leftViewController.h"
#import "meishiquanViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworking.h"

//#import "CommonDefine.h"
@interface homeViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_homescr;
    UIPageControl *_page;
   
    
}


@end

@implementation homeViewController

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tarbarcolor.png"]]];
     
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation1"] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
//    UIButton *button;
//    button.layer.cornerRadius = 5;
//    button.layer.borderWidth = 2;
//    button.layer.borderColor = [UIColor redColor].CGColor;
//    UIImageView *imgView;
//    imgView.layer.cornerRadius = 20;
//       [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"wm_top_arrow"]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addbutton];
    [self setscrollview];
    [self addPageControl];
//    UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    leftViewController *leftview = [sto instantiateViewControllerWithIdentifier:@"background"];
   

  }

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



#pragma mark -设置首页的scrollview
- (void)setscrollview{
    
    
    
    
    
    
    UIScrollView *homescr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20+44, self.view.bounds.size.width, (self.view.bounds.size.height-44)/4)];
    homescr.contentSize = CGSizeMake(homescr.bounds.size.width*3, homescr.bounds.size.height);
    homescr.pagingEnabled = YES;
    homescr.backgroundColor = [UIColor clearColor];
    [self.view addSubview:homescr];
    homescr.delegate = self;
    homescr.showsHorizontalScrollIndicator = NO;
    
    for (int j = 0; j<3; j++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        // 1.显示图片
        imageView.image = [UIImage imageNamed:@"ic_topbg"];
        // 2.设置frame
        imageView.frame = CGRectMake(j * homescr.frame.size.width, 0, homescr.frame.size.width, homescr.frame.size.height);
        [homescr addSubview:imageView];
    }

    _homescr = homescr;
     
    
}

#pragma mark 添加分页指示器
- (void)addPageControl
{
    CGSize size = self.view.bounds.size;
    UIPageControl *page = [[UIPageControl alloc] init];
    page.center = CGPointMake(size.width * 0.5, size.height*0.28+20);
    page.numberOfPages = 3;
    page.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tarbarcolor"]];
    page.pageIndicatorTintColor = [UIColor whiteColor];
    page.bounds = CGRectMake(0, 0, 150, 0);
    [self.view addSubview:page];
    _page = page;
}

#pragma mark -添加按钮

- (void)addbutton{
    //添加点外卖按钮
    UIButton *waimai = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.03, self.view.bounds.size.height*0.4, self.view.bounds.size.width*0.45, self.view.bounds.size.height*0.09)];
    [waimai setImage:[UIImage imageNamed:@"wm_waimai"] forState:UIControlStateNormal];
    [waimai addTarget:self action:@selector(jumptowaimai) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:waimai];
    
    //添加餐厅预订按钮
    UIButton *canting = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.52, self.view.bounds.size.height*0.4, self.view.bounds.size.width*0.45, self.view.bounds.size.height*0.09)];
    [canting setImage:[UIImage imageNamed:@"wm_yuding.png"] forState:UIControlStateNormal];
    [canting addTarget:self action:@selector(jumptocanting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:canting];
    
    
    //添加我要点菜按钮
    UIButton *diancai = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.03, self.view.bounds.size.height*0.55, self.view.bounds.size.width*0.45, self.view.bounds.size.height*0.09)];
    [diancai setImage:[UIImage imageNamed:@"wm_diancai.png"] forState:UIControlStateNormal];
    [self.view addSubview:diancai];
    
    //添加附近美食按钮
    UIButton *fujinmeishi = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.52, self.view.bounds.size.height*0.55, self.view.bounds.size.width*0.45, self.view.bounds.size.height*0.09)];
    [fujinmeishi setImage:[UIImage imageNamed:@"wm_near.png"] forState:UIControlStateNormal];
    [self.view addSubview:fujinmeishi];
    
    //添加附近每日推荐按钮
    UIButton *meirituijian = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.03, self.view.bounds.size.height*0.7, self.view.bounds.size.width*0.45, self.view.bounds.size.height*0.09)];
    [meirituijian setImage:[UIImage imageNamed:@"wm_zixun.png"] forState:UIControlStateNormal];
    [meirituijian addTarget:self action:@selector(pushzixun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:meirituijian];
    
      //添加期待
    UIButton *qidai = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.72, self.view.bounds.size.height*0.725, self.view.bounds.size.width*0.12, self.view.bounds.size.height*0.05)];
    [qidai setImage:[UIImage imageNamed:@"wm_wait.png"] forState:UIControlStateNormal];
    qidai.enabled = NO;
    [self.view addSubview:qidai];
    
    //添加米家乐园按钮
    UIButton *leyuan = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.07, self.view.bounds.size.height*0.87, self.view.bounds.size.width*0.35, self.view.bounds.size.height*0.07)];
    [leyuan setImage:[UIImage imageNamed:@"wm_mijialeyuan.png"] forState:UIControlStateNormal];
    [leyuan addTarget:self action:@selector(jumptomeishiquan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leyuan];
    
    //添加我的哇米按钮
    UIButton *wodewami = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.58, self.view.bounds.size.height*0.87, self.view.bounds.size.width*0.35 , self.view.bounds.size.height*0.07)];
    [wodewami setImage:[UIImage imageNamed:@"wm_mywami.png"] forState:UIControlStateNormal];
    [wodewami addTarget:self action:@selector(jumptomywami) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wodewami];
}

//跳到外卖
- (void)jumptowaimai{
    self.tabBarController.selectedIndex = 1;
}

//跳到餐厅
- (void)jumptocanting{
    self.tabBarController.selectedIndex = 2;
}

//跳到我的
- (void)jumptomywami{
    self.tabBarController.selectedIndex = 3;
}

//跳到美食圈
- (void)jumptomeishiquan{
    UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    meishiquanViewController *meishiquan = [sto instantiateViewControllerWithIdentifier:@"meishiquan"];
    meishiquan.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:meishiquan animated:YES];
}

//跳到资讯
- (void)pushzixun{
    UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    zixunViewController *zixun = [sto instantiateViewControllerWithIdentifier:@"meishizixun"];
//    zixun.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:zixun animated:YES];
}
#pragma mark -滚动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _page.currentPage = _homescr.contentOffset.x / _homescr.bounds.size.width;
}



@end
