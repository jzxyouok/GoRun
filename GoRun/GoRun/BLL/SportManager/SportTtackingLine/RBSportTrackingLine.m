//
//  RBSportTrackingLine.m
//  RunBa
//
//  Created by Macx on 2016/10/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "RBSportTrackingLine.h"

@implementation RBSportTrackingLine


- (double)distance
{
    return [self.endLocation distanceFromLocation:self.startLocation];
}

- (double)duration
{
    return self.endLocation.timestamp.timeIntervalSince1970 - self.startLocation.timestamp.timeIntervalSince1970;
}

- (double)speed
{
    return (self.distance / self.duration) * (3600 / 1000);
}

@end
