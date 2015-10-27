//
//  NetWorkAssetsInfoModel.h
//  vehicle
//
//  Created by Mac on 15/10/21.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkAssetsInfoModel : NSObject

@property(copy,nonatomic)NSString *detailTitle;
@property(copy,nonatomic)NSString * headImage;
@property(copy,nonatomic)NSString * title;
@property(copy,nonatomic)NSString * leftTitle;


-(instancetype)initWithDict:(NSDictionary *)dict;

@end
