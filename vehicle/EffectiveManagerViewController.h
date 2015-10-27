//
//  EffectiveManagerViewController.h
//  vehicle
//
//  Created by Mac on 15/10/19.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EffectiveManagerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegment;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraint;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@end
