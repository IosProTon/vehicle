//  JudgeNewVersion.m
//  V5Iphone
//  Created by wjkang on 12-3-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.

#import "JudgeNewVersion.h"
static JudgeNewVersion * this;

@implementation JudgeNewVersion

+(JudgeNewVersion*)Instance
{
    return [[JudgeNewVersion alloc] init];
}
+(void)free
{
    [this release];
}

-(void)dealloc
{
    [trackViewUrl release];
    [super dealloc];
}

-(void)judgeShouldLoadNewVersion:(BOOL)canBeUpdate andNewVersion:(NSString *)newVer
{
    mCanbeUpdate = canBeUpdate;
    if ([self judgeShouldMonitor] || canBeUpdate) {
        CGFloat systemValue = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (fabs(systemValue - 7.0) < 0.000001 || systemValue >= 7.0) {
//            trackViewUrl = @"itms-services://?action=download-manifest&url=https://m.sto.cn:8443/StoAppDown/vehicle.plist";
            trackViewUrl = @"http://fir.im/mvla";

            //@"itms-services://?action=download-manifest&url=https://8dolb2b.sinaapp.com/8dol-B2B.plist";
        }
        else
        {
            trackViewUrl = @"itms-services:///?action=download-manifest&url=https://192.168.123.122:8443/StoAppDown/StoInterApp.ipa";
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:trackViewUrl]];
            

            //@"itms-services://?action=download-manifest&url=http://8dolb2b.sinaapp.com/8dol-B2B.plist";
        }
//        NSString *url = @"http://8dol-static-img.oss-cn-hangzhou.aliyuncs.com/ios/b2b_version";
        
//        NSString *lastVersion = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:&error];
        
//        NSMutableString * noteString = [[NSMutableString alloc] init];
//        [noteString appendString:[NSString stringWithFormat:@"发现新版本(%@):\n",lastVersion]];
//        [noteString appendString:@"是否更新？"];
        
        NSString *version =[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        
        if (newVer && [newVer floatValue]-[version floatValue]>0 )
        {
            NSString * noteString = [NSString stringWithFormat:@"发现新版本 V%@",newVer];
            UIAlertView * view = [[UIAlertView alloc] initWithTitle:@"升级提示" message:noteString delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
            [JudgeNewVersion setTextAlignment:NSTextAlignmentLeft forAlertView:view];
            [view show];
      //      [noteString release];
     //       [view release];
        }
        else
        {
            [APPDELEGATE.window makeToast:@"已是最新版本"];

            [[self class] free];
        }
    }

    
//    mCanbeUpdate = canBeUpdate;
//    if ([self judgeShouldMonitor] || canBeUpdate) {
//        NSString * url = @"http://itunes.apple.com/lookup?id=951542214";
//        AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
//        manger.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
//        
//        NSDictionary *reqDataDic = [NSDictionary dictionary];
//        [manger GET:url parameters:reqDataDic success:^(AFHTTPRequestOperation *operation,id responseObject)
//         {
//             NSDictionary *aResult = (NSDictionary *)[operation.responseString JSONValue];
//             if (aResult == Nil) {
//                 [[self class] free];
//                 
//             }
//             else
//             {
//                 NSArray *infoArrays=[aResult objectForKey:@"results"];
//                 if (0 == infoArrays.count) {
//                     [[self class] free];
//                     return;
//                 }
//                 NSDictionary *releaseInfo=[infoArrays objectAtIndex:0];
//                 NSString *lastVersion =[releaseInfo objectForKey:@"version"];
//                 trackViewUrl=[[releaseInfo objectForKey:@"trackViewUrl"]retain];
//                 NSMutableString * noteString = [[NSMutableString alloc] init];
//                 [noteString appendString:[NSString stringWithFormat:@"发现新版本(%@):\n",lastVersion]];
//                 NSString *note=[releaseInfo objectForKey:@"releaseNotes"];
//                 
//                 if (note) {
//                     [noteString appendString:[NSString stringWithFormat:@"%@\n",note]];
//                 }
//                 [noteString appendString:@"是否更新？"];
//                 
//                 NSString *version =[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
//                 
//                 if (![version isEqualToString:lastVersion] )
//                 {
//                     
//                     UIAlertView * view = [[UIAlertView alloc] initWithTitle:@"升级提示" message:noteString delegate:self cancelButtonTitle:@"稍后提醒" otherButtonTitles:@"立刻更新", nil];
//                     [JudgeNewVersion setTextAlignment:NSTextAlignmentLeft forAlertView:view];
//                     [view show];
//                     [view release];
//                     [noteString release];
//                     
//                 }
//                 else
//                 {
//                     if (mCanbeUpdate) {
//                         UIAlertView * view = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您已经是最新版本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                         [view show];
//                         [view release];
//                     }
//                     [noteString release];
//                     [[self class] free];
//                 }
//                 
//             }
//
//         }failure:^(AFHTTPRequestOperation *operation,NSError *errpr)
//         {
//             NSLog(@"failuer");
//         }];
//    }
}

-(BOOL)judgeShouldMonitor
{
//    NSDate *senddate = [NSDate date];
//    NSCalendar  * cal=[NSCalendar  currentCalendar];
//    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
//    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
//    
//    NSInteger day=[conponent day];
//    
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//    
//    NSInteger oldDay =[defaults integerForKey:@"lastDate"];
//    
//    if (day == oldDay) {
//        return NO;
//    }
    return YES;
}


+(UIView*)findSubViewIn:(UIView*)parent OfClass:(id)classObject index:(int)index;
{
    int i = 0;
    for (UIView* subView in parent.subviews)
    {
        if([subView isKindOfClass:classObject])
        {
            if(i == index)
            {
                return subView;
            }
            i++;
        }
    }
    return nil;
}


+(void)setTextAlignment:(NSTextAlignment)alignment forAlertView:(UIAlertView*)view
{
    UILabel* label = (UILabel*)[JudgeNewVersion findSubViewIn:view OfClass:[UILabel class] index:1];
    label.textAlignment = (NSTextAlignment)alignment;
}

-(void) netFailed:(NSInteger)aReqType
{
    [[self class] free];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]] ;
    }

//    if (buttonIndex == 0) {//*******不在提示************//
//        NSDate *senddate = [NSDate date];
//        NSCalendar  * cal=[NSCalendar  currentCalendar];
//        NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
//        NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
//        
//        NSInteger day=[conponent day];
//        
//        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//        
//        [defaults setInteger:day forKey:@"lastDate"];
//        [defaults synchronize];
//    }
    [[self class] free];
}
@end
