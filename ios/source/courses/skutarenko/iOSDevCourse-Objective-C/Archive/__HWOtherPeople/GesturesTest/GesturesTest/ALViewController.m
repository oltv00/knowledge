//
//  ALViewController.m
//  GesturesTest
//
//  Created by Линник Александр on 03.01.14.
//  Copyright (c) 2014 Alex Linnik. All rights reserved.
//

#import "ALViewController.h"

@interface ALViewController () <UIGestureRecognizerDelegate>

@property (weak,nonatomic) UIView* testView;
@property (assign, nonatomic) CGFloat testViewScale;
@property (assign, nonatomic) CGFloat testViewRotation;

@end



@implementation ALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor clearColor];
    UIImage* image = [UIImage imageNamed:@"ball.png"];
    UIImageView* airplane = [[UIImageView alloc] initWithImage:image];
    airplane.frame = CGRectMake(0, 0, 100, 100);
    [view addSubview:airplane];
    [self.view addSubview:view];
    self.testView = view;
    
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|
                            UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    
    UITapGestureRecognizer* doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                      action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleTapGesture];
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    
    UISwipeGestureRecognizer* leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                          action:@selector(handleLeftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    
    UISwipeGestureRecognizer* rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                           action:@selector(handlRightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
    
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self
                                                                                      action:@selector(handlPinch:)];
    pinchGesture.delegate = self;
    [self.view addGestureRecognizer:pinchGesture];
    
    
    UIRotationGestureRecognizer* rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handlRotation:)];
    rotationGesture.delegate = self;
    [self.view addGestureRecognizer:rotationGesture];
}

#pragma mark - Gestures

-(void) handleTap: (UITapGestureRecognizer*) tapGesture{
    
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationCurveLinear|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.testView.center = [tapGesture locationInView:self.view];
                     } completion:^(BOOL finished) {
                         
                     }];
}


-(void) handleDoubleTap: (UITapGestureRecognizer*) doubleTapGesture{
    
    [self.testView.layer removeAllAnimations];
}


-(void) handleLeftSwipe: (UISwipeGestureRecognizer*) leftSwipeGesture{
    
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, 3.14);
    
    [UIView animateKeyframesWithDuration:0.6
                                   delay:0
                                 options:UIViewAnimationCurveLinear|UIViewAnimationOptionBeginFromCurrentState
                              animations:^{
                                  self.testView.transform = newTransform;
                              }
                              completion:^(BOOL finished) {
                                  
                              }];
    
}


-(void) handlRightSwipe: (UISwipeGestureRecognizer*) rightSwipeGesture{
    
    
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, -3.14);
    
    [UIView animateKeyframesWithDuration:0.6
                                   delay:0
                                 options:UIViewAnimationCurveLinear|UIViewAnimationOptionBeginFromCurrentState
                              animations:^{
                                  self.testView.transform = newTransform;
                              }
                              completion:^(BOOL finished) {
                                  
                              }];
}


-(void) handlPinch: (UIPinchGestureRecognizer*) pinchGesture {
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewScale = 1.f;
    }
    
    CGFloat newScale = 1.f + pinchGesture.scale - self.testViewScale;
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    self.testView.transform = newTransform;
    self.testViewScale = pinchGesture.scale;
    
}


-(void) handlRotation: (UIRotationGestureRecognizer*)rotationGesture {
    
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewRotation = 0;
    }
    
    CGFloat newRotation = rotationGesture.rotation - self.testViewRotation;
    
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
    
    self.testView.transform = newTransform;
    
    self.testViewRotation = rotationGesture.rotation;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
