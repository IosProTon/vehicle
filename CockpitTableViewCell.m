//
//  CockpitTableViewCell.m
//  vehicle
//
//  Created by Mac on 15/10/19.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import "CockpitTableViewCell.h"
@implementation CockpitTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.textColor = [UIColor grayColor];
    self.detailLabel.textColor = [UIColor grayColor];
   }
-(void)receiveModel:(ListInfoModel *)listInfo
{
    self.imagesView.image = [UIImage imageNamed:listInfo.headImage];
    self.titleLabel.text = listInfo.title;
    self.detailLabel.text = listInfo.detailTitle;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
