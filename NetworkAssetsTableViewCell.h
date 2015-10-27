//
//  NetworkAssetsTableViewCell.h
//  vehicle
//
//  Created by Mac on 15/10/21.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWorkAssetsInfoModel.h"
@interface NetworkAssetsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagesView;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

-(void)receiveModel:(NetWorkAssetsInfoModel *)listInfo;
@end
