//
//  submitViewController.h
//  StoVehicleSignedIos
//
//  Created by Mac OS on 15/7/29.
//  Copyright (c) 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface submitViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *carNumber;
@property (weak, nonatomic) IBOutlet UITextField *carNumTF;
@property (weak, nonatomic) IBOutlet UIImageView *carLineImageView;

@property (weak, nonatomic) IBOutlet UILabel *psw;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UIImageView *pswLineImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsPsw;
@property (weak, nonatomic) IBOutlet UITextField *newsPswTF;
@property (weak, nonatomic) IBOutlet UIImageView *newsPswLineImageView;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;


- (IBAction)submitBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *visualBtnClick;


@end
