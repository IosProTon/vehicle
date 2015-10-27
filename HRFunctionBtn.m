//
//  HRFunctionBtn.m
//  vehicle
//
//  Created by Mac on 15/9/28.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import "HRFunctionBtn.h"

@implementation HRFunctionBtn

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
        //初始化label
        UILabel * label = [[UILabel alloc]init];
        self.label = label;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
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
    self.myImageView.frame = CGRectMake(0, 0, 45, 45);
    self.myImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.width/2-15);
    self.label.frame = CGRectMake(0, CGRectGetMaxY(self.myImageView.frame)+5, width, 15);
    
    
}

-(void)initWithImage:(int)num
{
    self.myImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"function_%d",num]];
}

-(void)initWithTitle:(NSString*)title
{
    self.label.text = title;
    self.label.font = [UIFont systemFontOfSize:15];
    
}

@end
