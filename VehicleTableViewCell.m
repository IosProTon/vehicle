//
//  VehicleTableViewCell.m
//  vehicle
//
//  Created by Mac on 15/9/29.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import "VehicleTableViewCell.h"
@implementation VehicleTableViewCell

- (void)awakeFromNib
{
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier content:(VehicleDetailInfo *)vehicleInfo andIndexPath:(NSIndexPath*)indexPath andVehicleEnter:(BOOL)vehicleEnter
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
//        self.signTimeLabel.text = @"签到时间";
//        self.carNumLabel.text = @"车牌号";
//        self.driverNameLabel.text = @"司机姓名";
//        self.operateLabel.text = @"操作";
        if (iPhone5||iphone4)
        {
            self.signTimeLabel.font = [UIFont systemFontOfSize:14];
        }
        else
        {
            self.signTimeLabel.font = [UIFont systemFontOfSize:15];
        }
        self.signTimeLabel.text = [self returnSimpleDateStr:vehicleInfo.signTime];
        self.carNumLabel.text = vehicleInfo.carNo;
        [self.driverNameBtn setTitle:vehicleInfo.driverName forState:UIControlStateNormal];


        //确认进场按钮
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = indexPath.row;
        btn.frame = self.operateBtn.frame;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        if (vehicleEnter)//已进场
        {
            [btn removeFromSuperview];
            [self.operateBtn setTitle:[self returnSimpleDateStr2:vehicleInfo.inTime] forState:UIControlStateNormal];
            if (iPhone5||iphone4) {
                self.operateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            }

        }
        else                  //未进场
        {
            [self addSubview:btn];
            [self.operateBtn setTitle:@"确认进场" forState:UIControlStateNormal];
        }
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(OperateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btn];

    }

    
    return self;
}


-(void)OperateBtnClick:(id)sender
{
    UIButton * btn = (UIButton*)sender;
    NSInteger row = btn.tag;
    [self.delegate operateBtnClickDelegate:row];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

//签到时间格式转换
-(NSString *)returnSimpleDateStr:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateStr];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat: @"MM-dd HH:mm"];

    NSString *destDateString = [dateFormatter2 stringFromDate:destDate];
    return destDateString;
}
//进场时间格式转换
-(NSString *)returnSimpleDateStr2:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy/MM/dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateStr];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat: @"MM-dd HH:mm"];
    
    NSString *destDateString = [dateFormatter2 stringFromDate:destDate];
    return destDateString;
}
@end
