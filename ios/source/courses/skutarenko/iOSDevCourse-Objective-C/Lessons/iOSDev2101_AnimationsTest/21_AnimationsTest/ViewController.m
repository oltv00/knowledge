//
//  ViewController.m
//  21_AnimationsTest
//
//  Created by Oleg Tverdokhleb on 11.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *testView;
@property (weak, nonatomic) UIImageView *testImageView;

@end

@implementation ViewController

#pragma mark - LifeCycles

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self initView];
    [self initImageView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self level1];
//    [self level2];
//    [self level3];
//    [self level4];
    [self level5];
}

#pragma mark - initial

- (void)initImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    self.testImageView = imageView;
    UIImage *image1 = [UIImage imageNamed:@"1.png"];
    UIImage *image2 = [UIImage imageNamed:@"2.png"];
    UIImage *image3 = [UIImage imageNamed:@"3.png"];
    NSArray *images = @[image1, image2, image1, image3];
    
    imageView.animationImages = images;
    imageView.animationDuration = 1.f;
    [imageView startAnimating];
}

- (void)initView {
    UIView *view = [[UIView alloc] initWithFrame:
                    CGRectMake(20, 20, 100, 100)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    self.testView = view;
}

#pragma mark - Levels

- (void)level5 {
    [self moveView:self.testImageView];
}

- (void)level4 {
    NSLog(@"view frame = %@", NSStringFromCGRect(self.testView.frame));
    NSLog(@"view bounds = %@", NSStringFromCGRect(self.testView.bounds));
    [self moveView:self.testView];
}



- (void)level3 {
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations:^{
                         self.testView.center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.testView.frame) / 2, 70);
                         self.testView.backgroundColor = [self randomColor];
                         
                         //self.testView.transform = CGAffineTransformMakeRotation(M_PI); // поворот
                         //self.testView.transform = CGAffineTransformMakeTranslation(800, 0); //передвижение
                         
                         CGAffineTransform scale = CGAffineTransformMakeScale(2, 0.5f);
                         CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI);
                         CGAffineTransform transform = CGAffineTransformConcat(scale, rotation);
                         
                         self.testView.transform = transform;
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"Animation finished! %d", finished);
                     }];
}

- (void)level2 {
    [UIView animateWithDuration:10
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut //| UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations:^{
                         self.testView.center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.testView.frame) / 2, 70);
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"Animation finished! %d", finished);
                     }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.testView.layer removeAllAnimations];
        
        [UIView animateWithDuration:4
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.testView.center = CGPointMake(250, 250);
                         }
                         completion:^(BOOL finished) {
                             NSLog(@"Animation finished! %d", finished);
                         }];
    });
}

- (void)level1 {
    [UIView animateWithDuration:5 animations:^{
        self.testView.center = CGPointMake(CGRectGetMaxX(self.view.bounds) - CGRectGetWidth(self.testView.frame) / 2, self.testView.center.y);
    }];
}

#pragma mark - Additional

- (void)moveView:(UIView *)view {
    
    //random rect in move view
    CGRect rect = self.view.bounds;
    rect = CGRectInset(rect, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    
    //random point in rect
    CGFloat x = arc4random() % (int)CGRectGetWidth(rect) + CGRectGetMinX(rect);
    CGFloat y = arc4random() % (int)CGRectGetHeight(rect) + CGRectGetMinY(rect);
    
    //random scale
    CGFloat scale = (float)(arc4random() % 151) / 100.f + 0.5f;
    
    //random rotation
    CGFloat rotation = (float)(arc4random() % (int)(M_PI * 2 * 10000)) / 10000 - M_PI;
    
    //random duration
    CGFloat duration = (float)(arc4random_uniform(20000) + 20000) / 10000;
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear //| UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations:^{
                         view.center = CGPointMake(x, y);
                         self.testView.backgroundColor = [self randomColor];
                         
                         CGAffineTransform scaleTransform = CGAffineTransformMakeScale(scale, scale);
                         CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(rotation);
                         CGAffineTransform transform = CGAffineTransformConcat(scaleTransform, rotationTransform);
                         
                         view.transform = transform;
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"Animation finished! %d", finished);
                         NSLog(@"view frame = %@", NSStringFromCGRect(view.frame));
                         NSLog(@"view bounds = %@", NSStringFromCGRect(view.bounds));
                         
                         __weak UIView *weakView = view;
                         [self moveView:weakView];
                     }];
    
}
- (UIColor *)randomColor {
    CGFloat r = (CGFloat)arc4random_uniform(256) / 255;
    CGFloat g = (CGFloat)arc4random_uniform(256) / 255;
    CGFloat b = (CGFloat)arc4random_uniform(256) / 255;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

#pragma mark - _UNUSED_

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
