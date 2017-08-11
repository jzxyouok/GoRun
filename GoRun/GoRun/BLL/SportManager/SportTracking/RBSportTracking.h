//
//  RBSportTracking.h
//  GoRun
//
//  Created by Macx on 2016/10/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBSportTrackingLine.h"



typedef enum : NSUInteger {
    run,
    walk,
    cycle,
    hide
} SportTrackingType;

@interface RBSportTracking : NSObject

@property (nonatomic,strong)NSMutableArray<RBSportTrackingLine *> *lines;

@property (nonatomic,strong)RBSportTrackingLine *line;

@property (nonatomic,assign)SportTrackingType type;

@property (nonatomic,assign)double duration;

@property (nonatomic,assign)double distance;

@property (nonatomic,strong)NSString *durationStr;

@property (nonatomic,strong)NSString *distanceStr;

@property (nonatomic,assign)double speed;

@property (nonatomic,strong)NSString *speedStr;

@end
