//
//  HRTabBar.m
//  Hire
//
//  Created by Wangchengshan on 15/4/12.
//  Copyright (c) 2015年 Wangchengshan. All rights reserved.
//

#import "HRTabBar.h"
#import "HRTabBarButton.h"

@interface HRTabBar()

@property (nonatomic, weak) HRTabBarButton * selectedButton;

@end

@implementation HRTabBar

-(void)addTabBarButtonWithItem:(UITabBarItem *)item{
    // 1.创建按钮
    HRTabBarButton *button = [[HRTabBarButton alloc] init];
    [self addSubview:button];
    
    // 2.设置数据
    button.item = item;
    
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 4.默认选中第0个按钮
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 按钮的frame数据
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index<self.subviews.count; index++) {
        // 1.取出按钮
        HRTabBarButton *button = self.subviews[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}


- (void)buttonClick:(HRTabBarButton *)button
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    // 2.设置按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
//    [button setTitleColor:[UIColor colorWithHexString:@"#ed6900"] forState:UIControlStateNormal];
    self.selectedButton = button;
    
}


@end
