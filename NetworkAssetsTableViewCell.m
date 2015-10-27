//
//  NetworkAssetsTableViewCell.m
//  vehicle
//
//  Created by Mac on 15/10/21.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import "NetworkAssetsTableViewCell.h"
@implementation NetworkAssetsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)receiveModel:(NetWorkAssetsInfoModel *)listInfo
{
    UIImage * ima =[UIImage imageNamed:listInfo.headImage];

    self.imagesView.image = [UIImage imageNamed:listInfo.headImage];
    self.titleLabel.text = listInfo.title;
    self.detailLabel.text = listInfo.detailTitle;
    self.leftTitleLabel.text = listInfo.leftTitle;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
