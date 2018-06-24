//
//  ViewController.m
//  22_TouchesTest
//
//  Created by Oleg Tverdokhleb on 29.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//@property (weak, nonatomic) UIView *testView;
@property (weak, nonatomic) UIView *draggingView;
@property (assign, nonatomic) CGPoint touchOffset;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 3; j++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(30 + (85*i), 20 + (85*j), 75, 75)];
            view.backgroundColor = [self randomColor];
            [self.view addSubview:view];
        }
    }
//    self.testView = view;
//    self.view.multipleTouchEnabled = YES;
}

- (CGFloat) randomFromZeroToOne {
    return (float)(arc4random() % 256) / 255.f;
}

- (UIColor*) randomColor {
    CGFloat r = [self randomFromZeroToOne];
    CGFloat g = [self randomFromZeroToOne];
    CGFloat b = [self randomFromZeroToOne];
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) logTouches:(NSSet*) touches withMethod:(NSString*) methodName {
    NSMutableString* string = [NSMutableString stringWithString:methodName];
    
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        [string appendFormat:@" %@", NSStringFromCGPoint(point)];
    }
    
    NSLog(@"%@", string);
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    //NSLog(@"touchesBegan"); // Тачи начинаются
    [self logTouches:touches withMethod:@"touchesBegan"];
    
    /*
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self.testView];
    
    NSLog(@"inside = %d", [self.testView pointInside:point withEvent:event]);
    */ //pointInside!
    
    UITouch *touch = [touches anyObject];
    CGPoint pointOnMainView = [touch locationInView:self.view];
    UIView *view = [self.view hitTest:pointOnMainView withEvent:event];
    
    if (![view isEqual:self.view]) {
        self.draggingView = view;
        [self.view bringSubviewToFront:self.draggingView];
        CGPoint touchPoint = [touch locationInView:self.draggingView];
        self.touchOffset = CGPointMake(CGRectGetMidX(self.draggingView.bounds) - touchPoint.x,
                                       CGRectGetMidY(self.draggingView.bounds) - touchPoint.y);
        
        //[self.draggingView.layer removeAllAnimations];
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.draggingView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                             self.draggingView.alpha = 0.3f;
                         }];
        
    } else {
        self.draggingView = nil;
    }
    
    //NSLog(@"inside = %d", [self.view pointInside:point withEvent:event]);

}

- (void) onTouchesEnded {
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.draggingView.transform = CGAffineTransformIdentity;
                         self.draggingView.alpha = 1.f;
                     }];
    self.draggingView = nil;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    //NSLog(@"touchesMoved"); // Просисходит движение
    [self logTouches:touches withMethod:@"touchesMoved"];

    if (self.draggingView) {
    UITouch *touch = [touches anyObject];
    CGPoint pointOnMainView = [touch locationInView:self.view];
    CGPoint correction = CGPointMake(pointOnMainView.x + self.touchOffset.x,
                                     pointOnMainView.y + self.touchOffset.y);
    self.draggingView.center = correction;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    //NSLog(@"touchesEnded"); // Тачи заканчиваются
    [self logTouches:touches withMethod:@"touchesEnded"];
    [self onTouchesEnded];
}

- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    //NSLog(@"touchesCancelled"); // Тачи отменяются
    [self logTouches:touches withMethod:@"touchesCancelled"];
    [self onTouchesEnded];

}

@end
