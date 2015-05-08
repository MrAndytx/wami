//
//  CustViewController.m
//  哇米
//
//  Created by 李冬强 on 15-1-17.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "CustViewController.h"
#import "TabBar.h"
#import "Items.h"
@interface CustViewController ()<TabBarDelegate>

@end

@implementation CustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBar addSubview:[self makeTabBar]];
}

- (TabBar *)makeTabBar
{
    NSArray *imageArray=@[@"wm_foothome.png",
                          @"wm_footwaimai",
                          @"wm_footnear.png",
                          @"wm_footwami.png"];
    NSArray *selectImageArray=@[@"wm_foothome_current.png",
                                @"wm_footwaimai_current",
                                @"wm_footnear_current.png",
                                @"wm_footwami_current"];
    NSArray *titleArray=@[@"首页",
                          @"外卖",
                          @"附近",
                          @"我的哇米"];
    NSMutableArray *itemsArray=[[NSMutableArray alloc]init];
    for (int i=0; i<4; i++)
    {
        UIImage *image=[UIImage imageNamed:imageArray[i]];
        Items *item=[[Items alloc]initWithImage:image title:titleArray[i]];
        
        
        item.selectImage=[UIImage imageNamed:selectImageArray[i]];
        [itemsArray addObject:item];
    }
    TabBar *tabBar=[[TabBar alloc]initWithFrame:self.tabBar.bounds];
    tabBar.itemArray=itemsArray;
    tabBar.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    //RecommandationViewTitleBackground@2x
    tabBar.bgImage=[UIImage imageNamed:@"青色.png"];
    tabBar.selectIndex=0;
    tabBar.delegate = self;
    return tabBar;
}

- (void)tabBar:(TabBar *)tabBar didTag:(NSInteger)tag
{
    self.selectedIndex=tag;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
