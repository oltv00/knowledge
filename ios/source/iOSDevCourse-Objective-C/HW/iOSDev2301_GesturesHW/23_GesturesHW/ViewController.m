//
//  ViewController.m
//  23_GesturesHW
//
//  Created by Oleg Tverdokhleb on 16.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "FLAnimatedImage.h"

typedef NS_ENUM(NSInteger, AnimationType) {
    AnimationTypeLeft,
    AnimationTypeRight
};

@interface ViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) UIView *mainView;
@property (assign, nonatomic) CGFloat mainViewRotation;
@property (assign, nonatomic) CGFloat mainViewScale;
@property (assign, nonatomic) NSInteger rotateIndex;
@property (assign, nonatomic) CGAffineTransform defaultTransform;
@property (assign, nonatomic) CGPoint defaultPosition;
@end

@implementation ViewController

#pragma mark - LifeCycles
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initial];
    [self initialImage];
    [self initialTapGesture];
    [self initialSwipeGesture];
    [self initialPinchGesture];
    [self initialRotationGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initial
- (void)initial {
    self.rotateIndex = 0;
    self.view.backgroundColor = [UIColor colorWithRed:249.f/255 green:250.f/255 blue:249.f/255 alpha:1.f];
}

- (void)initialImage {
    NSString *str = [[NSBundle mainBundle] pathForResource:@"giphy" ofType:@"gif"];
    NSData *fileData = [NSData dataWithContentsOfFile:str];
    
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:fileData];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = width;
    CGFloat x = CGRectGetMidX(self.view.bounds) - width / 2;
    CGFloat y = CGRectGetMidY(self.view.bounds) - height / 2;
    
    imageView.frame = CGRectMake(x, y, width, height);
    [self.view addSubview:imageView];
    self.mainView = imageView;
    self.defaultTransform = self.mainView.transform;
    self.defaultPosition = self.mainView.center;
}

- (void)initialTapGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTapGesture];
    
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
}

- (void)initialSwipeGesture {
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
}

- (void)initialPinchGesture {
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    [self.view addGestureRecognizer:pinchGesture];
}

- (void)initialRotationGesture {
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    rotationGesture.delegate = self;
    [self.view addGestureRecognizer:rotationGesture];
}

#pragma mark - Additional
- (void)rotateView:(UIView *)view toAngle:(CGFloat)angle {
    NSLog(@"Rotate index: %ld", self.rotateIndex);
    if (self.rotateIndex == 0) {
        [UIView animateWithDuration:1.f animations:^{
            self.mainView.transform = self.defaultTransform;
        }];
        return;
    }
    [UIView animateWithDuration:1.f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [view setTransform:CGAffineTransformRotate(view.transform, angle)];
    } completion:^(BOOL finished) {
        if (finished && !CGAffineTransformEqualToTransform(view.transform, CGAffineTransformIdentity)) {
            [self rotateView:view toAngle:angle];
        }
    }];
}

#pragma mark - Gestures
- (void)handleTap:(UITapGestureRecognizer *)tap {
    NSLog(@"handleTapGesture %@", NSStringFromCGPoint([tap locationInView:self.view]));
    [UIView animateWithDuration:1.f animations:^{
        self.mainView.center = [tap locationInView:self.view];
    }];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)doubleTap {
    NSLog(@"handleDoubleTap");
    
    [UIView animateWithDuration:1.f animations:^{
        self.mainView.transform = self.defaultTransform;
        self.mainView.center = self.defaultPosition;
    }];
}

- (void)handleLeftSwipe:(UISwipeGestureRecognizer *)swipe {
    NSLog(@"handleLeftSwipe");
    self.rotateIndex -= 1;
    [self rotateView:self.mainView toAngle:-M_PI_2];
}

- (void)handleRightSwipe:(UISwipeGestureRecognizer *)swipe {
    NSLog(@"handleRightSwipe");
    self.rotateIndex += 1;
    [self rotateView:self.mainView toAngle:M_PI_2];
}

- (void)handlePinch:(UIPinchGestureRecognizer *)pinch {
    NSLog(@"handlePinch");
    if (pinch.state == UIGestureRecognizerStateBegan) {
        self.mainViewScale = 1.f;
    }
    
    CGFloat dScale = 1.f + pinch.scale - self.mainViewScale;
    CGAffineTransform transform = self.mainView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(transform, dScale, dScale);
    
    self.mainView.transform = newTransform;
    self.mainViewScale = pinch.scale;
}

- (void)handleRotation:(UIRotationGestureRecognizer *)rotationGesture {
    NSLog(@"handleRotation: %1.3f", rotationGesture.rotation);
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.mainViewRotation = 0.f;
    }
    
    CGFloat dRotation = rotationGesture.rotation - self.mainViewRotation;
    CGAffineTransform transform = self.mainView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(transform, dRotation);
    
    self.mainView.transform = newTransform;
    self.mainViewRotation = rotationGesture.rotation;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
