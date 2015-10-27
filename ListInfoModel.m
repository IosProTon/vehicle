//
//  ListInfoModel.m
//  vehicle
//
//  Created by Mac on 15/10/19.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import "ListInfoModel.h"

@implementation ListInfoModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
