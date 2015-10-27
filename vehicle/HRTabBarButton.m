//
//  HRTabBarButton.m
//  Hire
//
//  Created by Wangchengshan on 15/4/12.
//  Copyright (c) 2015年 Wangchengshan. All rights reserved.
//

#import "HRTabBarButton.h"

#define BTN_IMG_RATIO 0.6  //按钮图片占按钮的比例

@implementation HRTabBarButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        // 图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 字体大小
        self.titleLabel.font = [UIFont italicSystemFontOfSize:14.0];
    }
    return self;
}

// 重写去掉高亮状态
- (void)setHighlighted:(BOOL)highlighted {}

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * BTN_IMG_RATIO;
    return CGRectMake(0, 0, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * BTN_IMG_RATIO;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

-(void)setItem:(UITabBarItem *)item
{
    _item = item;
    // 设置文字
    [self setTitle:item.title forState:UIControlStateSelected];
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    // 设置图片
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
}
@end
