//
//  CockpitViewController.h
//  vehicle
//
//  Created by Mac on 15/10/19.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CockpitViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *addCategory;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,retain)NSArray *titleArray;
@property(nonatomic,retain)NSArray *imageArray;
@property(nonatomic,strong)NSMutableArray * listInfoArr;
- (IBAction)addCategory:(id)sender;

@end
