//
//  CarManagerViewController.h
//  vehicle
//
//  Created by Mac on 15/9/28.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarManagerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *signedLabel;
@property (weak, nonatomic) IBOutlet UILabel *enteredLabel;
@property (weak, nonatomic) IBOutlet UIButton *chargeBtn;
@property (weak, nonatomic) IBOutlet UILabel *disEnteredLabel;
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UILabel *site_NO_Label;
@property (nonatomic,copy) NSString * site_Search_No;
- (IBAction)SelectTimeBtnClick:(id)sender;
- (IBAction)ChargeBtnClick:(id)sender;

@end
