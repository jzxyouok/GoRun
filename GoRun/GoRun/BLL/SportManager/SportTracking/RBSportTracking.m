//
//  RBSportTracking.m
//  GoRun
//
//  Created by Macx on 2016/10/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "RBSportTracking.h"

@implementation RBSportTracking

- (NSMutableArray<RBSportTrackingLine *> *)lines
{
    if (_lines == nil)
    {
        _lines = [NSMutableArray array];
    }
    return _lines;
}

- (double)distance
{
    return [[self.lines valueForKeyPath:@"@sum.distance"] doubleValue];
}

- (double)duration
{
    return [[self.lines valueForKeyPath:@"@sum.duration"] doubleValue];
}

- (NSString *)durationStr
{
    int sum = (int)self.duration;
    
    int hour = sum / 3600;
    
    int min = (sum % 3600) / 60;
    
    int sec = sum % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,sec];
}

- (double)speed
{
    return [[self.lines valueForKeyPath:@"@avg.speed"] doubleValue];
}

- (NSString *)distanceStr
{
    return [NSString stringWithFormat:@"%.2f",self.distance / 1000];
}

- (NSString *)speedStr
{
    return [NSString stringWithFormat:@"%.2f",self.speed];
}
@end
