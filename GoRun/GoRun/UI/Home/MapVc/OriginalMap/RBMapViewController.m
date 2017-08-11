//
//  RBMapViewController.m
//  RunBa
//
//  Created by Macx on 2016/10/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "RBMapViewController.h"

@interface RBMapViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation RBMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
 
    self.mapView.delegate = self;
    
    NSArray *array = _sportManager.sportTracking.lines;
    
    for (RBSportTrackingLine *line in array)
    {
        [self generateLineInMapWithLine:line];
    }
    
    
    //注册通知接受实时传过来的线条
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSportTrackingLineArray:) name:sendSportTrackingLineArray object:nil];
    
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


// 绘制折现
- (void)generateLineInMapWithLine:(RBSportTrackingLine *)line
{
    CLLocationCoordinate2D coodinate[2];
    
    coodinate[0] = line.startLocation.coordinate;
    
    coodinate[1] = line.endLocation.coordinate;
    
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coodinate count:2];
    
    [self.mapView addOverlay:polyLine];
}


// 通知方法
- (void)receiveSportTrackingLineArray:(NSNotification *)noti
{
     RBSportTrackingLine *line = noti.object;
    
    [self generateLineInMapWithLine:line];
}

//实现代理方法,设置渲染
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay
{

    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    renderer.lineWidth = 1;
    
    renderer.fillColor = [UIColor redColor];
    
    renderer.strokeColor = [UIColor redColor];
    
    return renderer;
}


//返回按钮
- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
