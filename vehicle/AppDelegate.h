//
//  AppDelegate.h
//  vehicle
//
//  Created by Mac OS on 15/7/30.
//  Copyright (c) 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,assign)BOOL usable;
@property (nonatomic,retain) NSArray * roleArr;//登录角色所有信息
@end

