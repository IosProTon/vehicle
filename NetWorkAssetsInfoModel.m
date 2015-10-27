//
//  NetWorkAssetsInfoModel.m
//  vehicle
//
//  Created by Mac on 15/10/21.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import "NetWorkAssetsInfoModel.h"

@implementation NetWorkAssetsInfoModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
