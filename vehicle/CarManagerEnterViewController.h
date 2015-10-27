//
//  CarManagerEnterViewController.h
//  vehicle
//
//  Created by Mac on 15/9/28.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CarManagerEnterViewController : UIViewController
{
}
@property (weak, nonatomic) IBOutlet UIView *CellTitleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seprateLineConstraint_1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seprateLineConstraint_2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seprateLineConstraint_3;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegment;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *selectTimeView;
@property (weak, nonatomic) IBOutlet UIButton *selectTimeBtn;
@property (weak, nonatomic) IBOutlet UITableView *vehicleTableView;
@property (weak, nonatomic) IBOutlet UILabel *operationOrEnterTimeLabel;
@property (nonatomic,assign) BOOL vehicleEnter;//NO表示为未进场   YES为已进场
@property (nonatomic,retain) NSMutableArray * vehicleArray;//存储模型的数组
@property(nonatomic,assign) NSString * carID;
@property (nonatomic,copy) NSString * site_Search_No;//角色对应的站点号


- (IBAction)SegmentSelect:(id)sender;
- (IBAction)SelectBtnClick:(id)sender;

@end
