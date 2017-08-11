//
//  RBSportTrackingManager.m
//  RunBa
//
//  Created by Macx on 2016/10/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "RBSportTrackingManager.h"

#import <CoreLocation/CoreLocation.h>

@interface RBSportTrackingManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager *manager;


@property (nonatomic,strong)NSDate * beginDate;

@end

@implementation RBSportTrackingManager

- (NSMutableArray<RBSportTracking *> *)sportTrackings
{
    if (_sportTrackings == nil)
    {
        _sportTrackings = [NSMutableArray array];
    }
    return _sportTrackings;
}

-(instancetype)init
{
    if (self = [super init])
    {
        self.manager = [CLLocationManager new];
        
        [self.manager requestWhenInUseAuthorization];
        
        self.manager.delegate = self;
        
        if ([self.manager respondsToSelector:@selector(setAllowsBackgroundLocationUpdates:)])
        {
            self.manager.allowsBackgroundLocationUpdates = YES;
            
        }
        self.sportingStatus = YES;
        
        [self addObserver:self forKeyPath:@"sportingStatus" options:NSKeyValueObservingOptionNew context:nil];
        
        [self addObserver:self forKeyPath:@"gpsStatus" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

+ (instancetype)sharedManager
{
    static RBSportTrackingManager *instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [RBSportTrackingManager new];
        
    });
    
    return instance;
}

//方法

/**
 开始运动
 
 @param type 运动类型
 */
- (void)startWithType:(SportTrackingType)type
{
    self.sportTracking = [RBSportTracking new];
    
    self.sportTracking.type = type;
    
    [self.manager startUpdatingLocation];
    
    self.beginDate = [NSDate date];
}

- (void)pauseSport
{
    [self.manager stopUpdatingLocation];
    
    self.sportingStatus = NO;
    
}

- (void)continueSport
{
    
    self.beginDate = [NSDate date];
    
    [self.manager startUpdatingLocation];
    self.sportingStatus = YES;
}

- (void)endSport
{
    [self.manager stopUpdatingLocation];
    
    [self.sportTrackings addObject:self.sportTracking];
    
    self.sportingStatus = NO;
    
    self.sportTracking = nil;
}
- (void)cancelSport
{
    [self.manager stopUpdatingLocation];
    
    self.sportingStatus = NO;
    
    self.sportTracking = nil;
}



- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    double timeInterval = newLocation.timestamp.timeIntervalSince1970 - oldLocation.timestamp.timeIntervalSince1970;
    
    if (oldLocation == NULL)
    {
        return;
    }
    if(oldLocation.timestamp.timeIntervalSince1970 <= self.beginDate.timeIntervalSince1970) {
        return;
    }
    if (timeInterval <= 0)
    {
        return;
    }
    if (timeInterval < 1.1)
    {
        self.gpsStatus = gpsGood;
        
    }else if (timeInterval < 2.0)
    {
        self.gpsStatus = gpsNormal;
    }else
    {
        self.gpsStatus = gpsBad;
    }
    
    RBSportTrackingLine *line = [RBSportTrackingLine new];
    line.startLocation = oldLocation;
    line.endLocation = newLocation;

    [self.sportTracking.lines addObject:line];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:sendSportTrackingLineArray object:line];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    if ([keyPath  isEqualToString:@"sportingStatus"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:sendSportingStatus object:change[NSKeyValueChangeNewKey]];
        
        //NSLog(@"%@",change[NSKeyValueChangeNewKey]);
    }else if ([keyPath isEqualToString:@"gpsStatus"])
    {
         [[NSNotificationCenter defaultCenter] postNotificationName:sendGpsStatus object:change[NSKeyValueChangeNewKey]];
    }
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined ||
        status == kCLAuthorizationStatusRestricted ||
        status == kCLAuthorizationStatusDenied) {
        self.gpsStatus = gpsDisconnect;
    }
}
@end
