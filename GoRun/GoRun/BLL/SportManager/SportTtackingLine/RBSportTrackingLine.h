//
//  RBSportTrackingLine.h
//  RunBa
//
//  Created by Macx on 2016/10/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBSportTrackingLine : NSObject


@property (nonatomic,strong)CLLocation *startLocation;

@property (nonatomic,strong)CLLocation *endLocation;

@property (nonatomic,readonly)double duration;

@property (nonatomic,readonly)double distance;

@property (nonatomic,assign)double speed;


@end
