//  JudgeNewVersion.h
//  Created by wjkang on 12-3-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface JudgeNewVersion : NSObject<UIAlertViewDelegate>
{
    NSString * trackViewUrl;
    BOOL mCanbeUpdate;   //是否是主动点击更新
}

+(JudgeNewVersion*)Instance;
+(void)free;

-(void)judgeShouldLoadNewVersion:(BOOL)canBeUpdate andNewVersion:(NSString *)newVer;

-(BOOL)judgeShouldMonitor;

+(UIView*)findSubViewIn:(UIView*)parent OfClass:(id)classObject index:(int)index;
+(void)setTextAlignment:(NSTextAlignment)alignment forAlertView:(UIAlertView*)view;
@end
