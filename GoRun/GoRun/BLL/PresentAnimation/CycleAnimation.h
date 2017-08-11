//
//  CycleAnimation.h
//  GoRun
//
//  Created by Macx on 2016/10/5.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CycleAnimation : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate,CAAnimationDelegate>

@property (nonatomic,assign)CGPoint startPoint;

@property (nonatomic,assign)NSTimeInterval duration;

@property (nonatomic,assign)CGFloat radius;

@end
