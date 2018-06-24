//
//  ViewController.m
//  23_GesturesTest
//
//  Created by Oleg Tverdokhleb on 10.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIView *singleView;
@property (assign, nonatomic) CGFloat singleViewScale;
@property (assign, nonatomic) CGFloat singleVIewRotation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //View create
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds) - 50,
                                                           CGRectGetMidY(self.view.bounds) - 50,
                                                           100, 100)];
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                            UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    view.backgroundColor = [self randomColor];
    [self.view addSubview:view];
    self.singleView = view;
    
    //Tap gesture create
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleTap:)];
    //tapGesture.numberOfTapsRequired = 2;
    //tapGesture.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:tapGesture];
    
    //Double tap gesture create
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTapGesture];

    // tapGesture не сработает пока не сработает doubleTapGesture
    // tapGesture не срабоает пока есть возможность сделать doubleTapGesture
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    //Double tap double touch gesture create
    UITapGestureRecognizer *doubleTapDoubleTouchGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleDoubleTapDoubleTouch:)];
    doubleTapDoubleTouchGesture.numberOfTapsRequired = 2;      // Сколько раз тапнуть
    doubleTapDoubleTouchGesture.numberOfTouchesRequired = 2;   // Колисество тачей (пальцев)
    [self.view addGestureRecognizer:doubleTapDoubleTouchGesture];
    
    //Long press gesture create
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(handleLongPress:)];
    [self.view addGestureRecognizer:longPressGesture];
    
    //Pinch gesture create
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    [self.view addGestureRecognizer:pinchGesture];
    
    //Rotation gesture create
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                                action:@selector(handleRotation:)];
    rotationGesture.delegate = self;
    [self.view addGestureRecognizer:rotationGesture];
    
    //Pan gesture create
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handlePan:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    
    //Up swipe gesture create
    UISwipeGestureRecognizer *upSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(handleUpSwipe:)];
    upSwipeGesture.delegate = self;
    upSwipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:upSwipeGesture];
    
    //Down swipe gesture create
    UISwipeGestureRecognizer *downSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleDownSwipe:)];
    downSwipeGesture.delegate = self;
    downSwipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:downSwipeGesture];
    
    //Left swipe gesture create
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(handleLeftSwipe:)];
    leftSwipeGesture.delegate = self;
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    //Right swipe gesture create
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(handleRightSwipe:)];
    rightSwipeGesture.delegate = self;
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
}

#pragma mark - Methods

- (UIColor*) randomColor {
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

- (void) changeScaleOnView:(UIView*) view toScale:(CGFloat) scale {
    
    CGAffineTransform currentTransform = view.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [UIView animateWithDuration:0.3
                     animations:^{
                         view.transform = newTransform;
                     }];
}

#pragma mark - Gestures

- (void) handleTap:(UITapGestureRecognizer*) tapGesture {
    
    NSLog(@"Tap in self.view: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    self.singleView.backgroundColor = [self randomColor];
}

- (void) handleDoubleTap:(UITapGestureRecognizer*) tapGesture {
    
    NSLog(@"Double tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    [self changeScaleOnView:self.singleView toScale:1.2f];
    self.singleViewScale = 1.2f;
}

- (void) handleDoubleTapDoubleTouch:(UITapGestureRecognizer*) tapGesture {
    
    NSLog(@"Double tap, double touch: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    [self changeScaleOnView:self.singleView toScale:0.8f];
    self.singleViewScale = 0.8f;
}

- (void) handleLongPress:(UILongPressGestureRecognizer*) longPressGesture {

    NSLog(@"Long press: %@", NSStringFromCGPoint([longPressGesture locationInView:self.view]));
}

- (void) handlePinch:(UIPinchGestureRecognizer*) pinchGesture {
    
    NSLog(@"Pinch gesture scale: %1.3f", pinchGesture.scale);
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.singleViewScale = 1.f;
    }
    CGFloat newScale = 1.f + pinchGesture.scale - self.singleViewScale;
    CGAffineTransform currentTransform = self.singleView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    self.singleView.transform = newTransform;
    self.singleViewScale = pinchGesture.scale;
}

- (void) handleRotation:(UIRotationGestureRecognizer*) rotationGesture {
    
    NSLog(@"Rotation gesture %1.3f", rotationGesture.rotation);
    
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.singleVIewRotation = 0;
    }
    CGFloat newRotation = rotationGesture.rotation - self.singleVIewRotation;
    CGAffineTransform currentTransform = self.singleView.transform;
    CGAffineTransform newTranstorm = CGAffineTransformRotate(currentTransform, newRotation);
    self.singleView.transform = newTranstorm;
    self.singleVIewRotation = rotationGesture.rotation;
}

- (void) handlePan:(UIPanGestureRecognizer*) panGesture {
    NSLog(@"Pan gesture");
    
    self.singleView.center = [panGesture locationInView:self.view];
}

- (void) handleUpSwipe:(UISwipeGestureRecognizer*) swipeGesture {
    NSLog(@"handleUpSwipe");
    
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.singleView.center = CGPointMake(self.singleView.frame.origin.x + CGRectGetWidth(self.singleView.frame) / 2,
                                                              CGRectGetHeight(self.singleView.frame) / 2);
                         [self.singleView layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         //self.singleView.center = lastCenter;
                     }];
}

- (void) handleDownSwipe:(UISwipeGestureRecognizer*) swipeGesture {
    NSLog(@"handleDownSwipe");
    
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.singleView.center = CGPointMake(self.singleView.frame.origin.x + CGRectGetWidth(self.singleView.frame) / 2,
                                                              CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.singleView.frame) / 2);
                     }
                     completion:^(BOOL finished) {
                         //self.singleView.center = lastCenter;
                     }];
}

- (void) handleLeftSwipe:(UISwipeGestureRecognizer*) swipeGesture {
    NSLog(@"handleLeftSwipe");
    
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.singleView.center = CGPointMake(CGRectGetWidth(self.singleView.frame) / 2,
                                                              self.singleView.frame.origin.y + CGRectGetHeight(self.singleView.frame) / 2);
                     }
                     completion:^(BOOL finished) {
                         //self.singleView.center = lastCenter;
                     }];
}

- (void) handleRightSwipe:(UISwipeGestureRecognizer*) swipeGesture {
    NSLog(@"handleRightSwipe");
    
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.singleView.center = CGPointMake(CGRectGetWidth(self.view.frame) - CGRectGetWidth(self.singleView.frame) / 2,
                                                              self.singleView.frame.origin.y + CGRectGetHeight(self.singleView.frame) / 2);
                         [self.singleView layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         //self.singleView.center = lastCenter;
                     }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]];
}
@end
