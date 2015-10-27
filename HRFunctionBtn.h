//
//  HRFunctionBtn.h
//  vehicle
//
//  Created by Mac on 15/9/28.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRFunctionBtn : UIButton
@property (nonatomic,weak)UIImageView * myImageView;
@property (nonatomic,weak)UILabel * label;

-(void)initWithImage:(int)num;//图片
-(void)initWithTitle:(NSString*)title;
@end
