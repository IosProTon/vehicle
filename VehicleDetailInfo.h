//
//  VehicleDetailInfo.h
//  vehicle
//
//  Created by Mac on 15/9/30.
//  Copyright (c) 2015年 Mac OS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VehicleDetailInfo : NSObject

@property (nonatomic, copy) NSString *inTime;

@property (nonatomic, copy) NSString *driverName;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *signNo;

@property (nonatomic, copy) NSString *carNo;

@property (nonatomic, copy) NSString *signTime;


-(instancetype)initWithDict:(NSDictionary *)dict;

@end
