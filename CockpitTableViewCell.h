//
//  CockpitTableViewCell.h
//  vehicle
//
//  Created by Mac on 15/10/19.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListInfoModel.h"

@interface CockpitTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagesView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

-(void)receiveModel:(ListInfoModel *)listInfo;

@end
