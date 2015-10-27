//
//  ViewController.h
//  vehicle
//
//  Created by Mac OS on 15/7/30.
//  Copyright (c) 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSString * updateUrlStr;//版本更新地址
}
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *carLabel;
@property (weak, nonatomic) IBOutlet UITextField *carTextField;
@property (weak, nonatomic) IBOutlet UILabel *pwLabel;
@property (weak, nonatomic) IBOutlet UITextField *pwTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UIImageView *lineImageView;

- (IBAction)loginBtn:(id)sender;


@end

