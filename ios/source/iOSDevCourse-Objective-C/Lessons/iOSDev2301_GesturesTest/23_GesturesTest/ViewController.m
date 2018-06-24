//
//  ViewController.m
//  23_GesturesTest
//
//  Created by Oleg Tverdokhleb on 16.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) UIView *testView;
@property (assign, nonatomic) CGFloat testViewScale;
@property (assign, nonatomic) CGFloat testViewRotation;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initialTapGesture];
    [self initialPinchGesture];
    [self initialRotationGesture];
    [self initialPanGesture];
    [self initialSwipeGesture];
}

- (void)initialSwipeGesture {
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipeGesture:)];
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipeGesture:)];
    UISwipeGestureRecognizer *downSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleDownSwipeGesture:)];
    UISwipeGestureRecognizer *UpSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleUpSwipeGesture:)];

    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    downSwipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    UpSwipeGesture.direction = UISwipeGestureRecognizerDirectionUp;

    leftSwipeGesture.delegate = self;
    rightSwipeGesture.delegate = self;
    downSwipeGesture.delegate = self;
    UpSwipeGesture.delegate = self;
    
    [self.view addGestureRecognizer:leftSwipeGesture];
    [self.view addGestureRecognizer:rightSwipeGesture];
    [self.view addGestureRecognizer:downSwipeGesture];
    [self.view addGestureRecognizer:UpSwipeGesture];

}

- (void)initialPanGesture {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
}

- (void)initialRotationGesture {
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    rotationGesture.delegate = self;
    [self.view addGestureRecognizer:rotationGesture];
}

- (void)initialPinchGesture {
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    [self.view addGestureRecognizer:pinchGesture];
}

- (void)initialTapGesture {
    CGFloat proportions = 3;
    CGFloat width = CGRectGetWidth(self.view.frame) / proportions;
    CGFloat height = width;
    CGFloat x = CGRectGetMidX(self.view.bounds) - width / 2;
    CGFloat y = CGRectGetMidY(self.view.bounds) - height / 2;
    CGRect frame = CGRectMake(x, y, width, height);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    self.testView = view;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTapGesture];
    
    //установка ожидания для двойного тапа
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    UITapGestureRecognizer *doubleTapDoubleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapDoubleTouch:)];
    doubleTapDoubleTouch.numberOfTapsRequired = 2;
    doubleTapDoubleTouch.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleTapDoubleTouch];
}

#pragma mark - Gestures
- (void)handleTap:(UITapGestureRecognizer *)tapGesture {
    NSLog(@"Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    [UIView animateWithDuration:0.3f animations:^{
        self.testView.backgroundColor = [self randomColor];
    }];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tapGesture {
    NSLog(@"Double tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    CGAffineTransform transform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(transform, 1.2f, 1.2f);

    [UIView animateWithDuration:0.3f animations:^{
        self.testView.transform = newTransform;
    }];
    self.testViewScale = 1.2f;
}

- (void)handleDoubleTapDoubleTouch:(UITapGestureRecognizer *)tapGesture {
    NSLog(@"Double tap double touch: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    CGAffineTransform transform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(transform, 0.8f, 0.8f);
    
    [UIView animateWithDuration:0.3f animations:^{
        self.testView.transform = newTransform;
    }];
    self.testViewScale = 0.8f;
}

- (void)handlePinch:(UIPinchGestureRecognizer *)pinchGesture {
    NSLog(@"handlePinch %1.3f", pinchGesture.scale);
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewScale = 1.f;
    }
    
    CGFloat dScale = 1.f + pinchGesture.scale - self.testViewScale;
    CGAffineTransform currentTransfrom = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransfrom, dScale, dScale);
    
    self.testView.transform = newTransform;
    self.testViewScale = pinchGesture.scale;
}

- (void)handleRotation:(UIRotationGestureRecognizer *)rotationGesture {
    NSLog(@"handleRotation %1.3f", rotationGesture.rotation);
    
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewRotation = 0;
    }
    
    CGFloat dRotation = rotationGesture.rotation - self.testViewRotation;
    CGAffineTransform currentTransfrom = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransfrom, dRotation);
    
    self.testView.transform = newTransform;
    self.testViewRotation = rotationGesture.rotation;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    NSLog(@"handlePanGesture %@", NSStringFromCGPoint([panGesture translationInView:self.view]));
    
    [UIView animateWithDuration:0.3f animations:^{
        self.testView.center = [panGesture locationInView:self.view];
    }];
}

- (void)handleLeftSwipeGesture:(UISwipeGestureRecognizer *)swipe {
    NSLog(@"handleLeftSwipeGesture");
    CGPoint startPoint = self.testView.center;
    
    CGFloat x = CGRectGetWidth(self.testView.frame) / 2;
    CGFloat y = CGRectGetMidY(self.testView.frame);
    CGPoint point = CGPointMake(x, y);
    
    [UIView animateWithDuration:0.3f animations:^{
        self.testView.center = point;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f animations:^{
            self.testView.center = startPoint;
        }];
    }];
}

- (void)handleRightSwipeGesture:(UISwipeGestureRecognizer *)swipe {
    NSLog(@"handleRightSwipeGesture");
}

- (void)handleUpSwipeGesture:(UISwipeGestureRecognizer *)swipe {
    NSLog(@"handleUpSwipeGesture");
}

- (void)handleDownSwipeGesture:(UISwipeGestureRecognizer *)swipe {
    NSLog(@"handleDownSwipeGesture");
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]];
}

#pragma mark - Additional
- (UIColor *)randomColor {
    CGFloat r = (CGFloat)arc4random_uniform(256) / 255;
    CGFloat g = (CGFloat)arc4random_uniform(256) / 255;
    CGFloat b = (CGFloat)arc4random_uniform(256) / 255;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}
@end
