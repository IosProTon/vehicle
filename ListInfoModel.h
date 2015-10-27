//
//  ListInfoModel.h
//  vehicle
//
//  Created by Mac on 15/10/19.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListInfoModel : NSObject
@property(copy,nonatomic)NSString *detailTitle;
@property(copy,nonatomic)NSString * headImage;
@property(copy,nonatomic)NSString * title;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
