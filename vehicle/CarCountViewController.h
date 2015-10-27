//
//  CarCountViewController.h
//  vehicle
//
//  Created by Mac on 15/9/28.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaSiteSelectViewController.h"

@interface CarCountViewController : UIViewController<AreaQueryDelegate>
@property (weak, nonatomic) IBOutlet UIView *selectAreaView;
@property (weak, nonatomic) IBOutlet UILabel *selectAreaLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectAreaBtn;
@property (weak, nonatomic) IBOutlet UIView *selectTimeView;
@property (weak, nonatomic) IBOutlet UILabel *selectTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectTimeBtn;
@property (weak, nonatomic) IBOutlet UILabel *sendCarNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivedCarNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *inWayCarLabel;
//应签到车辆
@property (weak, nonatomic) IBOutlet UILabel *sSignLabel;
//已签到车辆
@property (weak, nonatomic) IBOutlet UILabel *hSignLabel;
//未签到车辆
@property (weak, nonatomic) IBOutlet UILabel *nSignLabel;
//纪录查询地区/地点的编号
@property (copy,nonatomic) NSString * siteNo;
//2==选择大区   3==选择站点
@property (nonatomic,copy) NSString * statusStr;

- (IBAction)SelectTimeBtnClick:(id)sender;
- (IBAction)selectAreaBtnClick:(id)sender;

@end
