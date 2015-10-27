//
//  HRListBtn.h
//  全国资产页面
//
//  Created by ProTon on 15/10/19.
//  Copyright © 2015年 ton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRListBtn : UIButton
@property (nonatomic,weak)UIImageView * myImageView;
@property (nonatomic,weak)UILabel * myTitleLabel;
@property (nonatomic,weak)UILabel * myCountLabel;

-(void)initWithImage:(int)num;//图片
-(void)initWithTitle:(NSString*)title;
@end
