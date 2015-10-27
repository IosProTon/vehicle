//
//  CarCountViewController.m
//  vehicle
//
//  Created by Mac on 15/9/28.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import "CarCountViewController.h"
#import "AreaSiteSelectViewController.h"
@interface CarCountViewController ()

@end

@implementation CarCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil  action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    //添加tap手势
    UITapGestureRecognizer * clickAreaTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAreaBtnClick:)];
    [self.selectAreaView addGestureRecognizer:clickAreaTap];
    UITapGestureRecognizer * clickTimeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SelectTimeBtnClick:)];
    [self.selectTimeView addGestureRecognizer:clickTimeTap];
    
    //初始日期为当天，并且时间设定的Num为0
    NSArray * dateRangeArr = [[GlobalHelper sharedManager]returnDateStrbyStateNum:0];
    self.startTimeLabel.text = dateRangeArr[1];
    self.endTimeLabel.text = dateRangeArr[0];
    

    //默认出现全国车辆统计
    [self queryCountrywide];
    
    //iphone5和iphone4适配
    if (iphone4||iPhone5) {
        self.startTimeLabel.font = [UIFont systemFontOfSize:13];
        self.endTimeLabel.font = [UIFont systemFontOfSize:13];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 获取数据更新UI
-(void)updateUI:(NSDictionary *)dic
{
    if (![dic objectForKey:@"notSignNum"]) {
        self.sendCarNumLabel.text = [NSString stringWithFormat:@"%@辆",[dic objectForKey:@"departNum"]];
        self.arrivedCarNumLabel.text = [NSString stringWithFormat:@"%@辆",[dic objectForKey:@"arriveNum"]];
        self.inWayCarLabel.text = [NSString stringWithFormat:@"%@辆",[dic objectForKey:@"onTheWayNum"]];

    }
    else
    {
        self.sSignLabel.text = [NSString stringWithFormat:@"应签到%@辆",[dic objectForKey:@"standSignNum"]];
        self.hSignLabel.text = [NSString stringWithFormat:@"已签到%@辆",[dic objectForKey:@"realSignNum"]];
        self.nSignLabel.text = [NSString stringWithFormat:@"未签到%@辆",[dic objectForKey:@"notSignNum"]];
    }
    [self.view makeToast:@"数据刷新成功"];
   }

#pragma mark - 选择查询区域事件点击
- (IBAction)selectAreaBtnClick:(id)sender
{
    NSArray * areaRangeArr = @[@"全国", @"大区", @"站点"];
    JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:@"提示" message:@"请选择要查询的时间" buttonTitles:areaRangeArr buttonStyle:JGActionSheetButtonStyleDefault];
    
    NSArray *sections = (iPad ? @[section] : @[section, [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleRed]]);
    
    JGActionSheet *sheet = [[JGActionSheet alloc] initWithSections:sections];
    
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath)
     {
         if (indexPath.row == 101) {
             [sheet dismissAnimated:YES];
             return ;
         }
         //选择全国的触发事件
         if (indexPath.row ==0)
         {
             [self queryCountrywide];

         }
         else if (indexPath.row ==1)//大区
         {
             AreaSiteSelectViewController * areaVC = [[AreaSiteSelectViewController alloc]init];
             areaVC.delegate = self;
             areaVC.statusStr = @"2";
             areaVC.title = @"选择大区";
             [self.navigationController pushViewController:areaVC animated:YES];
         }
         else if(indexPath.row ==2)//站点
         {
             AreaSiteSelectViewController * areaVC = [[AreaSiteSelectViewController alloc]init];
             areaVC.delegate = self;
             areaVC.statusStr = @"3";
             areaVC.title = @"大区";
             [self.navigationController pushViewController:areaVC animated:YES];

         }
        //请求服务器再刷新签到车辆
         
         
         //        [AllRequest sharedManager]serverRequest:<#(NSDictionary *)#> url:<#(NSString *)#> byWay:@"GET" successBlock:^(id responseBody) {
         //
         //        } failureBlock:^(NSString *error) {
         //
         //        }];
         
         
         [sheet dismissAnimated:YES];
     }];
    
    [sheet showInView:self.navigationController.view animated:YES];
}
#pragma mark - 选择查询时间时间点击
- (IBAction)SelectTimeBtnClick:(id)sender
{
    NSArray * timeRangeArr = @[@"当天", @"近3天", @"近7天",@"近30天"];
    JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:@"提示" message:@"请选择要查询的时间" buttonTitles:timeRangeArr buttonStyle:JGActionSheetButtonStyleDefault];
    
    NSArray *sections = (iPad ? @[section] : @[section, [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleRed]]);
    
    JGActionSheet *sheet = [[JGActionSheet alloc] initWithSections:sections];
    
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath)
     {
         if (indexPath.row == 101) {
             [sheet dismissAnimated:YES];
             return ;
         }
         //选择时间段的触发事件
         self.selectTimeLabel.text = timeRangeArr[indexPath.row];
         //获取时间段
         NSArray * timeRangeArr = [[GlobalHelper sharedManager] returnDateStrbyStateNum:indexPath.row];
         //UI更新
         self.startTimeLabel.text = timeRangeArr[1];
         self.endTimeLabel.text = timeRangeArr[0];
         if ([self.selectAreaLabel.text isEqualToString:@"查询全国"]) //全国查询
         {
             [self queryCountrywide];
         }
         else if([self.statusStr isEqualToString:@"2"])//查询大区==2
         {
             [self queryAreawide:self.siteNo withStatusStr:@"2"];
         }
         else                                                               //查询站点==3
         {
             [self queryAreawide:self.siteNo withStatusStr:@"3"];
         }
         
         [sheet dismissAnimated:YES];
     }];
    
    [sheet showInView:self.navigationController.view animated:YES];
}
#pragma mark - 查询全国车辆以及签到请求
-(void)queryCountrywide
{
    self.selectAreaLabel.text = @"查询全国";
    //请求服务器获取发出到达在途以及签到车辆
    NSString * startTimeStr = [[GlobalHelper sharedManager]returnTimeStr:self.startTimeLabel.text];
    NSString * endTimeStr = [[GlobalHelper sharedManager]returnTimeStr:self.endTimeLabel.text];
    //发出到达在途车辆
    NSString * str = [NSString stringWithFormat:@"%@level=1&begin_time=%@%%2012:00:00&end_time=%@%%2012:00:00",GET_ALL_VEHICLE_URL,startTimeStr,endTimeStr];
    [[AllRequest sharedManager]serverRequest:nil url:str byWay:@"GET" successBlock:^(id responseBody)
     {
         NSDictionary * returnDic = responseBody;
         if ([[returnDic objectForKey:@"rc"]intValue]==0) {
             //更新数据
             NSDictionary * vehicleSignDic = [returnDic objectForKey:@"data"];
             [self updateUI:vehicleSignDic];
         }
     } failureBlock:^(NSString *error) {
         [self.view makeToast:@"数据请求失败！"];
         [self clearUIforRequestFaild];
     }];
    
    //签到车辆
    NSString * signRequestStr = [NSString stringWithFormat:@"%@level=1&begin_time=%@%%2012:00:00&end_time=%@%%2012:00:00",GET_ALL_SIGNVEHICLE_URL,startTimeStr,endTimeStr];
    [[AllRequest sharedManager]serverRequest:nil url:signRequestStr byWay:@"GET" successBlock:^(id responseBody)
     {
         NSDictionary * returnDic = responseBody;
         if ([[returnDic objectForKey:@"rc"]intValue]==0) {
             //更新数据
             NSDictionary * vehicleSignDic = [returnDic objectForKey:@"data"];
             [self updateUI:vehicleSignDic];
         }
     } failureBlock:^(NSString *error) {
         [self.view makeToast:@"数据请求失败！"];
         [self clearUIforRequestFaild];
     }];

}
-(void)clearUIforRequestFaild
{
    self.sendCarNumLabel.text = @"0辆";
    self.arrivedCarNumLabel.text = @"0辆";
    self.inWayCarLabel.text = @"0辆";
    self.sSignLabel.text = @"应签到0辆";
    self.hSignLabel.text = @"已签到0辆";
    self.nSignLabel.text = @"未签到0辆";

}
#pragma mark - 查询大区或站点的车辆以及签到请求
-(void)queryAreawide:(NSString *)site_no withStatusStr:(NSString *)statusStr//2==大区 3==站点
{
    //请求服务器获取发出到达在途以及签到车辆
    NSString * startTimeStr = [[GlobalHelper sharedManager]returnTimeStr:self.startTimeLabel.text];
    NSString * endTimeStr = [[GlobalHelper sharedManager]returnTimeStr:self.endTimeLabel.text];
    //发出到达在途车辆
    NSString * str = [NSString stringWithFormat:@"%@level=%@&site_no=%@&begin_time=%@%%2012:00:00&end_time=%@%%2012:00:00",GET_ALL_VEHICLE_URL,statusStr,site_no,startTimeStr,endTimeStr];
    [[AllRequest sharedManager]serverRequest:nil url:str byWay:@"GET" successBlock:^(id responseBody)
     {
         NSDictionary * returnDic = responseBody;
         if ([[returnDic objectForKey:@"rc"]intValue]==0) {
             //更新数据
             NSDictionary * vehicleSignDic = [returnDic objectForKey:@"data"];
             [self updateUI:vehicleSignDic];
         }
     } failureBlock:^(NSString *error) {
         [self.view makeToast:@"数据请求失败！"];
         [self clearUIforRequestFaild];
     }];
    
    //签到车辆
    NSString * signRequestStr = [NSString stringWithFormat:@"%@level=%@&site_no=%@&begin_time=%@%%2012:00:00&end_time=%@%%2012:00:00",GET_ALL_SIGNVEHICLE_URL,statusStr,site_no,startTimeStr,endTimeStr];
    [[AllRequest sharedManager]serverRequest:nil url:signRequestStr byWay:@"GET" successBlock:^(id responseBody)
     {
         NSDictionary * returnDic = responseBody;
         if ([[returnDic objectForKey:@"rc"]intValue]==0) {
             //更新数据
             NSDictionary * vehicleSignDic = [returnDic objectForKey:@"data"];
             [self updateUI:vehicleSignDic];
         }
     } failureBlock:^(NSString *error) {
         [self.view makeToast:@"数据请求失败！"];
         [self clearUIforRequestFaild];
     }];
    
}

#pragma mark -查询大区回调方法
-(void)AreaQuery:(NSString *)site_no withAreaStr:(NSString *)areaStr andStatus:(NSString *)statusNum
{
    self.statusStr = statusNum;
    self.selectAreaLabel.text = [NSString stringWithFormat:@"%@~%@",areaStr,site_no];
    self.siteNo = site_no;
    //获取数据并更新
    [self queryAreawide:site_no withStatusStr:statusNum];
}
@end
