//
//  mapViewController.m
//  哇米
//
//  Created by wenga on 15/1/15.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "mapViewController.h"

@interface mapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>
{
    BMKMapView *_mapView;
    BOOL didAdjustMapCenter;
    BMKPoiSearch *_searcher;
    BMKPointAnnotation* _annotation;

}

@end

@implementation mapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    didAdjustMapCenter = NO;

    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    [self.view addSubview:_mapView];
    _mapView.showsUserLocation = YES;
    
    _locService = [[BMKLocationService alloc] init];
    [_locService startUserLocationService];
    
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _mapView.showsUserLocation = YES;
    _locService.delegate = self;

  
    [_mapView setShowsUserLocation:YES];
    
   }

- (void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
   

}

- (void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillAppear];
    _mapView.delegate = nil;
    [_locService stopUserLocationService];
}
- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)dealloc{
    _mapView = nil;
    _mapView.delegate = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - 地图代理
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    //获取经纬度
    NSLog(@"%f",userLocation.location.coordinate.latitude);
    NSLog(@"%f",userLocation.location.coordinate.longitude);
    
//    //经纬度转地址
//    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
//    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemark,NSError *error)
//     {
//         CLPlacemark *mark=[placemark objectAtIndex:0];
//         NSLog(@"%@",mark);
//         
//     } ];
    
    
    CLLocation *currentLoc = userLocation.location;
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:currentLoc completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks lastObject];
//        _positionLab.text = [NSString stringWithFormat:@"%@%@",placemark.locality,placemark.subLocality];
        NSLog(@"%@",placemark.name);}];
    [_locService stopUserLocationService]; //停止定位
    
//    if (userLocation.location != nil && !didAdjustMapCenter) {
//        didAdjustMapCenter = YES;
//        
//        __block NSString *keyword = nil;
    
//        CLGeocoder *Geocoder=[[CLGeocoder alloc]init];
//        CLGeocodeCompletionHandler handler = ^(NSArray *place, NSError *error) {
//            for (CLPlacemark *placemark in place) {
//                keyword = [placemark.addressDictionary objectForKey:@"SubLocality"];
//                break;
//            }
//            
//            //初始化检索对象
//            _searcher =[[BMKPoiSearch alloc]init];
//            _searcher.delegate = self;
//            
//            //发起检索
//            BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
//            option.pageIndex = 1;
//            option.pageCapacity = 4;
//            option.location = userLocation.location.coordinate;
//            option.keyword = keyword;
//            BOOL flag = [_searcher poiSearchNearBy:option];
//            
//            if(flag)
//            {
//                NSLog(@"周边检索发送成功");
//            }
//            else
//            {
//                NSLog(@"周边检索发送失败");
//            }
////        };
//        
//        CLLocation *loc = [[CLLocation alloc] initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
//        [Geocoder reverseGeocodeLocation:loc completionHandler:handler];
//        
        //调整地图中心
        BMKCoordinateRegion region;
        region.center.latitude = userLocation.location.coordinate.latitude;
        region.center.longitude = userLocation.location.coordinate.longitude;
        region.span.latitudeDelta = 0.01;
        region.span.longitudeDelta = 0.01;
        _mapView.region = region;
        
        //添加标注
        if (_annotation != nil) {
            [_mapView removeAnnotation:_annotation];
        }else{
            _annotation = [[BMKPointAnnotation alloc]init];
        }
        
        CLLocationCoordinate2D coor;
        coor.latitude = userLocation.location.coordinate.latitude;
        coor.longitude = userLocation.location.coordinate.longitude;
        _annotation.coordinate = coor;
        [_mapView addAnnotation:_annotation];
    }
    

@end

