//
//  ViewController.m
//  vehicle
//
//  Created by Mac OS on 15/7/30.
//  Copyright (c) 2015年 Mac OS. All rights reserved.
//

#import "ViewController.h"
#import "submitViewController.h"
#import "HomeViewController.h"
#import "selfCheckInViewController.h"
#import "BaseClass.h"
#import "JudgeNewVersion.h"
#import "HRtabBarController.h"
//#import "CockpitViewController.h"
@interface ViewController ()<UIAlertViewDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"登录";
    _lineImageView.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    _pwTextField.secureTextEntry = YES;
    //设置navigationbar的背景颜色，或者图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top"] forBarMetrics:UIBarMetricsDefault];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil  action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    //tabbat items的字体以及颜色
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"修改密码" style:UIBarButtonItemStyleDone target:self action:@selector(changeBtn)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    //tabbar的title字体颜色
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    self.loginTextField.backgroundColor = [UIColor colorWithHexString:@"#ed6900"];
     [self showCarNumber];

    
//    检查版本是否需要更新
    [self checkVersion];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText = @"正在检查版本...";

    
    
    
    
//    NSString *stringUrl = [NSString stringWithFormat:@"http://scp.sto.cn/sto_cp/WapAssetsgetAllinfo.action"];
//    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"gdg",@"provincename",@"sda",@"sign", nil];
//    
//    [[AllRequest sharedManager]serverRequest:dic url:stringUrl byWay:@"POST" successBlock:^(id responseBody) {
//        
//        NSDictionary *dict = responseBody;
//        NSLog(@"%@ ",dict);
//        
//    } failureBlock:^(NSString *error) {
//        
//    }];

}
#pragma mark - 检查版本是否需要更新
-(void)checkVersion
{
    //    检查版本的请求
    NSString *urlString =CHECK_SYS_URL;

    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[AllRequest sharedManager]serverRequest:nil url:urlString byWay:@"GET" successBlock:^(id responseBody)
    {

        NSDictionary *dic = responseBody;
        if ([[dic objectForKey:@"rc"]intValue] == 0)
        {
            NSDictionary * versionDic = [dic objectForKey:@"data"];
            updateUrlStr = [versionDic objectForKey:@"path"];
            
            if ([[versionDic objectForKey:@"validStatus"]intValue] == 0)//当前版本不可用
            {
                [self.view makeToast:@"版本不可用，进入更新页面..."];
                APPDELEGATE.usable = NO;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                NSString * trackViewUrl = @"http://fir.im/mvla";
                UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.frame];
                [APPDELEGATE.window addSubview:webView];
                NSURLRequest * req = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:trackViewUrl]];
                [webView loadRequest:req];
                self.navigationItem.rightBarButtonItem = nil;
                self.title = @"更新版本";
                self.loginTextField.backgroundColor = [UIColor grayColor];
            }
            else//当前版本可用
            {
                APPDELEGATE.usable = YES;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [[JudgeNewVersion Instance] judgeShouldLoadNewVersion:YES andNewVersion:[versionDic objectForKey:@"versionNo"]];
                self.loginTextField.backgroundColor = [UIColor colorWithHexString:@"#ed6900"];

            }
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Tip" message:@"服务器返回数据错误 " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
        
    } failureBlock:^(NSString *error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"检查版本接口服务器异常" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }];

}
#pragma mark - alert代理方法(版本更新执行方法)
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:updateUrlStr]];
}

- (UIColor *)getColor:(NSString*)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
}

-(void)saveCarNum:(NSString *)carNum
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:self.carTextField.text forKey:@"carLabel"];
    [userDef synchronize];
    
}
- (void)showCarNumber
{
    NSUserDefaults * userDef = [NSUserDefaults standardUserDefaults];
    NSString * carNumber = [userDef objectForKey:@"carLabel"];
    if (![carNumber isEqualToString:@""])
    {
        self.carTextField.text = carNumber;
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)changeBtn
{
    submitViewController * submitVC = [[submitViewController alloc] init];
    [self.navigationController pushViewController:submitVC animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtn:(id)sender
{
    
//    //驾驶舱开发入口
//    CockpitViewController * cockVC = [[CockpitViewController alloc]init];
//    [self.navigationController pushViewController:cockVC animated:YES];
//    
//
    
    
    
    [self.view endEditing:YES];
    if (!APPDELEGATE.usable)
    {
        [self.view makeToast:@"服务器不通......"];
        return;
    }
     [self saveCarNum:self.carTextField.text];

    if ([_carTextField.text isEqualToString:@""])
    {
        UIAlertView * alterView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"车牌号不能为空" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alterView show];
    }
    else
    {
        selfCheckInViewController * checkVC = [[selfCheckInViewController alloc] init];
        [self.navigationController pushViewController:checkVC animated:YES];
        checkVC.carNo = _carTextField.text;
        
        //用户登录请求
        if (![self checkAll])
        {
            return;
        }
        NSString * stringUrl = [NSString stringWithFormat:@"%@loginName=%@&password=%@",GET_USERS_LOGIN_URL,self.carTextField.text,self.pwTextField.text];
        stringUrl = [stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[AllRequest sharedManager]serverRequest:nil url:stringUrl byWay:@"GET" successBlock:^(id responseBody) {
            NSDictionary * dic = responseBody;
            if ([[dic objectForKey:@"rc"]intValue] ==0)
            {
                HRtabBarController * tab = [[HRtabBarController alloc]init];
                APPDELEGATE.roleArr = [dic objectForKey:@"data"];
                [self presentViewController:tab animated:YES completion:nil];
                
            }
            else
            {
                [self.view makeToast:[dic objectForKey:@"msg"]];
            }
            
        } failureBlock:^(NSString *error) {
            
        }];
            }
    
}
-(BOOL)checkAll
{
    if (self.carTextField.text.length==0||self.pwTextField.text.length==0||[self.carTextField.text containsString:@" "])
    {
        [self.view makeToast:@"请正确填写相关信息"];
        return NO;
    }
    return YES;
}

@end
