//
//  AreaSiteSelectViewController.h
//  vehicle
//
//  Created by Mac on 15/10/10.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AreaQueryDelegate <NSObject>

@optional
//代理方法定义 statusNum==2==大区   statusNum==3==站点
-(void)AreaQuery:(NSString *)site_no withAreaStr:(NSString *)areaStr andStatus:(NSString *)statusNum;
@end
@interface AreaSiteSelectViewController : UIViewController

@property (nonatomic,weak) id<AreaQueryDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *areaTableView;
@property (nonatomic,retain) NSMutableArray * areaArray;//存储大区或者站点的数据
@property (nonatomic,copy) NSString * statusStr; //2==选择大区   3==选择站点
@property (nonatomic,retain)NSMutableArray * areaNumArr;//存储大区或站点对应编号的字典
@property (nonatomic,assign)BOOL siteSelect;//NO==大区  YES==站点
@end
