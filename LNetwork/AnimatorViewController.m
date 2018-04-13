//
//  AnimatorViewController.m
//  LNetwork
//
//  Created by idea on 2018/4/13.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "AnimatorViewController.h"
#import "NerdyUI.h"
#import <JHChainableAnimations/JHChainableAnimator.h>

#pragma mark - JHChainableAnimator动画
@interface AnimatorViewController ()

@end

@implementation AnimatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(UIView *)myView
{
    if(!_myView){
        _myView = View.bgColor(@"red").addTo(self.view);
        _myView.makeCons(^{
            make.top.equal.constants(100);
            make.left.equal.constants(50);
            make.width.height.constants(50);
        });
    }
    return _myView;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    JHChainableAnimator *animator = [[JHChainableAnimator alloc] initWithView:self.myView];
#pragma mark - 1
    //    在1秒内，水平向右移动50，旋转一周；
    //    animator.moveX(50).rotate(360).animate(1);
#pragma mark - 2
    //    在1秒内，放大2倍；
    //    animator.makeScale(2.0).animate(1.0);
#pragma mark - 3
    //    在1秒内，放大2倍,并向右移动100，向下移动50；
    //    animator.makeScale(2.0).moveXY(100, 50).animate(1.0);
#pragma mark - 4
    //    Chaining Animations
    //    先在0.5秒内放大2倍后，在在1秒内，向右移动100，向下移动50；
    //    animator.makeScale(2.0).thenAfter(0.5).moveXY(100, 50).animate(1.0);
#pragma mark - 5
    //    弹簧效果缩放
    //    在1秒内，弹簧效果放大2倍；
    //    animator.makeScale(2.0).spring.animate(1.0);
    //    添加相同的可链接属性，则第二个将会取代第一个属性的输出。
    //    animator.makeScale(2.0).bounce.spring.animate(1.0);
#pragma mark - 6
    //    先在1秒内，以左上角的点为锚点，顺时针旋转180度，然后以中心为锚点一秒内顺时针旋转90度
    //    animator.rotateZ(180).anchorTopLeft.thenAfter(1.0).rotateZ(90).anchorCenter.animate(1.0);
#pragma mark - 7
    //    延迟0.5秒秒后，并向右移动100，向下移动50；
    //    animator.moveXY(100, 50).wait(0.5).animate(1.0);
#pragma mark - 8
    //    动画完成后调用animateWithCompletion
    //    animator.makeX(0).animateWithCompletion(1.0, ^{
    //        NSLog(@"Animation Done");
    //    });
    //    每0.5秒放大1.2倍之后，并向右移动100，向下移动50；
    //    animator.makeScale(1.2).repeat(0.5, 3).moveXY(100, 50).animate(1.0);
    
    //    先放大2倍，然后每秒旋转90度，旋转3次
    //    animator.makeScale(2.0).thenAfter(0.5).rotate(90). animateWithRepeat(1.0, 3);
#pragma mark - 9
    //    0.5秒内向右移动10，后在1秒内向下移动10
    //    由于使用了暂停pause；moveX动画会执行，而moveY不执行
    //    如果resume将会执行moveY
    //    如果调用stop，则不执行任何动画，并清除状态
    //    animator.moveX(10).thenAfter(0.5).moveY(10).animate(0.5);
    //   动画暂停
    //    [animator pause];
#pragma mark - 10
    //    回调：先在1秒内向右移动10，调用preAnimationBlock，在向下移动10，调用postAnimationBlock
    //    animator.moveX(10).preAnimationBlock(^{
    //        NSLog(@"before the first animation");
    //    }).thenAfter(1.0).postAnimationBlock(^{
    //        NSLog(@"After the second animation");
    //    }).moveY(10).animate(1.0);
#pragma mark - 11
    //    沿着UIBezier路径制作视图动画，
    //    贝塞尔曲线，定义一个点和曲线，
    //    点沿着曲线在1秒内完成运动
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.myView.center];
    [path addLineToPoint:CGPointMake(25, 400)];
    [path addLineToPoint:CGPointMake(300, 500)];
    animator.moveOnPath(path).animate(1.0);
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
