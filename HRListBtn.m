//
//  HRListBtn.m
//  全国资产页面
//
//  Created by ProTon on 15/10/19.
//  Copyright © 2015年 ton. All rights reserved.
//

#import "HRListBtn.h"

@implementation HRListBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self == [super initWithFrame:frame])
    {
        self.backgroundColor=[UIColor whiteColor];
        //设置边框
        //初始化imageview
        UIImageView * myImageView = [[UIImageView alloc]init];
        self.myImageView = myImageView;
        [self addSubview:myImageView];
        //初始化myTitleLabel
        UILabel * myTitleLabel = [[UILabel alloc]init];
        self.myTitleLabel = myTitleLabel;
        myTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:myTitleLabel];
        //初始化myTitleLabel
        UILabel * myCountLabel = [[UILabel alloc]init];
        self.myCountLabel = myCountLabel;
        myCountLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:myCountLabel];
    }
    
    return self;
}

-(void)awakeFromNib
{
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    self.myImageView.frame = CGRectMake(10, 28, 22, 22);

    self.myTitleLabel.frame = CGRectMake(42, 33, 70, 20);
    self.myCountLabel.frame = CGRectMake(42, CGRectGetMaxY(self.myImageView.frame), width, 45);
    
}

-(void)initWithImage:(int)num
{
    self.myImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"functionImage_%d",num]];
}

-(void)initWithTitle:(NSString*)title
{
    self.myTitleLabel.text = title;
    self.myTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.myTitleLabel.font = [UIFont systemFontOfSize:15];
    
    self.myCountLabel.text = @"空";
    self.myCountLabel.font = [UIFont systemFontOfSize:27];
    self.myCountLabel.textAlignment = NSTextAlignmentLeft;
}

@end
