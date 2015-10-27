//
//  EffectiveManagerViewController.m
//  vehicle
//
//  Created by Mac on 15/10/19.
//  Copyright © 2015年 Mac OS. All rights reserved.
//

#import "EffectiveManagerViewController.h"
#import "EffectiveManagerTableViewCell.h"
#import "MXPullDownMenu.h"
@interface EffectiveManagerViewController ()<UITableViewDelegate,UITableViewDataSource,MXPullDownMenuDelegate>

@end

@implementation EffectiveManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"时效管理";
    
    // UINavigationBar添加右侧按钮图片
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"1fyg45454r67444"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    //segement
    self.mySegment.tintColor = [UIColor colorWithHexString:@"#ed6900"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor  colorWithHexString:@"#ed6900"],NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName ,nil];
    [self.mySegment setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    //添加选择菜单
    NSArray *testArray;
    testArray = @[ @[ @"华东区", @"华南区", @"华北区", @"华西区" , @"东北区" , @"西北区" ]];
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor greenColor]];
    menu.delegate = self;
    menu.frame = CGRectMake(0, CGRectGetMaxY(self.mySegment.frame)+8, menu.frame.size.width, menu.frame.size.height);
    [self.view addSubview:menu];
//   添加时间按钮
    UIButton * timeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    timeBtn.frame = CGRectMake(140, CGRectGetMinY(menu.frame)+3, 100, 30);
    [timeBtn setTitle:@"2015-10-26" forState:UIControlStateNormal];
    [timeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [timeBtn addTarget:self action:@selector(timeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeBtn];
    
    //添加刷新按钮控件
    UIButton * refreshBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    refreshBtn.frame = CGRectMake(SCREEN_WIDTH-36-8, CGRectGetMinY(menu.frame)+5, 26, 26);
    [refreshBtn setBackgroundImage:[UIImage imageNamed:@"btn_update"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBtn];
    

}
#pragma mark --- UITableViewDelegate ------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * identifier = @"cell";
    EffectiveManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EffectiveManagerTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}
// 实现代理.
#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    
}
//刷新按钮
- (void)refreshBtnClick
{
    
}
//UINavigationBar添加右侧按钮
- (void)clickRightButton
{
    
}
//时间按钮
- (void)timeBtn
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
