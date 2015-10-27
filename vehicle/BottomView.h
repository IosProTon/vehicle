//
//  BotomView.h
//  vehicle
//
//  Created by Mac on 15/9/16.
//  Copyright (c) 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BottomViewDelegate <NSObject>

@optional
//代理方法定义
-(void)SignBtnClick;
@end
@interface BottomView : UIView
@property (weak, nonatomic) IBOutlet UIButton *signBtn;
@property (weak, nonatomic) IBOutlet UILabel *carLabel;
@property (weak, nonatomic) IBOutlet UILabel *scanLabel;

@property (nonatomic,weak) id<BottomViewDelegate> delegate;

- (IBAction)signBtnClick:(id)sender;

@end
