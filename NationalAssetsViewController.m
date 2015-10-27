//
//  NationalAssetsViewController.m
//  全国资产页面
//
//  Created by ProTon on 15/10/19.
//  Copyright © 2015年 ton. All rights reserved.
//
#import "NationalAssetsViewController.h"
#import "HRListBtn.h"
#import "NationalAssetsModel.h"
@interface NationalAssetsViewController ()

@end

@implementation NationalAssetsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title =@"全国资产";
    //初始化页面
    [self initMainView];
   
    //默认加载华东区当天数据
    NSDictionary * requestDic = [NSDictionary dictionaryWithObjectsAndKeys:@"03d4254294e7363b9a76ca7ef0cc2c6d",@"sign",@"",@"provincename", nil];//0空表示全国
    
    
    [[AllRequest sharedManager]serverRequest:requestDic url:POST_ALL_INFO_URL byWay:@"POST" successBlock:^(id responseBody)
     {
        NSDictionary * receiveDic = responseBody;
         NSLog(@"%@",receiveDic);
        if ([[receiveDic objectForKey:@"result"]intValue ]== 0)
        {
            NSDictionary * dataDic = [receiveDic objectForKey:@"data"];
    
            //刷新控件UI
            [self refreshView:dataDic];
        }
        
    } failureBlock:^(NSString *error)
    {
        [self.view makeToast:@"请求数据失败"];
    }];

}
-(void)initMainView
{
    //segement点击背景颜色
//    self.mySegmentControl.tintColor = [UIColor colorWithHexString:@"#ed6900"];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor  colorWithHexString:@"#ed6900"],NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName ,nil];
//    [self.mySegmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    //添加选择菜单
    NSArray *testArray;
    testArray = @[ @[ @"全国" ]];
    menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor greenColor]];
    menu.delegate = self;
    
    menu.frame = CGRectMake(0, 0, menu.frame.size.width, menu.frame.size.height);
    [self.view addSubview:menu];
    
    //添加刷新按钮控件
    UIButton * refreshBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    refreshBtn.frame = CGRectMake(SCREEN_WIDTH-36-8, CGRectGetMinY(menu.frame)+5, 26, 26);
    [refreshBtn setBackgroundImage:[UIImage imageNamed:@"btn_update"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBtn];
    
    
    //添加scrollView
    CGFloat scrollViewHeight = SCREEN_HEIGHT-64-CGRectGetMaxY(menu.frame)-8;
    if (scrollViewHeight-400>0) {
        scrollViewHeight = 400.5;
    }
    self.contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(menu.frame)+8, SCREEN_WIDTH, scrollViewHeight)];
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 400.5);
    [self.view addSubview:self.contentScrollView];
    self.contentScrollView.backgroundColor = [UIColor grayColor];
    //添加8个按钮
    NSArray * functionNameArr = [NSArray arrayWithObjects:@"网点数量",@"发件量",@"派件量",@"人员数量",@"车辆数",@"巴枪数",@"投入金额",@"场地面积", nil];
    for (int i = 0; i<8; i++)
    {
        NSLog(@"%f",0.5*pow(-1, i));
       HRListBtn * btn = [HRListBtn buttonWithType:UIButtonTypeSystem];
        btn.frame =CGRectMake((i%2)*(SCREEN_WIDTH/2)-0.25*pow(-1, i),100*(i/2)+0.5, SCREEN_WIDTH/2, 100-0.5);
        btn.tag = i+1;
        [btn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn initWithTitle:functionNameArr[i]];
        [btn initWithImage:i];
        [self.contentScrollView addSubview:btn];
    }

}

#pragma mark - 返回数据刷新控件
-(void)refreshView:(NSDictionary *)dic
{
    NSLog(@"%@",[dic objectForKey:@"sitecount"]);
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSDictionary * detailDic = [dic objectForKey:@"sumlist"][0];
    for (int i =1; i<9; i++)
    {
        HRListBtn * btn =(HRListBtn*)[self.view viewWithTag:i];
        switch (btn.tag)
        {
            case 1:    //网点数量
                btn.myCountLabel.text = [numberFormatter stringFromNumber:[dic objectForKey:@"sitecount"]];
                break;
            case 2:   //发件量
                btn.myCountLabel.text = [numberFormatter stringFromNumber:[detailDic objectForKey:@"DAYFA"]];
                break;
            case 3:   //派件量
                btn.myCountLabel.text = [numberFormatter stringFromNumber:[detailDic objectForKey:@"DAYSEND"]];
                break;
            case 4://人员数量
            {
                btn.myCountLabel.text = [numberFormatter stringFromNumber:[dic objectForKey:@"percount"]];
            }
                break;
            case 5://车辆数
            {
                btn.myCountLabel.text = [numberFormatter stringFromNumber:[dic objectForKey:@"carcount"]];
            }
                break;

            case 6://巴枪数
                btn.myCountLabel.text = [numberFormatter stringFromNumber:[dic objectForKey:@"guncount"]];
                break;
            case 7://投入金额
            {
                btn.myCountLabel.text = [numberFormatter stringFromNumber:[dic objectForKey:@"totalcount"]];
            }
                break;
            case 8: //场地面积
            {
                btn.myCountLabel.text = [numberFormatter stringFromNumber:[dic objectForKey:@"areacount"]];
            }
                break;

            default:
                break;
        }

    }
    
}

//刷新按钮
-(void)refreshBtnClick
{
    
}
//功能按钮点击事件
-(void)functionBtnClick:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 实现代理.
#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
//    NSLog(@"%d -- %d", column, row);
}
@end
