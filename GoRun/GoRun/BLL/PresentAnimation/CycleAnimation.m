//
//  CycleAnimation.m
//  GoRun
//
//  Created by Macx on 2016/10/5.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "CycleAnimation.h"

@interface CycleAnimation ()

@property (nonatomic,assign)BOOL isPresented;

@end

@implementation CycleAnimation
{
    __weak id<UIViewControllerContextTransitioning> _transitionContext;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return self.duration;
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    
    self.isPresented = YES;
    
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.isPresented = NO;
    
    return self;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _transitionContext = transitionContext;
    // 1. containerView
    UIView *containerView = [transitionContext containerView];
    // 2. 获取 toController
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    
    if (self.isPresented)
    {
        [containerView addSubview:toView];
    }else
    {
        [containerView insertSubview:toView atIndex:0];
    }
    //最小半径
    CGFloat minRadius = self.radius;
    
    CGPoint startP = self.startPoint;
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    //最大半径
    CGFloat maxRadius = pow(pow(MAX(startP.x, screenW - startP.x), 2) + pow(MAX(startP.y, screenH - startP.y),2),0.5);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.startPoint radius:minRadius startAngle:0 endAngle:360 clockwise:YES];
    
    CAShapeLayer *layer = [CAShapeLayer new];
    
    layer.path = (__bridge CGPathRef _Nullable)(path);
    
    if (self.isPresented)
    {
        toView.layer.mask = layer;
    }else
    {
        fromView.layer.mask = layer;
    }
    CGFloat startRadius = self.isPresented ? minRadius : maxRadius;
    CGFloat totolRadius = self.isPresented ? maxRadius : minRadius;
    
    //toView.alpha = 0;
    
    CABasicAnimation *animtion = [CABasicAnimation animationWithKeyPath:@"path"];
    
    animtion.fromValue = (__bridge id _Nullable)([UIBezierPath bezierPathWithArcCenter:self.startPoint radius:startRadius startAngle:0 endAngle:360 clockwise:YES].CGPath);
    animtion.toValue = (__bridge id _Nullable)([UIBezierPath bezierPathWithArcCenter:self.startPoint radius:totolRadius startAngle:0 endAngle:360 clockwise:YES].CGPath);
    animtion.duration = self.duration;
    animtion.fillMode = kCAFillModeForwards;
    animtion.removedOnCompletion = NO;
    animtion.delegate = self;
    [layer addAnimation:animtion forKey:nil];
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [_transitionContext completeTransition:YES];
}
@end
