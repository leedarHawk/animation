//
//  ViewController.m
//  animation
//
//  Created by hawk on 2019/2/14.
//  Copyright © 2019 wanshijie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property UIView *movingView;
@property CALayer *redLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _movingView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 50, 50)];
    _movingView.backgroundColor = [UIColor redColor];
    
//    [self.view addSubview:_movingView];
//    [self spring];
    
    [self addAnimationLayer];
    [self animationKeyFrame];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)spring{
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.movingView.frame = CGRectMake(0, 50, self.view.bounds.size.width - 100, 50);
    } completion:nil];
//    UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//        if self.labelPositionIsLeft {
//            self.label.center.x = self.view.bounds.width - 100
//        }
//        else {
//            self.label.center.x = 100
//        }
//        self.labelPositionIsLeft = !(self.labelPositionIsLeft)
//    }, completion: nil)
}
-(void)group{
    /* 动画1（在X轴方向移动） */
    CABasicAnimation *animation1 =
    [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    
    // 终点设定
    animation1.toValue = [NSNumber numberWithFloat:200];; // 終点
    
    
    /* 动画2（绕Z轴中心旋转） */
    CABasicAnimation *animation2 =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 设定旋转角度
    animation2.fromValue = [NSNumber numberWithFloat:0.0]; // 开始时的角度
    animation2.toValue = [NSNumber numberWithFloat:40 * M_PI]; // 结束时的角度
    
    
    /* 动画组 */
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    // 动画选项设定
    group.duration = 3.0;
    group.repeatCount = 1;
     // 指定委托对象

    group.delegate = self;
    // 添加动画
    group.animations = [NSArray arrayWithObjects:animation1, animation2, nil];
    [_movingView.layer addAnimation:group forKey:@"move-rotate-layer"];
}

-(void)animation{

    //    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"position"];
    //    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)]; // 起始点
    //    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(320, 480)]; // 终了
    // 对Y轴进行旋转（指定Z轴的话，就和UIView的动画一样绕中心旋转）
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    //
    //    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    //    animation.toValue = [NSNumber numberWithFloat:1 * M_PI]; // 终止角度
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:2.0]; // 结束时的倍率
    
    
    animation.duration = 2.5; // 动画持续时间
    animation.repeatCount = 2; // 不重复
    animation.beginTime = CACurrentMediaTime() + 2; // 2秒后执行
    animation.autoreverses = NO;
    
    animation.timingFunction =
    [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    
    
    
    
    
    // 动画终了后不返回初始状态
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [_movingView.layer addAnimation:animation forKey:@"move-layer"];
    
}


-(void)addAnimationLayer{
    // 1. 添加redLayer图层 到view.layer上
    CALayer *layer = [CALayer layer];
    
    _redLayer = layer;
    
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    layer.frame = CGRectMake(50, 50, 200, 200);
    
    [self.view.layer addSublayer:_redLayer];
    
    
}

-(void)animationKeyFrame{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.duration = 5;
    anim.keyPath = @"transform";
    NSValue *value =  [NSValue valueWithCATransform3D:CATransform3DMakeRotation((-15) / 180.0 * M_PI, 0, 0, 1)];
    NSValue *value1 =  [NSValue valueWithCATransform3D:CATransform3DMakeRotation((15) / 180.0 * M_PI, 0, 0, 1)];
    NSValue *value2 =  [NSValue valueWithCATransform3D:CATransform3DMakeRotation((-15) / 180.0 * M_PI, 0, 0, 1)];
    anim.values = @[value, value1];
    
    anim.repeatCount = 1;
    
    [_redLayer addAnimation:anim forKey:nil];
}

/**
 * 动画开始时
 */
- (void)animationDidStart:(CAAnimation *)theAnimation
{
    NSLog(@"begin");
}

/**
 * 动画结束时
 */
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    NSLog(@"end");
}

@end
