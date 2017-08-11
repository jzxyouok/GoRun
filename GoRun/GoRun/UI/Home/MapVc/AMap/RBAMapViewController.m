//
//  RBAMapViewController.m
//  GoRun
//
//  Created by Macx on 2016/10/5.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "RBAMapViewController.h"
#import "RBChangeMapTypeViewController.h"
@interface RBAMapViewController ()<MAMapViewDelegate,UIPopoverPresentationControllerDelegate>

@property (nonatomic,strong)MAMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gpsImageView;



@property (nonatomic,strong)UIColor * color;
@end

@implementation RBAMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    [self.view insertSubview:_mapView atIndex:0];
    
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    self.mapView.delegate = self;
    
    NSArray *array = _sportManager.sportTracking.lines;
    
    for (RBSportTrackingLine *line in array)
    {
        [self generateLineInMapWithLine:line];
    }

    //self.mapView.mapType = MAMapTypeSatellite;
    
    self.color =[UIColor yellowColor];
    //注册通知接受实时传过来的线条
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSportTrackingLineArray:) name:sendSportTrackingLineArray object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMapTypeWith:) name:@"changeMapType" object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveGpsStatus:) name:sendGpsStatus object:nil];
    
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    // 设置转场代理
    self.transitioningDelegate = self.animator;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)changeMapType:(UIButton *)sender {
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    
    RBChangeMapTypeViewController *changeVC = [SB instantiateViewControllerWithIdentifier:@"RBChangeMapTypeViewController"];
    
    changeVC.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popVC = changeVC.popoverPresentationController;
    
    popVC.delegate = self;
    
    popVC.sourceView = sender;
    
    popVC.sourceRect = sender.bounds;
    
    popVC.permittedArrowDirections = UIPopoverArrowDirectionDown;
    
    changeVC.preferredContentSize = CGSizeMake(0, 130);
 
    [self presentViewController:changeVC animated:YES completion:nil];
    
   // self.mapView.mapType = changeVC.type;
    
}

// 绘制折现
- (void)generateLineInMapWithLine:(RBSportTrackingLine *)line
{
    CLLocationCoordinate2D coodinate[2];
    
    coodinate[0] = line.startLocation.coordinate;
    
    coodinate[1] = line.endLocation.coordinate;
    
    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:coodinate count:2];
    
    [self.mapView addOverlay:polyLine];
    
    self.durationLabel.text = _sportManager.sportTracking.durationStr;
    
    self.distanceLabel.text = _sportManager.sportTracking.distanceStr;
    
    self.color = [UIColor colorWithRed:line.speed / 40 green:1- line.speed/ 40 blue:0 alpha:1];
    
}


// 通知方法
- (void)receiveSportTrackingLineArray:(NSNotification *)noti
{
    RBSportTrackingLine *line = noti.object;
    
    [self generateLineInMapWithLine:line];
}

- (void)changeMapTypeWith:(NSNotification *)noti
{
    self.mapView.mapType = [noti.object intValue];
}
- (void)receiveGpsStatus:(NSNotification *)noti
{
    GpsStatus status = [noti.object intValue];
    
    switch (status) {
        case gpsDisconnect:
            self.gpsImageView.image = [UIImage imageNamed:@"ic_sport_gps_map_disconnect"];
            break;
        case gpsBad:
            self.gpsImageView.image = [UIImage imageNamed:@"ic_sport_gps_map_connect_1"];
            break;
        case gpsNormal:
            self.gpsImageView.image = [UIImage imageNamed:@"ic_sport_gps_map_connect_2"];
            break;
        case gpsGood:
            self.gpsImageView.image = [UIImage imageNamed:@"ic_sport_gps_map_connect_3"];
            break;
            
        default:
            break;
    }
}

//实现代理方法,设置渲染
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    
    MAPolylineRenderer *renderer = [[MAPolylineRenderer alloc] initWithOverlay:overlay];
    
    renderer.lineWidth = 5;
    
    renderer.fillColor = self.color;
    
    renderer.strokeColor = self.color;
    
    return renderer;
}


- (IBAction)dismissAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

@end
