//
//  HRTabBar.h
//  Hire
//
//  Created by Wangchengshan on 15/4/12.
//  Copyright (c) 2015年 Wangchengshan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HRTabBar;

@protocol HRTabBarDelegate <NSObject>

@optional
- (void)tabBar:(HRTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;

@end

@interface HRTabBar : UIView

-(void)addTabBarButtonWithItem:(UIBarItem *)item;

@property (nonatomic, weak) id<HRTabBarDelegate> delegate;

@end
