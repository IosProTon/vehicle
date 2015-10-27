//
//  CarManagerEnterViewController.m
//  vehicle
//
//  Created by Mac on 15/9/28.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import "CarManagerEnterViewController.h"
#import "VehicleDetailInfo.h"
#import "VehicleTableViewCell.h"
#import "MJRefresh.h"
#import "UIScrollView+EmptyDataSet.h"

@interface CarManagerEnterViewController ()<JGActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,CellViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,UIAlertViewDelegate>

@end

@implementation CarManagerEnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //segement
    self.mySegment.tintColor = [UIColor colorWithHexString:@"#ed6900"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor  colorWithHexString:@"#ed6900"],NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName ,nil];
    [self.mySegment setTitleTextAttributes:dic forState:UIControlStateNormal];
   
    //CellTitleView的UI布局
    self.CellTitleView.backgroundColor = [UIColor grayColor];
    self.CellTitleView.layer.borderColor = [UIColor blackColor].CGColor;
    self.CellTitleView.layer.borderWidth = 1;
    if (iPhone6)
    {
        self.seprateLineConstraint_1.constant = 108;
        self.seprateLineConstraint_2.constant = 100;
        self.seprateLineConstraint_3.constant = 60;    }
    else if (iPhone6plus)
    {
    }
    else
    {
        self.seprateLineConstraint_1.constant = 88;
        self.seprateLineConstraint_2.constant = 80;
        self.seprateLineConstraint_3.constant = 60;
    }
    //添加tap手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SelectBtnClick:)];
    [self.selectTimeView addGestureRecognizer:tap];

    //初始日期为当天，并且时间设定的Num为0
    NSArray * dateRangeArr = [[GlobalHelper sharedManager]returnDateStrbyStateNum:0];
    self.startTimeLabel.text = dateRangeArr[1];
    self.endTimeLabel.text = dateRangeArr[0];

    //默认显示当天   未进场的车辆详情
    [self getVehicleInfo:self.vehicleEnter];//vehicleEnter初始值为NO
    
    //iphone5和iphone4适配
    if (iphone4||iPhone5) {
        self.startTimeLabel.font = [UIFont systemFontOfSize:13];
        self.endTimeLabel.font = [UIFont systemFontOfSize:13];
    }
    
    //MJRefresh默认刷新案例1
    [self example01];
    //DZNEmptyDataSet表格无数据案例
    self.vehicleTableView.emptyDataSetSource = self;
    self.vehicleTableView.emptyDataSetDelegate = self;
    // A little trick for removing the cell separators
    self.vehicleTableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SegmentSelect:(id)sender
{
    UISegmentedControl * segmentControl = (UISegmentedControl *)sender;
    switch (segmentControl.selectedSegmentIndex) {
        case 0://未进场的车辆显示
        {
            self.vehicleEnter = NO;
            self.operationOrEnterTimeLabel.text = @"操作";
            //刷新数据
            [self getVehicleInfo:self.vehicleEnter];
        }
            break;
        case 1://已进场的车俩显示
        {
            self.vehicleEnter = YES;
            self.operationOrEnterTimeLabel.text = @"进场时间";
            //刷新数据
            [self getVehicleInfo:self.vehicleEnter];
        }
            break;
        default:
            break;
    }
}

- (IBAction)SelectBtnClick:(id)sender
{
    NSArray * timeRangeArr = @[@"当天", @"近3天", @"近7天",@"近30天"];
    JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:@"提示" message:@"请选择要查询的时间" buttonTitles:timeRangeArr buttonStyle:JGActionSheetButtonStyleDefault];
    
    NSArray *sections = (iPad ? @[section] : @[section, [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"取消"] buttonStyle:JGActionSheetButtonStyleRed]]);
    
    JGActionSheet *sheet = [[JGActionSheet alloc] initWithSections:sections];
    sheet.delegate = self;
    
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath)
     {
         if (indexPath.row == 101) {
             [sheet dismissAnimated:YES];
             return ;
         }
         //选择时间段的触发事件
         self.dateLabel.text = timeRangeArr[indexPath.row];
         //获取时间段
         NSArray * timeRangeArr = [[GlobalHelper sharedManager] returnDateStrbyStateNum:indexPath.row];
         //UI更新
         self.startTimeLabel.text = timeRangeArr[1];
         self.endTimeLabel.text = timeRangeArr[0];
         //请求服务器再刷新签到车辆
         
         [self getVehicleInfo:self.vehicleEnter];
         
         [sheet dismissAnimated:YES];
     }];
    
    [sheet showInView:self.navigationController.view animated:YES];
}
//获取已未进场车辆
-(void)getVehicleInfo:(BOOL)vehicleEnter
{
    NSString * statusStr = [NSString stringWithFormat:@"%d",vehicleEnter];//未进场为0，已进场为1

    //请求服务器获取签到车辆
    NSString * startTimeStr = [[GlobalHelper sharedManager]returnTimeStr:self.startTimeLabel.text];
    NSString * endTimeStr = [[GlobalHelper sharedManager]returnTimeStr:self.endTimeLabel.text];
    NSString * str = [NSString stringWithFormat:@"%@site_no=%@&begin_time=%@%%2012:00:00&end_time=%@%%2012:00:00&status=%@",GET_VEHICLEDETAIL_URL,self.site_Search_No,startTimeStr,endTimeStr,statusStr];
    [[AllRequest sharedManager]serverRequest:nil url:str byWay:@"GET" successBlock:^(id responseBody)
     {
         NSDictionary * returnDic = responseBody;
         if ([[returnDic objectForKey:@"rc"]intValue]==0) {
             //更新数据
             self.vehicleArray = [returnDic objectForKey:@"data"];
             [self.vehicleTableView reloadData];
            [self.vehicleTableView.header endRefreshing];

             [self.view makeToast:@"数据更新成功"];
         }
     } failureBlock:^(NSString *error)
     {
         [self.view makeToast:@"数据请求失败！"];
     }];

    
}
#pragma mark -表格的所有操作

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      return self.vehicleArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString * cellID = @"vehicleCell";

        VehicleTableViewCell * vehicleCell;

        if (vehicleCell == nil)
        {
            if (iPhone6)
            {
                [tableView registerNib:[UINib nibWithNibName:@"VehicleTableViewCell@375" bundle:nil] forCellReuseIdentifier:cellID];
            }
            else if(iPhone6plus)
            {
                [tableView registerNib:[UINib nibWithNibName:@"VehicleTableViewCell@414" bundle:nil] forCellReuseIdentifier:cellID];
            }
            else
            {
                [tableView registerNib:[UINib nibWithNibName:@"VehicleTableViewCell@320" bundle:nil] forCellReuseIdentifier:cellID];
            }
            
            vehicleCell = [tableView dequeueReusableCellWithIdentifier:cellID];
            VehicleDetailInfo * vehicleInfo = [[VehicleDetailInfo alloc]initWithDict:self.vehicleArray[indexPath.row]];

            vehicleCell = [vehicleCell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID content:vehicleInfo andIndexPath:indexPath andVehicleEnter:self.vehicleEnter];
            vehicleCell.delegate = self;
        }
        return vehicleCell;

}

#pragma mark - 点击确认进场delegate
-(void)operateBtnClickDelegate:(NSInteger)row
{
    VehicleDetailInfo * vehicleInfo = [[VehicleDetailInfo alloc]initWithDict:self.vehicleArray[row]];
    self.carID = vehicleInfo.id;
    
    NSString * message = [NSString stringWithFormat:@"车牌号：%@\n司机：%@",vehicleInfo.carNo,vehicleInfo.driverName];
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认进场", nil];
    [alert show];
    //上传服务器并且刷新数据
    
}
#pragma mark -UIALERTVIEW  DELEGATE 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    if(buttonIndex ==0)
    {
        
    }
    else
    {
        //上传服务器
        NSString * urlStr = [NSString stringWithFormat:@"%@?id=%@",GET_CARENTER_URL,self.carID];
        [[AllRequest sharedManager]serverRequest:nil url:urlStr byWay:@"GET" successBlock:^(id responseBody) {
            
            NSDictionary * dic = responseBody;
            if ([[dic objectForKey:@"rc"]intValue]==0)//更新成功
            {
                [self.view makeToast:@"更新成功"];
                [self getVehicleInfo:self.vehicleEnter];//vehicleEnter初始值为NO

            }
            else
            {
                [self.view makeToast:@"更新失败"];
            }
        } failureBlock:^(NSString *error)
        {
            [self.view makeToast:@"服务器请求失败"];
        }];
    }
}

#pragma mark -点击cell拨打电话
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    VehicleDetailInfo * vehicleInfo = [[VehicleDetailInfo alloc]initWithDict:self.vehicleArray[indexPath.row]];

    NSString *phoneNum = vehicleInfo.mobile;// 电话号码
    
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",phoneNum]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

#pragma mark -小码哥刷新
- (void)example01
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.vehicleTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
}
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    
    [self getVehicleInfo:self.vehicleEnter];//vehicleEnter初始值为NO
    // 拿到当前的下拉刷新控件，结束刷新状态
//    [self.vehicleTableView.header endRefreshing];
}
#pragma mark - 表格数据为空实现的代理
//表格无数据案例datasourse  delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
//    if (iPhone5||iphone4||iPhone6)
//    {
//        return [UIImage imageNamed:@"no_notes_320"];
//    }
    return [UIImage imageNamed:@"no_notes"];
    
}
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSString *text = @"Please Allow Photo Access";
//    
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
//                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
//    
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}
//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSString *text = @"This allows you to share photos from your library and save photos to your camera roll.";
//    
//    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentCenter;
//    
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
//                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
//                                 NSParagraphStyleAttributeName: paragraph};
//    
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}
//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
//{
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
//    
//    return [[NSAttributedString alloc] initWithString:@"Continue" attributes:attributes];
//}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"button_image"];
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView
{
    return YES;
}
//- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView
//{
//    // Do something
//}
//- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView
//{
//    // Do something
//}

@end
