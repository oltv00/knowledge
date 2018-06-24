//
//  ViewController.m
//  23_GesturesTestRestoProg
//
//  Created by Oleg Tverdokhleb on 11.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIImageView *PPTYpacmanImage;

@property (strong, nonatomic) NSArray *PPTYrightPacmanAnimateArray;
@property (strong, nonatomic) NSArray *PPTYleftPacmanAnimateArray;
@property (strong, nonatomic) NSArray *PPTYupPacmanAnimateArray;
@property (strong, nonatomic) NSArray *PPTYdownPacmanAnimateArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self pacmanInit];
    [self diedView];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *upSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *downSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    upSwipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
    downSwipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:rightSwipeGesture];
    [self.view addGestureRecognizer:leftSwipeGesture];
    [self.view addGestureRecognizer:upSwipeGesture];
    [self.view addGestureRecognizer:downSwipeGesture];
    
}

#pragma mark - Gestures

- (void) handleSwipe:(UISwipeGestureRecognizer*) swipeGesture {
    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionRight) {
        [self rightPacmanMove];
    }
    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self leftPacmanMove];
    }
    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionUp) {
        [self upPacmanMove];
    }
    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionDown) {
        [self downPacmanMove];
    }
}

#pragma mark - My methods

- (void) attackViewCreate {
    
    CGFloat xAttackViewCoordinate = arc4random() % (int)CGRectGetWidth(self.view.bounds);
    CGFloat yAttackViewCoordinate = arc4random() % (int)CGRectGetHeight(self.view.bounds);
    
    CGRect attackRect = CGRectMake(xAttackViewCoordinate, yAttackViewCoordinate, 50, 50);
    
    UIView *view = [[UIView alloc] initWithFrame:attackRect];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
}

- (void) diedView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    BOOL diedChance = CGRectContainsRect(self.PPTYpacmanImage.frame, view.frame);
    
    if (diedChance == YES) {
        [self.view willRemoveSubview:view];
    }
    
}

- (void) leftPacmanMove {

    self.PPTYpacmanImage.animationImages = self.PPTYleftPacmanAnimateArray;
    self.PPTYpacmanImage.animationDuration = 0.5f;
    [self.PPTYpacmanImage startAnimating];
    
    [UIImageView animateWithDuration:3
                               delay:0
                             options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                          animations:^{
                              self.PPTYpacmanImage.center = CGPointMake(CGRectGetWidth(self.PPTYpacmanImage.frame) / 2,
                                                                   self.PPTYpacmanImage.frame.origin.y + CGRectGetHeight(self.PPTYpacmanImage.frame) / 2);
                              [self.PPTYpacmanImage layoutIfNeeded];
                          }
                          completion:^(BOOL finished) {
                              
                          }];
}

- (void) rightPacmanMove {
    
    self.PPTYpacmanImage.animationImages = self.PPTYrightPacmanAnimateArray;
    self.PPTYpacmanImage.animationDuration = 0.5f;
    [self.PPTYpacmanImage startAnimating];
    
    [UIImageView animateWithDuration:3
                               delay:0
                             options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                          animations:^{
                              self.PPTYpacmanImage.center = CGPointMake(CGRectGetWidth(self.view.frame) - CGRectGetWidth(self.PPTYpacmanImage.frame) / 2,
                                                                        self.PPTYpacmanImage.frame.origin.y + CGRectGetHeight(self.PPTYpacmanImage.frame) / 2);
                              [self.PPTYpacmanImage layoutIfNeeded];
                          }
                          completion:^(BOOL finished) {
                              
                          }];
}

- (void) downPacmanMove {
    
    self.PPTYpacmanImage.animationImages = self.PPTYdownPacmanAnimateArray;
    self.PPTYpacmanImage.animationDuration = 0.5f;
    [self.PPTYpacmanImage startAnimating];
    
    [UIImageView animateWithDuration:3
                               delay:0
                             options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                          animations:^{
                              self.PPTYpacmanImage.center = CGPointMake(self.PPTYpacmanImage.frame.origin.x + CGRectGetWidth(self.PPTYpacmanImage.frame) / 2,
                                                                   CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.PPTYpacmanImage.frame) / 2);
                              [self.PPTYpacmanImage layoutIfNeeded];
                          }
                          completion:^(BOOL finished) {
                              
                          }];
}

- (void) upPacmanMove {
    
    self.PPTYpacmanImage.animationImages = self.PPTYupPacmanAnimateArray;
    self.PPTYpacmanImage.animationDuration = 0.5f;
    [self.PPTYpacmanImage startAnimating];
    
    [UIImageView animateWithDuration:3
                               delay:0
                             options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                          animations:^{
                              self.PPTYpacmanImage.center = CGPointMake(self.PPTYpacmanImage.frame.origin.x + CGRectGetWidth(self.PPTYpacmanImage.frame) / 2,
                                                                   CGRectGetHeight(self.PPTYpacmanImage.frame) / 2);
                              [self.PPTYpacmanImage layoutIfNeeded];
                          }
                          completion:^(BOOL finished) {
                              
                          }];
}

- (void) pacmanInit {
    
    UIImageView *pacmanInit = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    pacmanInit.backgroundColor = [UIColor clearColor];
    
    UIImage *pacmanCloseDown = [UIImage imageNamed:@"pacmanCloseDown.png"];
    UIImage *pacmanOpenDown =       [UIImage imageNamed:@"pacmanOpenDown.png"];
    
    UIImage *pacmanCloseLeft =      [UIImage imageNamed:@"pacmanCloseLeft.png"];
    UIImage *pacmanOpenLeft =       [UIImage imageNamed:@"pacmanOpenLeft.png"];
    
    UIImage *pacmanCloseRight =     [UIImage imageNamed:@"pacmanCloseRight.png"];
    UIImage *pacmanOpenRight =      [UIImage imageNamed:@"pacmanOpenRight.png"];
    
    UIImage *pacmanCloseUp =        [UIImage imageNamed:@"pacmanCloseUp.png"];
    UIImage *pacmanOpenUp =         [UIImage imageNamed:@"pacmanOpenUp.png"];
    
    NSArray *pacmanDownAnimate =    [NSArray arrayWithObjects:pacmanCloseDown, pacmanOpenDown, nil];
    NSArray *pacmanLeftAnimate =    [NSArray arrayWithObjects:pacmanCloseLeft, pacmanOpenLeft, nil];
    NSArray *pacmanRightAnimate =   [NSArray arrayWithObjects:pacmanCloseRight, pacmanOpenRight, nil];
    NSArray *pacmanUpAnimate =      [NSArray arrayWithObjects:pacmanCloseUp, pacmanOpenUp, nil];
    
    self.PPTYdownPacmanAnimateArray = pacmanDownAnimate;
    self.PPTYleftPacmanAnimateArray = pacmanLeftAnimate;
    self.PPTYrightPacmanAnimateArray = pacmanRightAnimate;
    self.PPTYupPacmanAnimateArray = pacmanUpAnimate;
    
    pacmanInit.animationImages = pacmanRightAnimate;
    pacmanInit.animationDuration = 0.5f;
    [pacmanInit startAnimating];
    
    [self.view addSubview:pacmanInit];
    self.PPTYpacmanImage = pacmanInit;
}
@end
