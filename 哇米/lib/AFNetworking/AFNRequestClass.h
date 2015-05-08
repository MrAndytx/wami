//
//  HYGRequstClass.h
//  haoeryouGo 请求类
//
//  Created by zyfs on 14-9-22.
//  Copyright (c) 2014年 zyfs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define MAIN_SB [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define SHOPPING_CART [UIStoryboard storyboardWithName:@"ShoppingCart" bundle:nil];
#define BASE_URL2 @"http://192.168.1.198:8080/ssg/"
#define BASE_URL1 @"http://182.92.235.79:8080/ssg/"

#define HOME_URL @"service/index" // 首页
#define GOODS_INFO @"service/goods" //商品
#define REGISTER @"service/user" // 注册
#define GOODS_TYPE @"service/goodstype" // 分类
#define NEAR_STORE @"service/shop" //附近的商铺
#define MAKE_ORDER @"service/order" //生产订单
#define COMMENT @"service/comment" //商品评论
#define CART @"http://182.92.235.79:8080/ssg/service/user?"
#define SERVICE @"service/service"
#define LOCATION_SERVICE @"service/service?action=type"
#define ADD_ADDRESS @"service/delivery" //怎加收货地址
#define ADDRESS_LIST @"http://182.92.235.79:8080/ssg/service/delivery?" //收货地址列表
//#define DEFAULT_ADDRESS @"http://182.92.235.79:8080/ssg/service/delivery?" //收货地址列表
#define GOODS_OFFLINE @"service/user?action=soldout&id=" //跳蚤市场商品下架
#define GOODS_GOLINE @"service/user?action=arrival&id=" //跳蚤市场商品上架
#define GOODS_DELETE @"service/user?action=removeFreedomGoods&id=" //跳蚤市场商品删除


#define PROVINCE @"http://182.92.235.79:8080/ssg/service/area?action=provinceList" //省份列表
#define CITY @"http://182.92.235.79:8080/ssg/service/area?action=cityList&name=" //城市列表
#define AREA @"http://182.92.235.79:8080/ssg/service/area?action=areaList&name=" //区列表

@interface AFNRequestClass : NSObject

+(void)sendPOSTRequestWithURL2:(NSString *)reqURL andParams:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+(void)sendGETRequestWithURL:(NSString *)reqURL andParams:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;


+(void)sendPOSTRequestWithURL:(NSString *)reqURL andParams:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success;

//+(void)sendGETRequestWithURL:(NSString *)reqURL andParams:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success;

+(void)sendHttpGETRequestWithURL:(NSString *)reqURL andParams:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/*
 *上传单张图片
 */
+(void)uploadImage:(UIImage *)img toURL:(NSString *)url withName:(NSString *)uploadName params:(NSDictionary *)dic success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success;

+(void)uploadImage2:(UIImage *)img toURL:(NSString *)url withName:(NSString *)uploadName params:(NSDictionary *)dic success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/*
 *上传多张图片
 */
+(void)uploadImages:(NSMutableArray *)imgArr toURL:(NSString *)url withName:(NSString *)uploadName params:(NSDictionary *)dic success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success;

+(void)sendRequest_userInfo;
-(void)getdata:(NSDictionary *)dic;

@end
