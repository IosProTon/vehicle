//
//  submitViewController.m
//  StoVehicleSignedIos
//
//  Created by Mac OS on 15/7/29.
//  Copyright (c) 2015年 Mac OS. All rights reserved.
//

#import "submitViewController.h"
#import "ViewController.h"
@interface submitViewController ()<UITextFieldDelegate>

@end

@implementation submitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"修改密码";
    _carLineImageView.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    _pswLineImageView.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    _newsPswLineImageView.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //设置按钮边框
    self.submitBtn.layer.cornerRadius = 4;
    [self.submitBtn setBackgroundColor:[UIColor colorWithHexString:@"#ed6900"]];

    self.pswTF.secureTextEntry = YES;
    self.newsPswTF.secureTextEntry = YES;
    
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

- (IBAction)submitBtn:(id)sender
{
    if (![self checkAll])
    {
        return;
    }
    NSString * stringUrl = [NSString stringWithFormat:@"%@?loginName=%@&oldPassword=%@&newPassword=%@",GET_CARENTER_URL,self.carNumTF.text,self.pswTF.text,self.newsPswTF.text];
   

    [[AllRequest sharedManager]serverRequest:nil url:stringUrl byWay:@"GET" successBlock:^(id responseBody) {
        NSDictionary * dict = responseBody;
        if ([[dict objectForKey:@"rc"] intValue] ==0)
        {
//            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"修改密码成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alertView show];
            ViewController * VC = [[ViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }
        else
        {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"修改密码失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    } failureBlock:^(NSString *error)
    {
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器异常，请稍候再试" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }];
}
-(BOOL)checkAll
{
    if (self.carNumTF.text.length==0||self.pswTF.text.length==0||self.newsPswTF.text.length==0)
    {
        [self.view makeToast:@"请正确填写相关信息"];
        return NO;
    }
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1001)
    {
        [self.pswTF becomeFirstResponder];
        return YES;
    }
    else if(textField.tag == 1002)
    {
        [self.newsPswTF becomeFirstResponder];
        return YES;
    }
    [self submitBtn:nil];
    return YES;
}
@end
