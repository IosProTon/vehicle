//
//  HRNavigationController.m
//  Hire
//
//  Created by Wangchengshan on 15/4/12.
//  Copyright (c) 2015年 Wangchengshan. All rights reserved.
//

#import "HRNavigationController.h"

@interface HRNavigationController ()

@end

@implementation HRNavigationController
/**
 15  *第一次调用类的时候会调用一次该方法
 16  */
+(void)initialize
{
    //设置UIBarButtonItem的主题
//    [self setupBarButtonItemTheme];
    
    //设置UINavigationBar的主题
    [self setupNavigationBarTheme];

}

/**
 27  *设置UINavigationBar的主题
 28  */
+ (void)setupNavigationBarTheme
{
    //通过设置appearance对象，能够修改整个项目中所有UINavigationBar的样式
    UINavigationBar *appearance=[UINavigationBar appearance];
    appearance.tintColor = [UIColor whiteColor];//设置返回键颜色
      //设置文字属性
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    //设置字体颜色
    textAttrs[NSForegroundColorAttributeName]=[UIColor whiteColor];
    //设置字体
    textAttrs[NSFontAttributeName]=[UIFont boldSystemFontOfSize:17.0];
    //设置字体的偏移量（0）
    //说明：UIOffsetZero是结构体，只有包装成NSValue对象才能放进字典中
    //     textAttrs[NSShadowAttributeName]=[NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs];
    [appearance setBarTintColor:[UIColor colorWithHexString:@"#ed6900"]];
    appearance.translucent = NO;
}

/**
 *设置UIBarButtonItem的主题
 */
//+ (void)setupBarButtonItemTheme
// {
//     //通过设置appearance对象，能够修改整个项目中所有UIBarButtonItem的样式
//     UIBarButtonItem *appearance=[UIBarButtonItem appearance];
//     UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil  action:nil];
//     appearance = item;
//     //设置文字的属性
//     //1.设置普通状态下文字的属性
//     NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
//     //设置字体
//     textAttrs[UITextAttributeFont]=[UIFont systemFontOfSize:15];
//     //这是偏移量为0
//     textAttrs[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
//     //设置颜色为橙色
//     textAttrs[UITextAttributeTextColor]=[UIColor blackColor];
//     [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//
//     //2.设置高亮状态下文字的属性
//     //使用1中的textAttrs进行通用设置
//     NSMutableDictionary *hightextAttrs=[NSMutableDictionary dictionaryWithDictionary:textAttrs];
//     //设置颜色为红色
//     hightextAttrs[UITextAttributeTextColor]=[UIColor redColor];
//     [appearance setTitleTextAttributes:hightextAttrs forState:UIControlStateHighlighted];
//
//     //3.设置不可用状态下文字的属性
//     //使用1中的textAttrs进行通用设置
//     NSMutableDictionary *disabletextAttrs=[NSMutableDictionary dictionaryWithDictionary:textAttrs];
//    //设置颜色为灰色
//     disabletextAttrs[UITextAttributeTextColor]=[UIColor lightGrayColor];
//     [appearance setTitleTextAttributes:disabletextAttrs forState:UIControlStateDisabled];
//
//     设置背景
//     技巧提示：为了让某个按钮的背景消失，可以设置一张完全透明的背景图片
//     [appearance setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"]forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//     }

/**
 *  当导航控制器的view创建完毕就调用
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

}

/**
 *  能够拦截所有push进来的子控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果现在push的不是栈顶控制器，那么久隐藏tabbar工具条
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed=YES;
        
        //拦截push操作，设置导航栏的左上角和右上角按钮
        //     viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        //     viewController.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithImageName:@"navigationbar_more" highImageName:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    [super pushViewController:viewController animated:YES];
}

//-(void)back
//{
// #warning 这里用的是self, 因为self就是当前正在使用的导航控制器
//     [self popViewControllerAnimated:YES];
//}
//
//-(void)more
//{
// [self popToRootViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
