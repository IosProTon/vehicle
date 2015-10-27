//
//  selfCheckInViewController.m
//  StoVehicleSignedIos
//
//  Created by Mac OS on 15/7/30.
//  Copyright (c) 2015年 Mac OS. All rights reserved.
//
//  申通车辆签到	87669643fca14b7b5f388b5315d855c8

#import "selfCheckInViewController.h"
@interface selfCheckInViewController ()<ZBarCaptureDelegate,UIImagePickerControllerDelegate,ZBarReaderDelegate,UIAlertViewDelegate,BottomViewDelegate>

@end

@implementation selfCheckInViewController

//大头针标题和子标题自动显示
- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_mapView selectAnnotation:pointAnnotation animated:YES];//标题和子标题自动显示
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    onlyOnce = NO;
    //配置用户Key
    [MAMapServices sharedServices].apiKey = @"87669643fca14b7b5f388b5315d855c8";
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-80)];
    _mapView.userTrackingMode = MAUserTrackingModeFollow ;
    _mapView.delegate = self;
//   _mapView.showsCompass = NO;
    [_mapView selectAnnotation:pointAnnotation animated:NO];
   
//    地图定位
    locationManager =[[CLLocationManager alloc] init];
    // fix ios8 location issue
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
      #ifdef __IPHONE_8_0
        if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [locationManager performSelector:@selector(requestAlwaysAuthorization)];//用这个方法，plist中需要NSLocationAlwaysUsageDescription
        }
        
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [locationManager performSelector:@selector(requestWhenInUseAuthorization)];//用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
        }
     #endif
    }
    
    _mapView.showsUserLocation = YES;//YES 为打开定位，NO为关闭定位
  
    [_mapView setZoomLevel:15.1 animated:YES];
    
    [self.view addSubview:_mapView];
    
    self.title = @"车辆自助签到";
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"扫描" style:UIBarButtonItemStyleDone target:self action:@selector(scanBtn)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], UITextAttributeFont, [UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil  action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //BottomView的初始化
    bottomView = [[[NSBundle mainBundle]loadNibNamed:@"BottomView" owner:self options:nil]lastObject];
    bottomView.delegate = self;
    [self.view addSubview:bottomView];
    //车牌号显示
    bottomView.carLabel.text = self.carNo;
    
//       NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSLog(@"%@",paths);
//    
}
#pragma  mark - 签到按钮点击代理事件
-(void)SignBtnClick
{
    [self clickBtn];
}

#pragma mark -----定位的协议方法------
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
        self.latitude = userLocation.coordinate.latitude;
        self.longitude = userLocation.coordinate.longitude;
        if (!onlyOnce)
        {
            _mapView.showsUserLocation = NO;//YES 为打开定位，NO为关闭定位
        }

        //        根据两点坐标计算距离
        //第一个坐标
        CLLocation *current=[[CLLocation alloc] initWithLatitude:_cLat longitude:_cLon];
        //第二个坐标
        CLLocation *before=[[CLLocation alloc] initWithLatitude:_latitude longitude:_longitude];
        // 计算距离
        CLLocationDistance meters=[current distanceFromLocation:before];
        if (meters<=1000)
        {
            [bottomView.signBtn setBackgroundImage:[UIImage imageNamed:@"btn_qiandao_abled"] forState:UIControlStateNormal];
            bottomView.signBtn.userInteractionEnabled = YES;
        }
        else
        {
            [bottomView.signBtn setBackgroundImage:[UIImage imageNamed:@"btn_qiandao_disabled"] forState:UIControlStateNormal];
            bottomView.signBtn.userInteractionEnabled = NO;
        }
        NSLog(@"meters:%f",meters);

    }

}
#pragma mark - 地图停止定位时的代理方法
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView
{
    //获取最近站点 的请求
    NSString *longitude =  [NSString stringWithFormat:@"%f",_longitude];
    NSString * latitude =  [NSString stringWithFormat:@"%f",_latitude];
    NSString *getUrlString = [NSString stringWithFormat:@"%@?aLon=%@&aLat=%@",GET_SITE_URL,longitude,latitude] ;
    NSString * getEncodedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)getUrlString, NULL, NULL,  kCFStringEncodingUTF8 );
    
    //创建manager。
    AFHTTPRequestOperationManager *getVersionManager = [AFHTTPRequestOperationManager manager];
    //申明请求的数据是json类型
    getVersionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    //申明返回的结果是json类型
    getVersionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [ getVersionManager GET:getEncodedString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",operation.responseString);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        // 从字典里取出
        NSDictionary *data = [dic objectForKey:@"data"];
        self.cLat = [[data objectForKey:@"cLat"] floatValue];
        self.cLon = [[data objectForKey:@"cLon"]floatValue];
        self.siteNm = [data objectForKey:@"siteName"];
        self.siteNO = [data objectForKey:@"siteNo"];
        
        //构造圆，在地图上添加圆
        _circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(_cLat,_cLon) radius:1000];
        [_mapView addOverlay: _circle];
        
        //          设置大头针
        pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(_cLat, _cLon);
        pointAnnotation.title = [NSString stringWithFormat:@"%@",self.siteNm];
        pointAnnotation.subtitle = [NSString stringWithFormat:@"%@",self.siteNO];
        [_mapView addAnnotation:pointAnnotation];
        
        //         大头针标题和子标题自动显示
        [_mapView selectAnnotation:pointAnnotation animated:YES];
        
        
        //            NSLog(@"%f , %f , %@ , %@ " ,self.cLat,self.cLon,self.siteNm,self.siteNO);
        
        
        //继续跟踪定位
        _mapView.showsUserLocation = YES;//YES 为打开定位，NO为关闭定位
        onlyOnce = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    
    
  
}
#pragma mark -----实现<MAMapViewDelegate>协议中的mapView:viewForOverlay:回调函数，设置定位圆的样式-----
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:206/255.0f green:144/255.0f blue:124/255.0f alpha:0.1];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:0.1];
        pre.image = [UIImage imageNamed:@"location.png"];
        pre.lineWidth = 0;
        pre.lineDashPattern = @[@6, @3];
        	
        [_mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
        NSLog(@"%@",locationManager);
    } 
}

#pragma mark - MAMapViewDelegate  大圆
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        circleRenderer.lineWidth   = 0.f;
        circleRenderer.strokeColor = [UIColor blueColor];
        circleRenderer.fillColor   = [UIColor colorWithRed:181/255.0f green:181/255.0f blue:187/255.0f alpha:0.5];

        return circleRenderer;
    }
    return nil;
}
#pragma mark -MAMapViewDelegate  设置标注(大头针)样式
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        
        return annotationView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)clickBtn
{
    //检查所有条件是否满足签到事件
    if (![self checkAllCondition])
    {
        return;
    }
    //司机签到的请求
    NSString *getUrlString = APP_SIGN_URL;
    NSString * encodedString = [getUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //首先创建一个manager。
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //申明返回的结果是json类型
   manager.responseSerializer = [AFJSONResponseSerializer serializer];
   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    _carNo = bottomView.carLabel.text;
    _signNo = bottomView.scanLabel.text;
    _siteName = _siteNm;
    _siteNo = _siteNO;
    _rLon = [NSString stringWithFormat:@"%f",_longitude];
    _rLat =[NSString stringWithFormat:@"%f",_latitude];
    
    NSLog(@"111 %@  222 %@ 333  %@  444 %@   555 %@   666 %@",  self.carNo,self.siteName,self.siteNo,self.rLat,self.rLon,self.signNo);
    NSMutableDictionary * params= [NSMutableDictionary dictionary];
    [params setObject: _carNo forKey:@"carNo"];
    [params setObject:_signNo forKey:@"signNo"];
    [params setObject:_siteNo forKey:@"siteNo"];
    [params setObject:_siteName forKey:@"siteName"];
    [params setObject: _rLon forKey:@"rLon"];
    [params setObject:_rLat forKey:@"rLat"];
    
    if (!(_signNo.length==12&&[_signNo hasPrefix:@"STO"]))
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"车签号格式错误,签到失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return;
        
    }

//    发送请求
    [manager POST:encodedString parameters:params   success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",operation.responseObject);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        //        从字典里取出
        NSString * messageStr = [dic objectForKey:@"msg"];
         int  rc  = [[dic objectForKey:@"rc"] intValue];
//        NSString * msg = [dic objectForKey:@"msg"];
//        NSLog(@" msg %@", msg );
        
        if(rc==0)
        {
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"签到成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
        }
        else
        {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:messageStr   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器异常，请稍候再试" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }];

}


#pragma mark - 检查所有条件是否满足签到要求
-(BOOL)checkAllCondition
{
    if (self.siteNm==nil||self.siteNO==nil)
    {
        UIAlertView * alert =[ [UIAlertView alloc]initWithTitle:@"提示" message:@"获取周边站点数据异常，请检查。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if ([bottomView.scanLabel.text isEqualToString:@"未扫描"]) {
        UIAlertView * alert =[ [UIAlertView alloc]initWithTitle:@"提示" message:@"请您先进行扫描才能进行签到哦。" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 10001;
        [alert show];
        return NO;
    }
    return YES;
}
#pragma mark - uialertview点击代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //进入扫描方法
    if (alertView.tag == 10001)
    {
        [self scanBtn];
    }
}

//扫描按钮绑定的方法
- (void)scanBtn
{
    [self QRscan];
}
-(void)QRscan
{
        isScan=YES;//更改状态，确认为扫描操作
        mReader = [[ZBarReaderViewController alloc]init]; // [ZBarReaderViewController new]
        mReader.readerDelegate = self;
       //非全屏
        mReader.wantsFullScreenLayout = YES;

    mReader.readerView.scanCrop = CGRectMake(0, 0, SCREEN_WIDTH, 100);//将被扫描的图像的区域
    //隐藏底部控制按钮
        mReader.showsZBarControls = NO;
       //设置自己定义的界面
        [self setOverlayPickerView:mReader];
        ZBarImageScanner *scanner = mReader.scanner;
        [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,16, 21)];
    [leftButton setImage:[UIImage imageNamed:@"return_main.png"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"return_main.png"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(zBarBackPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    mReader.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,40,20)];
    [rButton setTitle:@"相册" forState:UIControlStateNormal];
    rButton.titleLabel.textColor = [UIColor whiteColor];
    rButton.titleLabel.font = Bold_16;
    [rButton addTarget:self action:@selector(clickPhotoItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithCustomView:rButton];
    mReader.navigationItem.rightBarButtonItem = rItem;
    
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,150,30)];
    [titleLabel2 setBackgroundColor:[UIColor clearColor]];
    [titleLabel2 setTextColor:[UIColor whiteColor]];
    [titleLabel2 setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:19]];
    [titleLabel2 setText:@"扫一扫"];
    [titleLabel2 setTextAlignment:NSTextAlignmentCenter];
    [mReader.navigationItem setTitleView:titleLabel2];
    
    UINavigationController* naviCtrller = [[UINavigationController alloc]initWithRootViewController:mReader];
    [naviCtrller.navigationBar setBackgroundImage:[UIImage imageNamed:@"top"] forBarMetrics:UIBarMetricsDefault];
    naviCtrller.navigationBar.backgroundColor=[UIColor grayColor];
//    [self presentViewController:naviCtrller animated:YES completion:nil];
    [self.navigationController presentViewController:naviCtrller animated:YES completion:nil];
}

- (void)setOverlayPickerView:(ZBarReaderViewController *)reader
{
//    //清除原有控件
//    for (UIView *temp in [reader.view subviews]) {
//        for (UIButton *button in [temp subviews]) {
//            if ([button isKindOfClass:[UIButton class]]) {
//                [button removeFromSuperview];
//            }
//        }
//        for (UIToolbar *toolbar in [temp subviews]) {
//            if ([toolbar isKindOfClass:[UIToolbar class]]) {
//                [toolbar setHidden:YES];
//                [toolbar removeFromSuperview];
//            }
//        }
//    }
    //最上部view
    UIView* upView = [[UIView alloc] init];
    upView.frame = CGRectMake(0, 0, SCREEN_WIDTH,210);
    //   upView.backgroundColor = COLOR(101, 101, 101, 1);
    //用于说明的label
    [reader.view addSubview:upView];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    img.backgroundColor = COLOR(101, 101, 101, 1);
    [upView addSubview:img];
    
    UIImageView *scanBg = [[UIImageView alloc] initWithFrame:CGRectMake(0,20, SCREEN_WIDTH,upView.frame.size.height+24)];
    scanBg.backgroundColor = [UIColor clearColor];
    scanBg.image = [UIImage imageNamed:@"scanAreaIconBg_search"];
    [upView  addSubview:scanBg];
    
    //动画
    mLine = [[UIImageView alloc] initWithFrame:CGRectMake(20,25,SCREEN_WIDTH-50, 3)];
    mLine.image = [UIImage imageNamed:@"line.png"];
    [scanBg addSubview:mLine];
    //定时器，设定时间过1.5秒，
    mTimer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    //底部view
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, 210+44, SCREEN_WIDTH,SCREEN_HEIGHT-64-210+20)];
    NSLog(@"%f",SCREEN_WIDTH);
    if (SCREEN_WIDTH >= 375)//如果是iphone6或者iphone6plus
    {
        upView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
        scanBg.frame = CGRectMake(0,20, SCREEN_WIDTH,upView.frame.size.height+25);
        downView.frame = CGRectMake(0, upView.frame.size.height+44, SCREEN_WIDTH,SCREEN_HEIGHT-64-upView.frame.size.height+20);
    }
    downView.backgroundColor = COLOR(101, 101, 101, 1);
    [reader.view  addSubview:downView];
    
    UILabel * labIntroudction= [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame= CGRectMake(0,15, SCREEN_WIDTH, 30);
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.font = Bold_17;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text = @"请将条码放入扫描框中进行扫描";
    [downView addSubview:labIntroudction];
    
    UIButton *lightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lightBtn.frame = CGRectMake((SCREEN_WIDTH-71)/2,45,71,71);
    lightBtn.backgroundColor = [UIColor clearColor];
    [lightBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [lightBtn addTarget:self action:@selector(openLightClick:) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:lightBtn];
    
    //用于说明的label
    UILabel * openLignt = [[UILabel alloc] initWithFrame:CGRectMake(0,120, SCREEN_WIDTH,20)];
    openLignt.backgroundColor = [UIColor clearColor];
    openLignt.textAlignment = NSTextAlignmentCenter;
    openLignt.font = Bold_18;
    openLignt.textColor=[UIColor whiteColor];
    openLignt.text = @"打 开 闪 光 灯";
    [downView addSubview:openLignt];

}
-(void)animation1
{
    if (upOrdown == NO)
    {
        num ++;
        mLine.frame = CGRectMake(20, 5+2*num,SCREEN_WIDTH-50, 2);
        int tempF;
        if (SCREEN_WIDTH >= 375)
        {
            tempF = 260;
        }else
        {
            tempF = 220;
        }
        if (2*num == tempF)
        {
            upOrdown = YES;
        }
    }else {
        num --;
        mLine.frame = CGRectMake(20, 5+2*num, SCREEN_WIDTH-50, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

-(void)openLightClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.selected) {
        btn.selected = NO;
        mReader.readerView.torchMode = 0;
    }else{
        btn.selected = YES;
        mReader.readerView.torchMode = 1;
    }
}
//相册
-(void)clickPhotoItem:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) { UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (read) {
            read = nil;
        }
        read = [ZBarReaderController new];
        read.readerDelegate = self;
        read.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self dismissViewControllerAnimated:NO completion:^{
        
        }];
        [self presentViewController:read animated:YES completion:^{}]; }
}

-(void) readerControllerDidFailToRead: (ZBarReaderController*) reader withRetry:(BOOL) retry
{
    if (retry)
    {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"无法识别的图片" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"2222222");
    //本地图片
    if (mReader.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        UIImage* image = [info objectForKey: UIImagePickerControllerOriginalImage];
        CGImageRef cgImageRef = image.CGImage;
        
        ZBarSymbol* symbol = nil;
        for(symbol in [read scanImage:cgImageRef])
            break;
        mNumberLabel.text = symbol.data;
        // [self.navigationController dismissViewControllerAnimated:YES completion:^{[self searchNumber];}];
    }
    else{
        [mTimer invalidate];
        mLine.frame = CGRectMake(20,5,SCREEN_WIDTH-50, 2);
        num = 0;
        upOrdown = NO;  ///~~~~~~
        
        id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
        ZBarSymbol *symbol = nil;
        for(symbol in results)
            break;
        NSLog(@"===%@",symbol.data);
        bottomView.scanLabel.text = symbol.data;
        bottomView.scanLabel.textColor = [UIColor blackColor];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(void)zBarBackPressed
{
    [mTimer invalidate];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%f",_mapView.frame.origin.y);
    }];
    
}

- (void)captureReader:(ZBarCaptureReader *)captureReader didReadNewSymbolsFromImage:(ZBarImage *)image
{
    
    NSLog(@"1111111");
    
    
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
