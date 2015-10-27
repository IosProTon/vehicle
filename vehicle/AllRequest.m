//
//  AllRequest.m
//  衣必优
//
//  Created by wangscott on 15/8/10.
//
//

#import "AllRequest.h"

@implementation AllRequest


+(AllRequest *)sharedManager
{
    static AllRequest *sharedAllRequest = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        sharedAllRequest = [[self alloc] init];
    });
    return sharedAllRequest;
}

-(AFHTTPRequestOperationManager *)baseHtppRequest
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    //header 设置
    //    [manager.requestSerializer setValue:K_PASS_IP forHTTPHeaderField:@"Host"];
    //    [manager.requestSerializer setValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
    //    [manager.requestSerializer setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    //    [manager.requestSerializer setValue:@"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3" forHTTPHeaderField:@"Accept-Language"];
    //    [manager.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    //    [manager.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    //    [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0" forHTTPHeaderField:@"User-Agent"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json", @"text/html",@"text/xml", @"application/json", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}

#pragma mark - 获取广告页图片
-(void)getAdvLoadingImage:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    
    //两种编码方式
    //NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}
#pragma mark - 服务器请求
-(void)serverRequest:(NSDictionary *)parameter url:(NSString *)url byWay:(NSString *)way successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    
    //两种编码方式
//    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    /**
     *  GET请求
     */
    if ([way isEqualToString:@"GET"])
    {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject){
            NSData *data = responseObject;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            successBlock(dic);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            failureBlock(errorStr);
        }];
    }
    /**
     *  POST请求
     */
    else if([way isEqualToString:@"POST"])
    {
        [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject){
            successBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            failureBlock(errorStr);
        }];
    }

}
@end
