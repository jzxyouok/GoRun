//
//  RBSportTrackingManager.h
//  RunBa
//
//  Created by Macx on 2016/10/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
// 运动轨迹逻辑分析层
#import "RBSportTracking.h"


typedef enum : NSUInteger {
    gpsDisconnect,
    gpsBad,
    gpsNormal,
    gpsGood
} GpsStatus;

@interface RBSportTrackingManager : NSObject

+ (instancetype)sharedManager;

//属性
@property (nonatomic,strong)NSMutableArray<RBSportTracking *> *sportTrackings;


//是否正在运动
@property (nonatomic,assign)BOOL sportingStatus;

@property (nonatomic,strong)RBSportTracking *sportTracking;

@property (nonatomic,assign)GpsStatus gpsStatus;
//方法

/**
 开始运动

 @param type 运动类型
 */
- (void)startWithType:(SportTrackingType)type;

- (void)pauseSport;

- (void)continueSport;

- (void)endSport;

- (void)cancelSport;

@end
