//
//  ViewController.m
//  22_TouchesTest
//
//  Created by Oleg Tverdokhleb on 15.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) UIView *draggingView;
@property (assign, nonatomic) CGPoint touchOffset;
@end

@implementation ViewController

#pragma mark - LifeCycles
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat size = 50;
    for (int i = 0; i < 6; i += 1) {
        CGRect frame = CGRectMake(i * size/2, i * size, size, size);
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.backgroundColor = [self randomColor];
        [self.view addSubview:view];
    }
//    self.view.multipleTouchEnabled = YES;
}
#pragma mark - Additional
- (void)logTouches:(NSSet *)touches withMethod:(NSString *)methodName {
    NSMutableString *string = [NSMutableString stringWithString:methodName];
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        [string appendFormat:@" %@", NSStringFromCGPoint(point)];
    }
    NSLog(@"%@", string);
}

- (UIColor *)randomColor {
    CGFloat r = (CGFloat)arc4random_uniform(256) / 255.f;
    CGFloat g = (CGFloat)arc4random_uniform(256) / 255.f;
    CGFloat b = (CGFloat)arc4random_uniform(256) / 255.f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

- (void)onTouchesEnded {
    [UIView animateWithDuration:0.3f animations:^{
        self.draggingView.transform = CGAffineTransformIdentity;
        self.draggingView.alpha = 1.f;
    }];
    self.draggingView = nil;
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self logTouches:touches withMethod:@"touchesBegan"];
    UITouch *touch = [touches anyObject];
    CGPoint pointOnMainView = [touch locationInView:self.view];
    UIView *view = [self.view hitTest:pointOnMainView withEvent:event];
    if (![view isEqual:self.view]) {
        self.draggingView = view;
        [self.view bringSubviewToFront:self.draggingView];
        //offset
        CGPoint pointInside = [touch locationInView:self.draggingView];
        CGFloat dx = CGRectGetMidX(self.draggingView.bounds) - pointInside.x;
        CGFloat dy = CGRectGetMidY(self.draggingView.bounds) - pointInside.y;
        self.touchOffset = CGPointMake(dx, dy);
        
        //make new center
        CGFloat newX = pointOnMainView.x + dx;
        CGFloat newY = pointOnMainView.y + dy;
        CGPoint point = CGPointMake(newX, newY);
        self.draggingView.center = point;
        
        [UIView animateWithDuration:0.3f animations:^{
            self.draggingView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            self.draggingView.alpha = 0.3f;
        }];
    } else {
        self.draggingView = nil;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self logTouches:touches withMethod:@"touchesMoved"];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if (self.draggingView) {
        CGFloat x = point.x + self.touchOffset.x;
        CGFloat y = point.y + self.touchOffset.y;
        self.draggingView.center = CGPointMake(x, y);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self logTouches:touches withMethod:@"touchesEnded"];
    [self onTouchesEnded];
}

- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self logTouches:touches withMethod:@"touchesCancelled"];
    [self onTouchesEnded];
}

#pragma mark - _UNUSED_
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
