//
//  NetworkAssetsViewController.h
//  vehicle
//
//  Created by Mac on 15/10/20.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkAssetsViewController : UIViewController
{
    UITableView * myTableView;
    
}
@property(nonatomic,strong)NSMutableArray * netWorkAssetsInfoArr;

@end
