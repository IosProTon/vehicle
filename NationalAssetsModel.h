//
//  NationalAssetsModel.h
//  vehicle
//
//  Created by Mac on 15/10/25.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NationalAssetsModel : NSObject
@property(nonatomic,assign)int areacount;
@property(nonatomic,assign)int carcount;
@property(nonatomic,assign)int guncount;
@property(nonatomic,assign)int percount;
@property(nonatomic,assign)int sitecount;
@property(nonatomic,assign)int totalcount;
@property(nonatomic,retain)NSArray * sumlist;



@end
