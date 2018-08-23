//
//  BaseRequest.m
//  BaseFramework
//
//  Created by hztuen on 17/3/2.
//  Copyright © 2017年 Cesar. All rights reserved.
//

#import "ADBaseRequest.h"

@implementation ADBaseRequest

// POST 请求数据基类
+ (void)postRequest:(NSMutableDictionary *)dict AndUrl:(NSString *)url success:(void(^)(id responseDict))success fail:(void(^)(NSError * error))fail
{
    NSLog(@"Post请求 url: %@, parameters: %@", url, dict);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/plain",@"application/json",@"text/html"]];
    
    [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         success(responseObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         fail(error);
     }];
}

// GET 请求数据基类
+ (void)getRequest:(NSMutableDictionary *)dict AndUrl:(NSString *)url success:(void(^)(id responseDict))success fail:(void(^)(NSError * error))fail
{
    NSLog(@"Get请求 url: %@, parameters: %@", url, dict);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/plain",@"application/json",@"text/html"]];
    
    [manager GET:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(error);
    }];
}

// 上传图片基类
+ (void)uploadImage:(UIImage *)img AndUrl:(NSString *)url success:(void(^)(id responseDict))success fail:(void(^)(NSError * error))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData: UIImageJPEGRepresentation(img ,0.1) name:@"imgFile" fileName:@"formname.jpg" mimeType:@"jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(error);
    }];
}



@end
