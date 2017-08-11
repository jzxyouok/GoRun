//
//  RBChangeMapTypeViewController.m
//  GoRun
//
//  Created by Macx on 2016/10/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "RBChangeMapTypeViewController.h"

@interface RBChangeMapTypeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *standardMap;
@property (weak, nonatomic) IBOutlet UIButton *satelliteMap;
@property (weak, nonatomic) IBOutlet UIButton *standardNightMap;

@end

@implementation RBChangeMapTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = MAMapTypeStandard;
    
    [self mapTypeSelected];
   
}

- (void)mapTypeSelected{
    
    switch (self.type)
    {
        case MAMapTypeStandard:
        {
            self.standardMap.selected = YES;
            self.satelliteMap.selected = NO;
            self.standardNightMap.selected = NO;
        }
            break;
        case MAMapTypeSatellite:
        {
            self.standardMap.selected = NO;
            self.satelliteMap.selected = YES;
            self.standardNightMap.selected = NO;
        }
            break;
        case MAMapTypeStandardNight:
        {
            self.standardMap.selected = NO;
            self.satelliteMap.selected = NO;
            self.standardNightMap.selected = YES;
        }
            break;
            
        default:
            break;
    }
}

/*
 MAMapTypeStandard = 0,  // 普通地图
 MAMapTypeSatellite,  // 卫星地图
 MAMapTypeStandardNight
 */

- (IBAction)changeMapTypeAction:(UIButton *)sender
{
    self.type = sender.tag;
    
    [self mapTypeSelected];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeMapType" object:@(self.type)];
 
}


@end
