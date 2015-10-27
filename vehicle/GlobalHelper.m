//
//  GlobalHelper.m
//  vehicle
//
//  Created by Mac on 15/9/28.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import "GlobalHelper.h"
#import <netdb.h>

@implementation GlobalHelper
+(GlobalHelper *)sharedManager
{
    static GlobalHelper *sharedAllRequest = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        sharedAllRequest = [[self alloc] init];
    });
    return sharedAllRequest;
}

-(NSArray *)returnDateStrbyStateNum:(NSInteger )num
{
    NSMutableArray * timeRangeArr = [[NSMutableArray alloc]init];
    switch (num) {
        case 0:
        {
            //获取当前时间
            NSDate * nowDate = [NSDate date];
            //获取当前时间的前一天
            NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString * startTimeStr = [dateFormatter stringFromDate:nowDate];
            NSString * endTimeStr = [dateFormatter stringFromDate:yesterday];
            [timeRangeArr addObject:startTimeStr];
            [timeRangeArr addObject:endTimeStr];
            return timeRangeArr;
            
        }
            break;
        case 1:
        {
            //获取当前时间
            NSDate * nowDate = [NSDate date];
            //获取当前时间的前3天
            NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60*3)];
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString * startTimeStr = [dateFormatter stringFromDate:nowDate];
            NSString * endTimeStr = [dateFormatter stringFromDate:yesterday];
            [timeRangeArr addObject:startTimeStr];
            [timeRangeArr addObject:endTimeStr];
            
            return timeRangeArr;
        }
            break;
        case 2:
        {
            //获取当前时间
            NSDate * nowDate = [NSDate date];
            //获取近7天时间
            NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60*7)];
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString * startTimeStr = [dateFormatter stringFromDate:nowDate];
            NSString * endTimeStr = [dateFormatter stringFromDate:yesterday];
            [timeRangeArr addObject:startTimeStr];
            [timeRangeArr addObject:endTimeStr];
            return timeRangeArr;
        }
            break;
        case 3:
        {
            //获取当前时间
            NSDate * nowDate = [NSDate date];
            //获取近30天时间
            NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60*30)];
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString * startTimeStr = [dateFormatter stringFromDate:nowDate];
            NSString * endTimeStr = [dateFormatter stringFromDate:yesterday];
            [timeRangeArr addObject:startTimeStr];
            [timeRangeArr addObject:endTimeStr];
            return timeRangeArr;
        }
            break;
        default:
            return timeRangeArr;
            break;
    }
}
//判断网络状态
+(BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

//计算两坐标点之间距离
-(double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2
{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
    //     return  distance*1000;
    
    //返回 m
    return   distance;
    
}

-(NSString *)returnTimeStr:(NSString*)timeStr
{
    NSArray * arr = [timeStr componentsSeparatedByString:@" "];
    NSString * returnTimeStr = arr[0];
    return returnTimeStr;
}
@end
