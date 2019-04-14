//
//  ViewController.m
//  Lesson3
//
//  Created by Oleg Tverdokhleb on 16.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *redView;
@property (weak, nonatomic) UIView *blueView;
@property (weak, nonatomic) UIView *mainView;

@property (weak, nonatomic) UIView *draggingView;
@property (assign, nonatomic) CGPoint touchOffset;

@end

@implementation ViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(20, 120, 50, 50)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    _redView = redView;
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(80, 120, 50, 50)];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    _blueView = blueView;
    
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(140, 120, 50, 50)];
    greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:greenView];
    
    UIView *cyanView = [[UIView alloc] initWithFrame:CGRectMake(200, 120, 50, 50)];
    cyanView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:cyanView];
    
    UIView *mainView = [[UIView alloc]
                        initWithFrame:
                        CGRectMake(CGRectGetMidX(self.view.frame) - CGRectGetWidth(self.view.frame) / 4,
                                                                20,
                                                                CGRectGetWidth(self.view.frame) / 2,
                                                                20)];
    mainView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:mainView];
    _mainView = mainView;
    
    NSMutableSet *mSet = [NSMutableSet set];
    for (int i = 0; i < 100; i++) {
        [mSet addObject:@(i)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    [self descriptionLogWithMethodName:@"touchesBegan" andTouches:touches];
//    [self setColorToMainViewWithTouchesSet:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    UIView *view = [self.view hitTest:point withEvent:event];
    
    NSLog(@"frame: %@, bounds: %@", NSStringFromCGRect(view.frame), NSStringFromCGRect(view.bounds));
    
    if (![view isEqual:self.view]) {
        _draggingView = view;
        CGPoint touchPoint = [touch locationInView:_draggingView];
        _touchOffset = CGPointMake(CGRectGetMidX(_draggingView.bounds) - touchPoint.x,
                                   CGRectGetMidY(_draggingView.bounds) - touchPoint.y);
        [self.view bringSubviewToFront:_draggingView];
        
        [UIView animateWithDuration:0.3f
                         animations:^{
                             _draggingView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                             _draggingView.alpha = 0.3f;
                         }];
    } else {
        _draggingView = nil;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    [self descriptionLogWithMethodName:@"touchesMoved" andTouches:touches];
//    [self setColorToMainViewWithTouchesSet:touches withEvent:event];
    
    if (_draggingView) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        
        CGPoint correction = CGPointMake(point.x + _touchOffset.x,
                                         point.y + _touchOffset.y);
        
        _draggingView.center = correction;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    [self descriptionLogWithMethodName:@"touchesEnded" andTouches:touches];
    
    if (_draggingView) {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             _draggingView.transform = CGAffineTransformIdentity;
                             _draggingView.alpha = 1.f;
                         }];
        
        _draggingView = nil;
    }
}

- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    [self descriptionLogWithMethodName:@"touchesCancelled" andTouches:touches];
    if (_draggingView) {
        _draggingView = nil;
    }
}

- (void)setColorToMainViewWithTouchesSet:(NSSet<UITouch *> *) touches withEvent:(nullable UIEvent *) event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    UIView *touchView = [self.view hitTest:point withEvent:event];
    UIColor *color = touchView.backgroundColor;
    _mainView.backgroundColor = color;
}

- (void)descriptionLogWithMethodName:(NSString *) methodName andTouches:(NSSet<UITouch *> *) touches {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    NSLog(@"%@ %@", methodName, NSStringFromCGPoint(point));
}

@end
