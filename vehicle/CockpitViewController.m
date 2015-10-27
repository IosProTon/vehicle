


//
//  CockpitViewController.m
//  vehicle
//
//  Created by Mac on 15/10/19.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import "CockpitViewController.h"
#import "CockpitTableViewCell.h"
#import "ListInfoModel.h"
#import "UIScrollView+EmptyDataSet.h"
#import "EffectiveManagerViewController.h"
#import "NationalAssetsViewController.h"
#import "NetworkAssetsViewController.h"
#import "NetworkVolumeViewController.h"
#import "TransportCenterViewController.h"
@interface CockpitViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CockpitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil  action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    NSDictionary * listInfoDic0 = [NSDictionary dictionaryWithObjectsAndKeys:@"全国资产",@"title",@"包含网点数量、车辆、巴枪、场地等数据",@"detailTitle",@"img_nation",@"headImage",nil];
    NSDictionary * listInfoDic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"网点资产",@"title",@"包含基本信息、业务统计、门店等数据",@"detailTitle",@"img_networkass",@"headImage",nil];
    NSDictionary * listInfoDic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"网点业务量",@"title",@"包含发件量、收件、巴枪、场地等数据",@"detailTitle",@"img_networkbas",@"headImage",nil];
    NSDictionary * listInfoDic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"转运中心量",@"title",@"包含发件量、收件、巴枪、场地等数据",@"detailTitle",@"img_hub",@"headImage",nil];
    NSDictionary * listInfoDic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"实效管理",@"title",@"包含到件时效、签收时效等数据",@"detailTitle",@"img_aging",@"headImage",nil];

    if (self.listInfoArr == nil)
    {
        self.listInfoArr = [[NSMutableArray alloc]init];
    }
    [self.listInfoArr addObject:listInfoDic0];
    [self.listInfoArr addObject:listInfoDic1];
    [self.listInfoArr addObject:listInfoDic2];
    [self.listInfoArr addObject:listInfoDic3];
    [self.listInfoArr addObject:listInfoDic4];
// UINavigationBar添加右侧按钮图片
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"1fyg45454r67444"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
  
//调用隐藏多余的分割线方法
     [self setExtraCellLineHidden:_myTableView];
}
- (void)clickRightButton
{
    
}
#pragma mark -----tableView隐藏多余的分割线方法
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
//好像这还不够，如果TableView没有数据时，会出问题，所以要在
//-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//判断dataSouce的数据个数
//如果为零可以将_detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone
//然后在大于零时将其设置为
//_detailTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.1;
//}
#pragma mark -----tableView的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (/* DISABLES CODE */ (0))
    {
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    return self.listInfoArr.count;
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    CockpitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CockpitTableViewCell" owner:nil options:nil]lastObject];
    }
    ListInfoModel * listInfo = [[ListInfoModel alloc]initWithDict:self.listInfoArr[indexPath.row]];
    [cell receiveModel:listInfo];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
#pragma mark ----tableView的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            NationalAssetsViewController * nationalVC = [[NationalAssetsViewController alloc]init];
            [self.navigationController pushViewController:nationalVC animated:YES];
        }
            break;
        case 1:
        {
            NetworkAssetsViewController * networkVC = [[NetworkAssetsViewController alloc]init];
            [self.navigationController pushViewController:networkVC animated:YES];
        }
            break;
        case 2:
        {
            NetworkVolumeViewController * netVolumeVC = [[NetworkVolumeViewController alloc]init];
            [self.navigationController pushViewController:netVolumeVC animated:YES];
        }
            break;
        case 3:
        {
            TransportCenterViewController * transportVC = [[TransportCenterViewController alloc]init];
            [self.navigationController pushViewController:transportVC animated:YES];
        }
            break;
        case 4:
        {
            EffectiveManagerViewController * effectiveVC = [[EffectiveManagerViewController alloc]init];
            [self.navigationController pushViewController:effectiveVC animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addCategory:(id)sender
{
//    EffectiveManagerViewController * effectiveVC = [[EffectiveManagerViewController alloc]init];
//    [self.navigationController pushViewController:effectiveVC animated:YES];
    
}
@end
