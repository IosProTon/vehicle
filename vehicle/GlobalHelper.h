//
//  GlobalHelper.h
//  vehicle
//
//  Created by Mac on 15/9/28.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalHelper : NSObject

+(GlobalHelper *)sharedManager;

-(NSArray *)returnDateStrbyStateNum:(NSInteger )num;

//判断网络状态
+(BOOL) connectedToNetwork;

//计算辆坐标之间距离
-(double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2;

//根据详细时间返回日期
-(NSString *)returnTimeStr:(NSString*)timeStr;
@end
