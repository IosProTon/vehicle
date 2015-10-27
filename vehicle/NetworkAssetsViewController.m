//
//  NetworkAssetsViewController.m
//  vehicle
//
//  Created by Mac on 15/10/20.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import "NetworkAssetsViewController.h"
#import "MXPullDownMenu.h"
#import "NetworkAssetsTableViewCell.h"
#import "NetWorkAssetsInfoModel.h"
@interface NetworkAssetsViewController ()<MXPullDownMenuDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation NetworkAssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网点资产";
    
    // UINavigationBar添加右侧按钮图片
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"1fyg45454r67444"] style:UIBarButtonItemStylePlain target:self action:@selector(AddclickRightButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    //添加选择菜单
    NSArray *testArray;
    testArray = @[ @[ @"华东区", @"华南区", @"华北区", @"华西区" , @"东北区" , @"西北区" ]];
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor greenColor]];
    menu.delegate = self;
    menu.frame = CGRectMake(0,10, menu.frame.size.width, menu.frame.size.height);
    [self.view addSubview:menu];
    
//    //添加按钮
//    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//     addBtn .frame = CGRectMake(menu.frame.size.width+10, 10, 26, 26);
//    [ addBtn  setBackgroundImage:[UIImage imageNamed:@"btn_attention"] forState:UIControlStateNormal];
//    [ addBtn  addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview: addBtn ];

    
    //添加刷新按钮控件
    UIButton * refreshBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    refreshBtn.frame = CGRectMake(SCREEN_WIDTH-36-8, CGRectGetMinY(menu.frame)+5, 26, 26);
    [refreshBtn setBackgroundImage:[UIImage imageNamed:@"btn_update"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBtn];
    
    //表
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 36, SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(menu.frame)-64) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
//    myTableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:myTableView];
    
    NSDictionary * dict0 = [NSDictionary dictionaryWithObjectsAndKeys:@"基本信息",@"leftTitle",@"法人：",@"title",@"电话：",@"detailTitle",@"img_info",@"headImage", nil];
    NSDictionary * dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"业务统计",@"leftTitle",@"发件量：",@"title",@"到件量：",@"detailTitle",@"img_yewu",@"headImage", nil];
NSDictionary * dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"人力资源",@"leftTitle",@"人员总数：",@"title",@"平均年龄：",@"detailTitle",@"img_renli",@"headImage", nil];
    NSDictionary * dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"投入金额",@"leftTitle",@"场地投入：",@"title",@"设备投入：",@"detailTitle",@"img_touru",@"headImage", nil];
    NSDictionary * dict4 = [NSDictionary dictionaryWithObjectsAndKeys:@"固定资产",@"leftTitle",@"硬件：",@"title",@"车辆总数：",@"detailTitle",@"img_guding",@"headImage", nil];
    NSDictionary * dict5 = [NSDictionary dictionaryWithObjectsAndKeys:@"门店信息",@"leftTitle",@"门店数：",@"title",@"承包区：",@"detailTitle",@"img_mendian",@"headImage", nil];
    if (self.netWorkAssetsInfoArr == nil)
    {
        self.netWorkAssetsInfoArr = [[NSMutableArray alloc]init];
    }
    [self.netWorkAssetsInfoArr addObject:dict0 ];
    [self.netWorkAssetsInfoArr addObject:dict1];
    [self.netWorkAssetsInfoArr addObject:dict2];
    [self.netWorkAssetsInfoArr addObject:dict3];
    [self.netWorkAssetsInfoArr addObject:dict4];
    [self.netWorkAssetsInfoArr addObject:dict5];
    //调用隐藏多余的分割线方法
    [self setExtraCellLineHidden:myTableView];

}
#pragma mark ---UITableView操作---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (/* DISABLES CODE */ (0))
    {
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
        myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return self.netWorkAssetsInfoArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    NetworkAssetsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NetworkAssetsTableViewCell" owner:nil options:nil]lastObject];
    }
   NetWorkAssetsInfoModel * workInfo = [[NetWorkAssetsInfoModel alloc]initWithDict:self.netWorkAssetsInfoArr[indexPath.row]];
    [cell receiveModel:workInfo];
    
    return cell;
}
#pragma mark -----tableView隐藏多余的分割线方法
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

// 实现刷新代理.
#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    
}

- (void)AddclickRightButton
{
    
}
////添加按钮
//- (void)addBtnClick
//{
//    
//}
- (void)refreshBtnClick
{
    
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

@end
