//
//  HomeViewController.m
//  AutoSlideScrollViewDemo
//
//  Created by Mike Chen on 14-1-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "HRFunctionBtn.h"
#import "selfCheckInViewController.h"
#import "CarCountViewController.h"
#import "CarManagerViewController.h"
#import "CockpitViewController.h"
@interface HomeViewController ()
{
    NSDictionary * roleDic;//记录角色id对应functionLoginName1
    
    //公告
    UIView * labelView ;
    UILabel* label;
    NSString * tipContents;
}

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",APPDELEGATE.roleArr);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil  action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    //初始化页面
    [self initMainView:APPDELEGATE.roleArr.count];
    
    
    
}

#pragma mark - 构建广告滚动视图
- (void)createScrollView
{
    myScrollView = [[AdScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)];
    AdDataModel * dataModel = [AdDataModel adDataModelWithImageNameAndAdTitleArray];
    //如果滚动视图的父视图由导航控制器控制,必须要设置该属性(ps,猜测这是为了正常显示,导航控制器内部设置了UIEdgeInsetsMake(64, 0, 0, 0))
//    my    ScrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    NSLog(@"%@",dataModel.adTitleArray);
    myScrollView.imageNameArray = dataModel.imageNameArray;
    myScrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    myScrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    [myScrollView setAdTitleArray:dataModel.adTitleArray withShowStyle:AdTitleShowStyleLeft];
    
    myScrollView.pageControl.currentPageIndicatorTintColor =[UIColor colorWithHexString:@"#ed6900"];
    [self.view addSubview:myScrollView];
}

-(void)initMainView:(NSInteger)functionCount
{
    //scrollview
    [self createScrollView];
    //功能按钮,默认为三个功能模块
    NSMutableArray * functionNameArray = [[NSMutableArray alloc]init];//存储所有功能模块的名字
    NSMutableArray * functionName1 = [[NSMutableArray alloc]init];//存储角色应该携带过去的信息
    NSMutableArray * functionID = [[NSMutableArray alloc]init];//所有功能模块的id编号
    for (int p=0; p<APPDELEGATE.roleArr.count; p++) {
        [functionName1 addObject:[APPDELEGATE.roleArr[p] objectForKey:@"functionLoginName1"]];
        [functionNameArray addObject:[APPDELEGATE.roleArr[p] objectForKey:@"functionName"]];
        [functionID addObject:[APPDELEGATE.roleArr[p]objectForKey:@"functionId"]];
    }
    roleDic = [NSDictionary dictionaryWithObjects:functionName1 forKeys:functionID];
    for (int i =0; i<functionCount; i++) {
        HRFunctionBtn * btn = [[HRFunctionBtn alloc]init];
        CGFloat width = SCREEN_WIDTH/3;//正方形宽度为屏幕宽的三分之一
        int originY = i/3;
        btn.frame = CGRectMake((i%3)*width, CGRectGetMaxY(myScrollView.frame)+width*originY, width, width);
        btn.tag = [functionID[i] integerValue]-1;
        
        [btn initWithImage:[functionID[i] intValue]];
        
        [btn initWithTitle:functionNameArray[i]];

        [btn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
#pragma mark - 公告方法
-(void)noticeFunction:(NSString *)content
{
    //    获取字符串的size
    UIFont* font = [UIFont systemFontOfSize:15];
    
    //    1.字符串对象通过 sizeWithFont:方法传递一个font对象，获得到字符串的size
    //    CGSize size = [content sizeWithFont:font];
    //     'sizeWithFont:' is deprecated(弃用): first deprecated in iOS 7.0 - Use -sizeWithAttributes:
    
    //    2.IOS7.0之后使用的方法:
    //    字符串对象通过sizeWithAttributes：方法传递一个字典对象（字典对象由一个键值对组成，键值对的键(key)和值(value)通过:隔开）
    //    key:NSFontAttributeName
    //    value:一个font对象
    CGSize size = [content sizeWithAttributes:@{NSFontAttributeName: font}];
    
    CGFloat w = size.width;
    
    
    //    1.公告标签
    if (labelView==nil)
    {
        labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 30)];
        [self.view addSubview:labelView];

    }
    labelView.alpha = .5;
    labelView.backgroundColor = [UIColor grayColor];
    
    if (label==nil)
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, w, 30 )];
        [self.view addSubview:label];
    }
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    if (content.length == 0)
    {
        content = @"r公告";
    }
    label.text = content;
    label.font = font;
    
    //    CGRect (CGPoint,CGSize)
    
    
    //    2.做动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:10.0];
    
    
    //  设置动画的自动反转
    [UIView setAnimationRepeatAutoreverses:NO];
    //    设置动画的重复次数:默认为0:代表1次，无限次 LONG_MAX
    [UIView setAnimationRepeatCount:LONG_MAX];
    

    //    设置动画的运动速率
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    
    //
    //     UIViewAnimationCurveEaseInOut,开始、结束时慢
    //     UIViewAnimationCurveEaseIn,开始时慢     UIViewAnimationCurveEaseOut,结束时慢     UIViewAnimationCurveLinear 匀速
    
    
    //    动画的目标代码
    //    label.frame = CGRectMake(320, 50, 100, 40);
    //    深度赋值
    //    label.frame.origin.x = 320;
    
    //    定义一个中间变量
    CGRect rect = label.frame;
    //    改变中间变量的x坐标
    rect.origin.x = -(SCREEN_WIDTH*3);
    //    将中间变量重新赋值给label
    label.frame = rect;
    
    [UIView commitAnimations];
    

}
#pragma mark - 功能按钮点击事件
-(void)functionBtnClick:(id)sender
{
    UIButton * btn = (UIButton*)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
        case 0://签到系统
        {
            selfCheckInViewController * checkVC = [[selfCheckInViewController alloc] init];
//            NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//            NSString * str = [userDef objectForKey:@"carLabel"];
            checkVC.carNo = [roleDic objectForKey:@"1"];

            [self.navigationController pushViewController:checkVC animated:YES];
        }
            break;
        case 1://车辆管理系统
        {
            CarManagerViewController * carManagerVC = [[CarManagerViewController alloc]initWithNibName:@"CarManagerViewController" bundle:[NSBundle mainBundle]];
            carManagerVC.site_Search_No = [roleDic objectForKey:@"2"];
            [self.navigationController pushViewController:carManagerVC animated:YES];
        }
            break;
        case 2://全国车辆查询功能
        {
            CarCountViewController * carCountVC = [[CarCountViewController alloc]initWithNibName:@"CarCountViewController" bundle:[NSBundle mainBundle]];
            carCountVC.title = @"全国车辆统计";
            [self.navigationController pushViewController:carCountVC animated:YES];
        }
            break;
        case 3://驾驶舱功能
        {
            CockpitViewController * cockpitVC = [[CockpitViewController alloc]initWithNibName:@"CockpitViewController" bundle:[NSBundle mainBundle]];
            cockpitVC.title = @"驾驶舱";
            [self.navigationController pushViewController:cockpitVC animated:YES];
        }
            break;
        default:
            break;
    }
}
//解决重影部分tabbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBarController.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    
    //获取公告
    [[AllRequest sharedManager]serverRequest:nil url:GET_NOTICE_URL byWay:@"GET" successBlock:^(id responseBody) {
        NSDictionary *dic = responseBody;
        if ([[dic objectForKey:@"rc"]intValue] == 0)
        {
            NSDictionary * versionDic = [dic objectForKey:@"data"];
            tipContents = [versionDic objectForKey:@"content"];
            [self noticeFunction:tipContents];
        }
        
        
    } failureBlock:^(NSString *error) {
        NSLog(@"请求失败");
        
    }];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
