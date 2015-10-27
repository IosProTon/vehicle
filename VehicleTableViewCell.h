//
//  VehicleTableViewCell.h
//  vehicle
//
//  Created by Mac on 15/9/29.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VehicleDetailInfo.h"
@protocol CellViewDelegate <NSObject>

@optional
//代理方法定义
-(void)operateBtnClickDelegate:(NSInteger)row;
@end

@interface VehicleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *signTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *driverNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *operateBtn;
@property (nonatomic,weak) id<CellViewDelegate> delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier content:(VehicleDetailInfo *)vehicleInfo andIndexPath:(NSIndexPath*)indexPath andVehicleEnter:(BOOL)vehicleEnter
;
@end
