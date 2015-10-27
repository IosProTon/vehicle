//
//  NationalAssetsViewController.h
//  全国资产页面
//
//  Created by ProTon on 15/10/19.
//  Copyright © 2015年 ton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXPullDownMenu.h"

@interface NationalAssetsViewController : UIViewController<MXPullDownMenuDelegate>
{
    MXPullDownMenu *menu ;
}
@property (strong, nonatomic)UIScrollView *contentScrollView;
//@property (nonatomic,copy)NSString * totalcount;
//@property (nonatomic,copy)NSString *guncount;
//@property (nonatomic,copy)NSString *percount;
//@property (nonatomic,copy)NSString *areacount;
//@property (nonatomic,copy)NSString *sitecount;
//@property (nonatomic,copy)NSString *carcount;
//@property (nonatomic ,retain)NSArray * sumlistArray;
@property (nonatomic,retain)NSMutableDictionary * dict;

@end
