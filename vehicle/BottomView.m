//
//  BotomView.m
//  vehicle
//
//  Created by Mac on 15/9/16.
//  Copyright (c) 2015年 Mac OS. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView
-(instancetype)initWithFrame:(CGRect)frame
{

    if (self == [super initWithFrame:frame])
    {
        self.backgroundColor=[UIColor whiteColor];
    }
    
    return self;
}

-(void)awakeFromNib
{
    self.carLabel.lineBreakMode = 0;
    self.scanLabel.lineBreakMode = 0;
}
-(void)layoutSubviews
{
    self.frame = CGRectMake(0, SCREEN_HEIGHT-80-64, SCREEN_WIDTH, 80);
    [super layoutSubviews];
}
- (IBAction)signBtnClick:(id)sender
{
    [self.delegate SignBtnClick];
}
@end
