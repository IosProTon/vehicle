//
//  AreaSiteSelectViewController.m
//  vehicle
//
//  Created by Mac on 15/10/10.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import "AreaSiteSelectViewController.h"
#import "CarCountViewController.h"
@interface AreaSiteSelectViewController ()
{
    NSString * requestStr;
}
@end

@implementation AreaSiteSelectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.areaArray==nil)
    {
        self.areaArray = [[NSMutableArray alloc]init];
    }
    if (self.areaNumArr==nil) {
        self.areaNumArr = [[NSMutableArray alloc]init];
    }
    //2==大区 3==站点
    if (self.siteSelect)
    {
        
    }
    else
    {
    requestStr = [NSString stringWithFormat:@"%@level=%@",GET_AREALIST_URL,@"2"];
    [[AllRequest sharedManager]serverRequest:nil url:requestStr byWay:@"GET" successBlock:^(id responseBody)
    {
        NSDictionary * dic = (NSDictionary*)responseBody;
        if ([[dic objectForKey:@"rc"] intValue]==0)
        {
            NSArray * arr = [dic objectForKey:@"data"];
            for (int i=0; i<arr.count; i++)
            {
                //存储所有地区名和所有地区编号
                NSDictionary * dic2 = arr[i];
                [self.areaArray addObject:[dic2 objectForKey:@"name"]];
                [self.areaNumArr addObject:[dic2 objectForKey:@"no"]];
            }
        }
//        NSLog(@"所有的地区名为%@",self.areaArray);
//        NSDictionary * dic32 =[NSDictionary dictionaryWithObjects:self.areaNumArr forKeys:self.areaArray];
//        NSLog(@"%@",dic32);
        [self.areaTableView reloadData];
    }
    failureBlock:^(NSString *error)
    {
        [self.view makeToast:@"数据请求失败"];
    }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview的所有操作
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.areaArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = self.areaArray[indexPath.row];
    cell.detailTextLabel.text = self.areaNumArr[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.statusStr.intValue == 2)//选择大区页面
    {
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate AreaQuery:self.areaNumArr[indexPath.row]withAreaStr:self.areaArray[indexPath.row]andStatus:@"2"];
    }
    else if(self.statusStr.intValue == 3)//选择大区下面的站点
    {
        
        AreaSiteSelectViewController * areaSiteVC = [[AreaSiteSelectViewController alloc]init];
        areaSiteVC.delegate = self.delegate;
        areaSiteVC.title = @"选择站点";
        areaSiteVC.areaArray = [[NSMutableArray alloc]init];
        areaSiteVC.areaNumArr = [[NSMutableArray alloc]init];
        //请求服务器获取站点列表
        requestStr = [NSString stringWithFormat:@"%@level=%@&area_no=%@",GET_AREALIST_URL,@"3",self.areaNumArr[indexPath.row]];
        [[AllRequest sharedManager]serverRequest:nil url:requestStr byWay:@"GET" successBlock:^(id responseBody)
         {
             NSDictionary * dic = (NSDictionary*)responseBody;
             if ([[dic objectForKey:@"rc"] intValue]==0)
             {
                 NSArray * arr = [dic objectForKey:@"data"];
                 for (int i=0; i<arr.count; i++)
                 {
                     //存储所有地区名和所有地区编号
                     NSDictionary * dic2 = arr[i];
                     [areaSiteVC.areaArray addObject:[dic2 objectForKey:@"name"]];
                     [areaSiteVC.areaNumArr addObject:[dic2 objectForKey:@"no"]];
                 }
                 areaSiteVC.siteSelect = YES;
                 [self.navigationController pushViewController:areaSiteVC animated:YES];
                 [areaSiteVC.areaTableView reloadData];
             }
             else//数据返回错误
             {
                 areaSiteVC.areaArray = [[NSMutableArray alloc]init];
                 [areaSiteVC.areaTableView reloadData];
                 [self.view makeToast:@"无数据返回"];
             }
                }
        failureBlock:^(NSString *error)
         {
             [self.view makeToast:@"数据请求失败"];
         }];

    }
    else//选择站点并返回页面查询
    {
        NSArray * arrVC = self.navigationController.viewControllers;
        CarCountViewController*carCountView = [[CarCountViewController alloc]init];
        for (UIViewController * vc in arrVC) {
            if ([vc isKindOfClass:[carCountView class]]) {
                carCountView = (CarCountViewController*)vc;
                break;
            }
        }

        [self.navigationController popToViewController:carCountView animated:YES];
        [self.delegate AreaQuery:self.areaNumArr[indexPath.row]withAreaStr:self.areaArray[indexPath.row]andStatus:@"3"];

    }
}
@end
