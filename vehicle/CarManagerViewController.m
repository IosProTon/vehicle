//
//  CarManagerViewController.m
//  vehicle
//
//  Created by Mac on 15/9/28.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import "CarManagerViewController.h"
#import "CarManagerEnterViewController.h"
@interface CarManagerViewController ()<JGActionSheetDelegate>

@end

@implementation CarManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.site_NO_Label.text = self.site_Search_No;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil  action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.title = @"车辆管理";
    //按钮的圆角属性
    self.chargeBtn.layer.cornerRadius = 4;
    self.chargeBtn.backgroundColor = [UIColor colorWithHexString:@"#ed6900"];
    //添加tap手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SelectTimeBtnClick:)];
    [self.selectView addGestureRecognizer:tap];
    
    //初始日期为当天，并且时间设定的Num为0
   NSArray * dateRangeArr = [[GlobalHelper sharedManager]returnDateStrbyStateNum:0];
    self.startTimeLabel.text = dateRangeArr[1];
    self.endTimeLabel.text = dateRangeArr[0];

    //请求服务器获取签到车辆
    NSString * startTimeStr = [[GlobalHelper sharedManager]returnTimeStr:self.startTimeLabel.text];
    NSString * endTimeStr = [[GlobalHelper sharedManager]returnTimeStr:self.endTimeLabel.text];
    NSString * str = [NSString stringWithFormat:@"%@site_no=%@&begin_time=%@%%2012:00:00&end_time=%@%%2012:00:00",GET_SIGNED_VEHICLE_URL,self.site_Search_No,startTimeStr,endTimeStr];
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
    }];
    
    //iphone5和iphone4适配
    if (iphone4||iPhone5) {
        self.startTimeLabel.font = [UIFont systemFontOfSize:13];
        self.endTimeLabel.font = [UIFont systemFontOfSize:13];
    }
}

#pragma mark -数据更新UI更新
-(void)updateUI:(NSDictionary *)dic
{
    self.enteredLabel.text = [NSString stringWithFormat:@"已进场%@辆",[dic objectForKey:@"inCount"]];
    self.disEnteredLabel.text = [NSString stringWithFormat:@"未进场%@辆",[dic objectForKey:@"notInCount"]];
    NSString * signedNumStr = [NSString stringWithFormat:@"已签到%d辆",[[dic objectForKey:@"inCount"]intValue]+[[dic objectForKey:@"notInCount"]intValue]];
    self.signedLabel.text = signedNumStr;
    [self.view makeToast:@"数据刷新成功"];
}

- (IBAction)SelectTimeBtnClick:(id)sender
{
    NSArray * timeRangeArr = @[@"当天", @"近3天", @"近7天",@"近30天"];
    JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:@"提示" message:@"请选择要查询的时间" buttonTitles:timeRangeArr buttonStyle:JGActionSheetButtonStyleDefault];
    
    NSArray *sections = (iPad ? @[section] : @[section, [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleRed]]);
    
    JGActionSheet *sheet = [[JGActionSheet alloc] initWithSections:sections];
    
    sheet.delegate = self;
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath)
    {

        //选择取消的触发事件
        if (indexPath.row == 101) {
            [sheet dismissAnimated:YES];
            return ;
        }
        self.dateLabel.text = timeRangeArr[indexPath.row];
        //获取时间段
        NSArray * timeRangeArr = [[GlobalHelper sharedManager] returnDateStrbyStateNum:indexPath.row];
        //UI更新
        self.startTimeLabel.text = timeRangeArr[1];
        self.endTimeLabel.text = timeRangeArr[0];
        
        //请求服务器获取签到车辆
        NSString * startTimeStr = [[GlobalHelper sharedManager]returnTimeStr:self.startTimeLabel.text];
        NSString * endTimeStr = [[GlobalHelper sharedManager]returnTimeStr:self.endTimeLabel.text];
        NSString * str = [NSString stringWithFormat:@"%@site_no=%@&begin_time=%@%%2012:00:00&end_time=%@%%2012:00:00",GET_SIGNED_VEHICLE_URL,self.site_Search_No,startTimeStr,endTimeStr];
        [[AllRequest sharedManager]serverRequest:nil url:str byWay:@"GET" successBlock:^(id responseBody)
         {
             NSDictionary * returnDic = responseBody;
             if ([[returnDic objectForKey:@"rc"]intValue]==0) {
                 //更新数据
                 NSDictionary * vehicleSignDic = [returnDic objectForKey:@"data"];
                 [self updateUI:vehicleSignDic];
             }
         } failureBlock:^(NSString *error)
        {
            [self.view makeToast:@"数据请求失败！"];
         }];


        
        [sheet dismissAnimated:YES];
    }];
    
    [sheet showInView:self.navigationController.view animated:YES];
    
}

- (IBAction)ChargeBtnClick:(id)sender
{
    CarManagerEnterViewController * carManagerEnterVC = [[CarManagerEnterViewController alloc]initWithNibName:@"CarManagerEnterViewController" bundle:[NSBundle mainBundle]];
    carManagerEnterVC.site_Search_No = self.site_Search_No;
    carManagerEnterVC.title = @"安排车辆";
    [self.navigationController pushViewController:carManagerEnterVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
