//
//  HYGRequstClass.m
//  haoeryouGo
//
//  Created by zyfs on 14-9-22.
//  Copyright (c) 2014年 zyfs. All rights reserved.
//

#import "AFNRequestClass.h"
#import "AppDelegate.h"

@implementation AFNRequestClass


+(void)sendPOSTRequestWithURL2:(NSString *)reqURL andParams:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:reqURL
       parameters:params
          success:success
          failure:failure
     
          ];
}



+(void)sendPOSTRequestWithURL:(NSString *)reqURL andParams:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:reqURL
       parameters:params
          success:success
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}

+(void)sendGETRequestWithURL:(NSString *)reqURL andParams:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:reqURL
       parameters:params
          success:success
          failure:failure
     
     ];
}

//
//+(void)sendGETRequestWithURL:(NSString *)reqURL andParams:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    
//    [manager GET:reqURL
//       parameters:params
//          success:success
//          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              NSLog(@"Error: %@", error);
//          }];
//}

+(void)sendHttpGETRequestWithURL:(NSString *)reqURL andParams:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager GET:reqURL
      parameters:params
         success:success
         failure:failure];
}

+(void)uploadImage:(UIImage *)img toURL:(NSString *)url withName:(NSString *)uploadName params:(NSDictionary *)dic success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    __block NSError *error = nil;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:@"POST" URLString:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (img) {
            // 在网络开发中，上传文件时，文件不允许被覆盖，不允许文件重名
            // 要解决此问题，可以在上传时使用当前的系统时间作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            [formData appendPartWithFileData:UIImageJPEGRepresentation(img,0.5)
                                        name:uploadName
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
        
        
    } error:&error];
    if (error) {
        NSLog(@"%@",[error description]);
        return;
    }
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
    }];
    
    [operation setCompletionBlockWithSuccess:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",[error description]);
    }];
    
    
    [operation start];
}

+(void)uploadImage2:(UIImage *)img toURL:(NSString *)url withName:(NSString *)uploadName params:(NSDictionary *)dic success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    __block NSError *error = nil;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:@"POST" URLString:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (img) {
            // 在网络开发中，上传文件时，文件不允许被覆盖，不允许文件重名
            // 要解决此问题，可以在上传时使用当前的系统时间作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            [formData appendPartWithFileData:UIImageJPEGRepresentation(img,0.5)
                                        name:uploadName
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
        
        
    } error:&error];
    if (error) {
        NSLog(@"%@",[error description]);
        return;
    }
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
    }];
    
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    
    [operation start];
}

+(void)uploadImages:(NSMutableArray *)imgArr toURL:(NSString *)url withName:(NSString *)uploadName params:(NSDictionary *)dic success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success
{
    __block NSError *error = nil;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:@"POST" URLString:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (imgArr.count > 0) {
            for (int i = 0; i < imgArr.count; i++) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                
                [formData appendPartWithFileData:UIImageJPEGRepresentation(imgArr[i],0.5)
                                            name:uploadName
                                        fileName:fileName
                                        mimeType:@"image/jpeg"];
            }
            
        }
        
        
    } error:&error];
    if (error) {
        NSLog(@"%@",[error description]);
        return;
    }
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
    }];
    
    [operation setCompletionBlockWithSuccess:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",[error description]);
    }];
    
    
    [operation start];
}

//查询用户信息
+(void)sendRequest_userInfo
{
//    AppDelegate *_app = APP;
//    NSString *url = [BASE_URL1 stringByAppendingString:REGISTER];
//    NSDictionary *dic = @{@"action":@"info",@"userId":_app.usermodel.userId};
//    [AFNRequestClass sendPOSTRequestWithURL2:url andParams:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
//        NSDictionary *dic = responseObject[@"data"];
//        UserModel *model = [[UserModel alloc]init];
//        model.createTime = dic[@"createTime"];
//        model.userId = dic[@"id"];
//        model.loginName = dic[@"loginName"];
//        model.loginTime = dic[@"loginTime"];
//        model.parentId = dic[@"parentId"];
//        model.password = dic[@"password"];
//        model.salt = dic[@"salt"];
//        model.state = dic[@"state"];
//        model.status = dic[@"status"];
//        model.type = dic[@"type"];
//        
//        model.balance = dic[@"balance"];
//        model.image = dic[@"image"];
//        model.integral = dic[@"integral"];
//        model.nickName = dic[@"nickName"];
//        model.sex = dic[@"sex"];
//        model.shopContent = dic[@"shopContent"];
//        model.shopName = dic[@"shopName"];
//        model.shopType = dic[@"shopType"];
//        model.telephone = dic[@"telephone"];
//        model.province = dic[@"province"];
//        model.city = dic[@"city"];
//        model.area = dic[@"area"];
//        model.address = dic[@"address"];
//        model.parentName = dic[@"parentName"];
//        
//        model.shopImage = dic[@"shopImage"];
//        model.mobilephone = dic[@"mobilephone"];
//        model.headImage = dic[@"headImage"];
//        model.licenseNumber = dic[@"licenseNumber"];
//        model.cardNumber = dic[@"cardNumber"];
//        model.mobilephone = dic[@"mobilephone"];
//        model.shopTypeId = dic[@"shopTypeId"];
//        
//        
//        _app.usermodel = model;
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
}



@end
