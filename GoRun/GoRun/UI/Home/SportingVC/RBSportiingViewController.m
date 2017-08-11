//
//  RBSportiingViewController.m
//  RunBa
//
//  Created by Macx on 2016/10/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "RBSportiingViewController.h"
#import "RBAMapViewController.h"
#import "CycleAnimation.h"
@interface RBSportiingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIImageView *gpsImageView;

@end

@implementation RBSportiingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 颜色渐变的效果
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = @[(__bridge id)([UIColor colorWithHexString:@"0x0e1428"].CGColor),
                     (__bridge id)([UIColor colorWithHexString:@"0x406479"].CGColor),
                     (__bridge id)([UIColor colorWithHexString:@"0x406578"].CGColor)
                     ];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(0, 1);
    layer.frame = self.view.bounds;
    layer.locations = @[@0.0,@0.5,@1.0];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    
    self.continueButton.layer.cornerRadius = 50;
    [self.continueButton clipsToBounds];
    self.pauseButton.layer.cornerRadius = 50;
    [self.pauseButton clipsToBounds];
    self.finishButton.layer.cornerRadius = 50;
    [self.finishButton clipsToBounds];
    self.cancelButton.layer.cornerRadius = 50;
    [self.cancelButton clipsToBounds];
    
    
    //注册通知接受实时传过来的线条
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSportTrackingLineArray) name:sendSportTrackingLineArray object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSportingStatus:) name:sendSportingStatus object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveGpsStatus:) name:sendGpsStatus object:nil];

}
- (void)receiveSportTrackingLineArray
{
    self.durationLabel.text = _sportManager.sportTracking.durationStr;
    
    self.distanceLabel.text = _sportManager.sportTracking.distanceStr;
    
    self.speedLabel.text = _sportManager.sportTracking.speedStr;
}

- (void)receiveSportingStatus:(NSNotification *)noti
{
    BOOL status = [noti.object intValue];
    
    if (status)
    {
        self.continueButton.hidden = YES;
        self.finishButton.hidden = YES;
        self.pauseButton.hidden = NO;
    }
    else
    {
        self.continueButton.hidden = NO;
        self.finishButton.hidden = NO;
        self.pauseButton.hidden = YES;
    }
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)openMapAction:(UIButton *)sender {
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    
    RBAMapViewController *vc = [SB instantiateViewControllerWithIdentifier:@"RBAMapViewController"];
    
    CycleAnimation *animator = [CycleAnimation new];
    
    animator.radius = sender.bounds.size.width / 2;
    
    animator.startPoint = sender.center;
    
    animator.duration = 0.5;
    
    vc.animator = animator;
    
    [self presentViewController:vc animated:YES completion:nil];

}

- (IBAction)continueAction:(id)sender {
    
    [_sportManager continueSport];
   [UIView animateWithDuration:0.3 animations:^{
        self.continueButton.transform = CGAffineTransformIdentity;
        self.finishButton.transform = CGAffineTransformIdentity;
     }];
}
- (IBAction)pauseAction:(id)sender {
    [_sportManager pauseSport];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.continueButton.transform = CGAffineTransformMakeTranslation(-100, 0);
        self.finishButton.transform = CGAffineTransformMakeTranslation(100, 0);
    }];
    
}
- (IBAction)finishAction:(id)sender {
    [_sportManager endSport];
     [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)cancelAction:(id)sender {
    [_sportManager cancelSport];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
