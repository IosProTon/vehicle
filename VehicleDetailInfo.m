//
//  VehicleDetailInfo.m
//  vehicle
//
//  Created by Mac on 15/9/30.
//  Copyright (c) 2015年 Mac OS. All rights reserved.
//

#import "VehicleDetailInfo.h"

@implementation VehicleDetailInfo
//字典遍历给类属性
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


@end
