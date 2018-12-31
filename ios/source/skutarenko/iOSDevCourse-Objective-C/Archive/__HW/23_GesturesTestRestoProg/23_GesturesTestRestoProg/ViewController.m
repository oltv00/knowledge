//
//  ViewController.m
//  23_GesturesTestRestoProg
//
//  Created by Oleg Tverdokhleb on 11.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIImageView* totoroImageView;

@property (assign, nonatomic) NSInteger swipeCounting;
@property (assign, nonatomic) CGFloat viewScale;
@property (assign, nonatomic) CGFloat viewRotation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self totoroCreate];
    
    //Tap gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    //Left swipe gesture
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    //Right swipe gesture
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(handleSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
    
    //Pinch gesture
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    [self.view addGestureRecognizer:pinchGesture];
    
    //Rotation gesture
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleRotation:)];
    rotationGesture.delegate = self;
    [self.view addGestureRecognizer:rotationGesture];
    
    //realised double tap
    //self.imageview removeAllAnimations;
    //Double tam gesture
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTapGesture];
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
}

#pragma mark - Gestures

- (void) handleTap:(UITapGestureRecognizer*) tapGesture {
    
    [UIImageView animateWithDuration:2.f
                               delay:0
                             options:UIViewAnimationOptionBeginFromCurrentState
                          animations:^{
                              self.totoroImageView.center = [tapGesture locationInView:self.view];
                          }
                          completion:^(BOOL finished) {
                          }];
}

- (void) handleSwipe:(UISwipeGestureRecognizer*) swipeGesture {
    
    NSLog(@"handleSwipe");
    
    CGFloat angleOfRotation = 2 * M_PI / 3.f;
    
    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionRight) {
        [self swipeRotation:angleOfRotation];
    } else {
        [self swipeRotation:-angleOfRotation];
    }
}

- (void) handlePinch:(UIPinchGestureRecognizer*) pinchGesture {
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.viewScale = 1.f;
    }
    CGFloat newScale = 1.f + pinchGesture.scale - self.viewScale;
    CGAffineTransform currentTransform = self.totoroImageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    self.totoroImageView.transform = newTransform;
    self.viewScale = pinchGesture.scale;
}

- (void) handleRotation:(UIRotationGestureRecognizer*) rotationGesture {
    
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.viewRotation = 0;
    }
    CGFloat newRotation = rotationGesture.rotation - self.viewRotation;
    CGAffineTransform currentTransform = self.totoroImageView.transform;
    CGAffineTransform newTranstorm = CGAffineTransformRotate(currentTransform, newRotation);
    self.totoroImageView.transform = newTranstorm;
    self.viewRotation = rotationGesture.rotation;
}

- (void) handleDoubleTap:(UITapGestureRecognizer*) doubleTapGesture {
    
    [self.totoroImageView.layer removeAllAnimations];
}
#pragma mark - My methods

- (void) totoroCreate {
    
    UIImageView *totoroImage = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    totoroImage.backgroundColor = [UIColor clearColor];
    
    UIImage *center = [UIImage imageNamed:@"center.png"];
    
    UIImage *left1 = [UIImage imageNamed:@"left1.png"];
    UIImage *left2 = [UIImage imageNamed:@"left2.png"];
    UIImage *left3 = [UIImage imageNamed:@"left3.png"];
    UIImage *left4 = [UIImage imageNamed:@"left4.png"];
    
    UIImage *right1 = [UIImage imageNamed:@"right1.png"];
    UIImage *right2 = [UIImage imageNamed:@"right2.png"];
    UIImage *right3 = [UIImage imageNamed:@"right3.png"];
    UIImage *right4 = [UIImage imageNamed:@"right4.png"];
    
    NSArray *totoroAnimateArray = [NSArray arrayWithObjects:center, right1, right2, right3, right4, right3, right2, right1 ,
                                   center , left1, left2, left3, left4, left3, left2, left1, nil];
    
    totoroImage.animationImages = totoroAnimateArray;
    totoroImage.animationDuration = 1.f;
    [totoroImage startAnimating];
    
    [self.view addSubview:totoroImage];
    self.totoroImageView = totoroImage;
}

- (void) swipeRotation:(CGFloat) toAngle {
    
    while (self.swipeCounting < 3) {
        [UIImageView animateWithDuration:2.f
                                   delay:0
                                 options:UIViewAnimationOptionLayoutSubviews
                              animations:^{
                                  CGAffineTransform rotation = CGAffineTransformRotate(self.totoroImageView.transform, toAngle);
                                  self.totoroImageView.transform = rotation;
                                  self.swipeCounting += 1;
                              }
                              completion:^(BOOL finished) {
                                  self.swipeCounting = 0;
                              }];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
