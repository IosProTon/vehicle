//
//  HRtabBarController.m
//  Hire
//
//  Created by Wangchengshan on 15/4/12.
//  Copyright (c) 2015年 Wangchengshan. All rights reserved.
//
//  自定义tabbarcontroller

#import "HRtabBarController.h"
#import "HRTabBar.h"
#import "HRNavigationController.h"
#import "HomeViewController.h"
#import "PersonViewController.h"
#import "MessageViewController.h"
#import "UIView+Toast.h"
@interface HRtabBarController ()<HRTabBarDelegate>
@property (nonatomic,weak) HRTabBar * HRtabBar;
@end

@implementation HRtabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view makeToast:@"已登录"];
    //加载自定义tabBar
    [self setupTabBar];
    //加载所有子控制器
    [self setupAllchildViewControllers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

#pragma mark 加载自定义tabBar
-(void)setupTabBar{
    HRTabBar * HRtabBar = [[HRTabBar alloc]init];
    HRtabBar.frame = self.tabBar.bounds;
    HRtabBar.backgroundColor = HRColor(244, 245, 246);
    HRtabBar.delegate = self;
    [self.tabBar addSubview:HRtabBar];
    self.HRtabBar = HRtabBar;
    
}

-(void)setupAllchildViewControllers{
    //1.主页
    HomeViewController * homeVC = [[HomeViewController alloc]init];
    [self setupChildViewController:homeVC Title:@"首页" ImageName:@"table_one_no" SelectedImageName:@"table_one_yes"];
    //2.消息
    MessageViewController * messageVC = [[MessageViewController alloc]init];
    [self setupChildViewController:messageVC Title:@"消息" ImageName:@"table_two_no" SelectedImageName:@"table_two_yes"];
    //3.个人
    PersonViewController * personVC = [[PersonViewController alloc]init];
    [self setupChildViewController:personVC Title:@"个人" ImageName:@"table_three_no" SelectedImageName:@"table_three_yes"];
}

-(void)setupChildViewController:(UIViewController *)childVc Title:(NSString *)title ImageName:(NSString *)imageName SelectedImageName:(NSString *)selectedImageName{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 2.包装一个导航控制器
    HRNavigationController *nav = [[HRNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.HRtabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

-(void)tabBar:(HRTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to{
    self.selectedIndex = to;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
