//
//  ViewController.m
//  21_AnimationsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 28.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)touchMe:(UIButton *)sender;

@property (assign, nonatomic) CGRect mainRect;
@property (assign, nonatomic) CGPoint centerOfView;

@property (strong, nonatomic) NSArray *angleViewColors;

@property (assign, nonatomic) CGRect horizontalRect;
@property (strong, nonatomic) NSMutableArray *horizontalViewArray;
@property (strong, nonatomic) NSMutableArray *horizontalCenterViewArray;

@property (assign, nonatomic) CGRect angleRect;
@property (strong, nonatomic) NSMutableArray *angleViewArray;
@property (strong, nonatomic) NSMutableArray *angleCenterViewArray;

@property (assign, nonatomic) NSInteger indexOfCreateHorizontalView; //UNUSED
@property (assign, nonatomic) NSInteger indexOfCreateAngleView;      //UNUSED
@property (assign, nonatomic) NSInteger buttonTouchMeIndex;          //UNUSED

@end

@implementation ViewController

- (IBAction)touchMe:(UIButton *)sender {
    [self horizontalViewCreate];
    [self horizontalViewAnimation];
    [self angleViewCreate];
    [self angleViewAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.mainRect = [self.view bounds];
    self.horizontalViewArray = [NSMutableArray array];
    self.horizontalCenterViewArray = [NSMutableArray array];
    
    self.angleViewArray = [NSMutableArray array];
    self.angleCenterViewArray = [NSMutableArray array];
    self.angleViewColors = [NSArray arrayWithObjects:   [UIColor redColor],
                                                        [UIColor yellowColor],
                                                        [UIColor greenColor],
                                                        [UIColor blueColor], nil];
    self.indexOfCreateAngleView = 0;
    self.indexOfCreateHorizontalView = 0;
    
    //START
//    [self horizontalViewCreate];
//    [self horizontalViewAnimation];
//    [self angleViewCreate];
//    [self angleViewAnimation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Views create

- (void) angleViewCreate {
    
    CGRect angleRect = CGRectMake(0, 0, 75, 75);
    self.angleRect = angleRect;
    
    for (NSInteger angleRectIndex = 0; angleRectIndex < 4; angleRectIndex++) {
        switch (angleRectIndex) {
            case 0:
                self.angleRect = angleRect;
                break;
            case 1:
                self.angleRect = CGRectMake(CGRectGetWidth(self.mainRect) - CGRectGetWidth(angleRect),
                                            angleRect.origin.y,
                                            CGRectGetWidth(angleRect),
                                            CGRectGetHeight(angleRect));
                break;
            case 2:
                self.angleRect = CGRectMake(CGRectGetWidth(self.mainRect) - CGRectGetWidth(angleRect),
                                            CGRectGetHeight(self.mainRect) - CGRectGetHeight(angleRect),
                                            CGRectGetWidth(angleRect),
                                            CGRectGetHeight(angleRect));
                break;
            case 3:
                self.angleRect = CGRectMake(angleRect.origin.x,
                                            CGRectGetHeight(self.mainRect) - CGRectGetHeight(angleRect),
                                            CGRectGetWidth(angleRect),
                                            CGRectGetHeight(angleRect));
                break;
            default:
                break;
        }
        UIView *view = [[UIView alloc] initWithFrame:self.angleRect];
        view.backgroundColor = [self.angleViewColors objectAtIndex:angleRectIndex];
        [self.angleViewArray addObject:view];
        [self.view addSubview:view];
    }
}


- (void) horizontalViewCreate {
    
    CGRect horizontalRect = CGRectMake(0, 0, 75, 75);
    CGFloat horizontalRectOfY = 0;
    CGFloat horizontalRectOfX = 0;
    
    for (NSInteger horizontalRectIndex = 0; horizontalRectIndex < 4; horizontalRectIndex++) {
        horizontalRectOfX = CGRectGetWidth(self.mainRect) - CGRectGetWidth(self.mainRect);
        horizontalRectOfY = CGRectGetMidY(self.mainRect) - (CGRectGetHeight(horizontalRect) * 2);
        horizontalRectOfY = horizontalRectOfY + CGRectGetHeight(horizontalRect) * horizontalRectIndex;
        self.horizontalRect = CGRectMake(horizontalRectOfX, horizontalRectOfY, CGRectGetWidth(horizontalRect), CGRectGetHeight(horizontalRect));
        UIView *view = [[UIView alloc] initWithFrame:self.horizontalRect];
        view.backgroundColor = [self randomColor];
        [self.horizontalViewArray addObject:view];
        [self.view addSubview:view];
    }
}

#pragma mark - Views Animations

- (void) angleViewAnimation {
    
    CGFloat randomScale = (float)(arc4random() % 151) / 100.f + 0.5f;
    CGFloat randomRotation = (float)(arc4random() % (int)(M_PI * 2*10000)) / 10000 - M_PI;
    CGFloat randomDuration = (float)(arc4random() % 15000 / 10000 + 0.5f);
    CGFloat randomRadius = (float)(arc4random() % 100);
    
    [UIView animateWithDuration:randomDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn //| UIViewAnimationOptionAutoreverse //| UIViewAnimationOptionRepeat
                     animations:^{
                         NSInteger variation = 1; //!!!!!!!!!!!!!!!!!!
                         
                         if (variation){
                             
                             UIView *tempView = [self.angleViewArray objectAtIndex:0];
                             CGPoint tempCenter = tempView.center;
                             
                             for (NSInteger angleViewIndex = 0; angleViewIndex < [self.angleViewArray count] - 1; angleViewIndex++) {
                                 UIView *view = [self.angleViewArray objectAtIndex:angleViewIndex];
                                 UIView *nextView = [self.angleViewArray objectAtIndex:angleViewIndex+1];
                                 [self.angleCenterViewArray addObject:NSStringFromCGPoint(view.center)];
                                 view.center = nextView.center;
                                 CGAffineTransform scale = CGAffineTransformMakeScale(randomScale, randomScale);
                                 CGAffineTransform rotation = CGAffineTransformMakeRotation(randomRotation);
                                 CGAffineTransform transform = CGAffineTransformConcat(scale, rotation);
                                 view.transform = transform;
                                 view.layer.cornerRadius = randomRadius;
                             }
                             //Double of CODE!
                             UIView *view = [self.angleViewArray objectAtIndex:[self.angleViewArray count] - 1];
                             [self.angleCenterViewArray addObject:NSStringFromCGPoint(view.center)];
                             view.center = tempCenter;
                             CGAffineTransform scale = CGAffineTransformMakeScale(randomScale, randomScale);
                             CGAffineTransform rotation = CGAffineTransformMakeRotation(randomRotation);
                             CGAffineTransform transform = CGAffineTransformConcat(scale, rotation);
                             view.transform = transform;
                             view.layer.cornerRadius = randomRadius;
                             
                         } else { // NOT WORKING!!!!
                             
                             UIView *tempView = [self.angleViewArray objectAtIndex:[self.angleViewArray count] - 1];
                             CGPoint tempCenter = tempView.center;
                             
                             for (NSInteger angleViewIndex = [self.angleViewArray count] - 1; angleViewIndex > 0; angleViewIndex--) {
                                 UIView *view = [self.angleViewArray objectAtIndex:angleViewIndex];
                                 UIView *nextView = [self.angleViewArray objectAtIndex:angleViewIndex-1];
                                 [self.angleCenterViewArray addObject:NSStringFromCGPoint(view.center)];
                                 view.center = nextView.center;
                             }
                             UIView *view = [self.angleViewArray objectAtIndex:[self.angleViewArray count] - 1];
                             [self.angleCenterViewArray addObject:NSStringFromCGPoint(view.center)];
                             view.center = tempCenter;
                         }
                     }
                     completion:^(BOOL finished) {
                         //NSLog(@"animation of angle views is finished! %d", finished);
//                         self.indexOfCreateAngleView++;
//                         if (self.indexOfCreateAngleView > 5){
//                             [self angleViewCreate];
//                             self.indexOfCreateAngleView = 0;
//                         }
                         [self angleViewAnimation];
                         self.view.backgroundColor = [self randomColor];
                     }];
}

- (void) horizontalViewAnimation {
    CGFloat randomScale = (float)(arc4random() % 151) / 100.f + 0.5f;
    CGFloat randomRotation = (float)(arc4random() % (int)(M_PI * 2*10000)) / 10000 - M_PI;
    CGFloat randomDuration = (float)(arc4random() % 15000 / 10000 + 0.5f);
    CGFloat randomRadius = (float)(arc4random() % 100);
    
    [UIView animateWithDuration:randomDuration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAutoreverse //| UIViewAnimationOptionRepeat
                     animations:^{
                         for (NSInteger index = 0;index < [self.horizontalViewArray count]; index++) {
                             UIView *view = [self.horizontalViewArray objectAtIndex:index];
                             [self.horizontalCenterViewArray addObject:NSStringFromCGPoint(view.center)];
                             view.center = CGPointMake(CGRectGetWidth(self.mainRect) - CGRectGetWidth(self.horizontalRect) / 2, view.center.y);
                             CGAffineTransform scale = CGAffineTransformMakeScale(randomScale, randomScale);
                             CGAffineTransform rotation = CGAffineTransformMakeRotation(randomRotation);
                             CGAffineTransform transform = CGAffineTransformConcat(scale, rotation);
                             view.transform = transform;
                             view.layer.cornerRadius = randomRadius;
                         }
                     }
                     completion:^(BOOL finished) {
                         //NSLog(@"animation of horizontal views is finished! %d", finished);
                         for (NSInteger index = 0; index < [self.horizontalViewArray count]; index++) {
                             UIView *view = [self.horizontalViewArray objectAtIndex:index];
                             view.center = CGPointFromString([self.horizontalCenterViewArray objectAtIndex:index]);
                             view.backgroundColor = [self randomColor];
                         }
//                         self.indexOfCreateHorizontalView++;
//                         if (self.indexOfCreateHorizontalView > 5){
//                             [self horizontalViewCreate];
//                             self.indexOfCreateHorizontalView = 0;
//                         }
                         [self horizontalViewAnimation];
                     }];
}

#pragma mark - Other functions

- (UIColor*) randomColor {
    CGFloat r = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat g = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat b = (CGFloat)(arc4random() % 256) / 255.f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
@end
