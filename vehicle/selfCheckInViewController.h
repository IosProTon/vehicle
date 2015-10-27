//
//  selfCheckInViewController.h
//  StoVehicleSignedIos
//
//  Created by Mac OS on 15/7/30.
//  Copyright (c) 2015年 Mac OS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import "ZBarSDK.h"
#import "BottomView.h"
@interface selfCheckInViewController : UIViewController<MAMapViewDelegate>

{
    MAMapView *_mapView;
    MACircle *_circle ;
    CLLocationManager * locationManager;
    UIButton * _signBtn;
    ZBarReaderViewController *mReader;
    UIImageView *mLine;
    NSTimer *mTimer;
    BOOL upOrdown;
     int num;
     UILabel *mNumberLabel;
    BOOL isScan;//纪录是否为点击扫描按钮的唯一凭证
     ZBarReaderController* read;
    UILabel*_siteNoLabel;
    MAPointAnnotation *pointAnnotation ;
    UILabel * scanLabel;
    
    BOOL  onlyOnce;//第一次定位请求服务器获取最近站点，获取到最近站点后继续进行定位，但是不进行服务器的请求
    BottomView * bottomView;
}
@property(nonatomic,assign)float latitude;
@property(nonatomic,assign)float longitude;

@property(nonatomic,assign)float cLat;
@property(nonatomic,assign)float cLon;
@property(nonatomic,copy)NSString * siteNm;
@property(nonatomic,copy)NSString * siteNO;
@property(nonatomic,copy)NSString * siteName;
@property(nonatomic,copy)NSString * siteNo;
@property(nonatomic,copy)NSString * signNo;
@property(nonatomic,copy)NSString * rLon;
@property(nonatomic,copy)NSString * rLat;


@property(nonatomic,copy)NSString *carNo;

@end

