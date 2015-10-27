//
//  AllRequest.h
//  衣必优
//
//  Created by wangscott on 15/8/10.
//
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


//请求超时
#define TIMEOUT 15

typedef void(^SuccessBlock)(id responseBody);
typedef void(^FailureBlock)(NSString *error);


@interface AllRequest : NSObject

+(AllRequest *)sharedManager;
-(AFHTTPRequestOperationManager *)baseHtppRequest;

#pragma mark - 获取广告页图片
-(void)getAdvLoadingImage:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
#pragma mark - 服务器请求
-(void)serverRequest:(NSDictionary *)parameter url:(NSString *)url byWay:(NSString *)way successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
@end
