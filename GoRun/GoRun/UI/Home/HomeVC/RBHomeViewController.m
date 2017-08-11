//
//  RBHomeViewController.m
//  RunBa
//
//  Created by Macx on 2016/10/4.
//  Copyright © 2016年 Macx. All rights reserved.e33
//

#import "RBHomeViewController.h"

@interface RBHomeViewController ()

@end

@implementation RBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)enterSportingVC{
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    
    UIViewController *vc = [SB instantiateViewControllerWithIdentifier:@"RBSportiingViewController"];
    
    [self presentViewController:vc animated:YES completion:nil];
}


- (IBAction)runAction:(id)sender {
    [_sportManager startWithType:run];
    [self enterSportingVC];
}
- (IBAction)walkAction:(id)sender {
    [_sportManager startWithType:walk];
    [self enterSportingVC];
    
}
- (IBAction)cycleAction:(id)sender {
    [_sportManager startWithType:cycle];
    [self enterSportingVC];
}

- (IBAction)hideAction:(id)sender {
    [_sportManager startWithType:hide];
    [self enterSportingVC];
}

@end
