//
//  ViewController.m
//  21_AnimationsHW
//
//  Created by Oleg Tverdokhleb on 12.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(BOOL, CornerViewDirection) {
    CornerViewDirectionClockWise = YES,
    CornerViewDirectionCounterClockWise = NO
};

NSString *const CornerViewRed       = @"CornerViewRed";
NSString *const CornerViewYellow    = @"CornerViewYellow";
NSString *const CornerViewBlue      = @"CornerViewBlue";
NSString *const CornerViewGreen     = @"CornerViewGreen";

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *leftSideViews;
@property (strong, nonatomic) NSMutableArray *cornerViews;
@property (strong, nonatomic) NSMutableDictionary *cornerViewsAndKeys;
@property (strong, nonatomic) NSMutableDictionary *cornerViewCoordinates;
@property (strong, nonatomic) NSArray *imagesArray;
@property (assign, nonatomic) NSInteger cornerAnimationCounter;
@property (assign, nonatomic) NSInteger leftSideAnimationCounter;
@property (assign, nonatomic) CornerViewDirection cornerViewDirection;
@property (assign, nonatomic) CGFloat animationDuration;
@end

@implementation ViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initial];
    [self initialLeftSideViews];
    [self initialCornerViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //actions
    [self viewsStartMove];
}

- (void)viewsStartMove {
    [self moveLeftSideViews];
    [self moveCornerViews];
}

#pragma mark - Initial
- (void)initial {
    self.imagesArray = @[[UIImage imageNamed:@"1.png"], [UIImage imageNamed:@"2.png"], [UIImage imageNamed:@"3.png"]];
    self.leftSideViews = [NSMutableArray array];
    self.cornerViews = [NSMutableArray array];
    self.cornerViewCoordinates = [NSMutableDictionary dictionary];
    self.cornerViewsAndKeys = [NSMutableDictionary dictionary];
    self.cornerAnimationCounter = 0;
    self.leftSideAnimationCounter = 0;
    self.animationDuration = 1.f;
}

- (void)initialLeftSideViews {
    for (int delta = 2; delta > -2; delta -= 1) {
        CGFloat viewWidth = 80;
        CGFloat viewHeight = 80;
        CGFloat x = 0;
        CGFloat y = CGRectGetMidY(self.view.frame) - delta * viewWidth;
        CGRect viewFrame = CGRectMake(x, y, viewWidth, viewHeight);
        UIImageView *view = [[UIImageView alloc] initWithFrame:viewFrame];
        view.backgroundColor = [self randomColor];
        
        view.animationImages = self.imagesArray;
        view.animationDuration = self.animationDuration;
        [view startAnimating];
        
        [self.view addSubview:view];
        [self.leftSideViews addObject:view];
    }
}

- (void)initialCornerViews {
    //Добавьте еще четыре квадратные вьюхи по углам - красную, желтую, зеленую и синюю
    CGFloat width = 80;
    CGFloat height = 80;
    CGRect viewFrame = CGRectZero;
    
    NSString *keyView = nil;
    UIColor *red = [UIColor redColor];
    UIColor *yellow = [UIColor yellowColor];
    UIColor *green = [UIColor greenColor];
    UIColor *blue = [UIColor blueColor];
    NSArray *colors = @[red, yellow, blue, green];
    for (int frameIndex = 0; frameIndex < 4; frameIndex += 1) {
        switch (frameIndex) {
            case 0:
                //red view
                viewFrame = CGRectMake(0, 0, width, height);
                keyView = CornerViewRed;
                break;
            case 1:
                //yellow view
                keyView = CornerViewYellow;
                viewFrame = CGRectMake(CGRectGetWidth(self.view.frame) - width, 0, width, height);
                break;
            case 2:
                //blue view
                keyView = CornerViewBlue;
                viewFrame = CGRectMake(CGRectGetWidth(self.view.frame) - width, CGRectGetHeight(self.view.frame) - height, width, height);
                break;
            case 3:
                //green view
                keyView = CornerViewGreen;
                viewFrame = CGRectMake(0, CGRectGetHeight(self.view.frame) - height, width, height);
                break;
            default:
                NSLog(@"initialCornerViews WARNING");
        }
        UIImageView *view = [[UIImageView alloc] initWithFrame:viewFrame];
        view.backgroundColor = colors[frameIndex];
        
        view.animationImages = self.imagesArray;
        view.animationDuration = self.animationDuration;
        [view startAnimating];
        
        [self.view addSubview:view];
        [self.cornerViews addObject:view];
        [self.cornerViewsAndKeys setObject:view forKey:keyView];
        [self.cornerViewCoordinates setObject:NSStringFromCGPoint(view.center) forKey:keyView];
    }
}

#pragma mark - Action
- (void)moveLeftSideViews {
    for (UIView *view in self.leftSideViews) {
        NSUInteger animationSet = [self leftSideViewsAnimationConfigure];
        [self moveLeftSideView:view withAnimationSet:animationSet];
    }
}

- (void)moveLeftSideView:(UIView *)view withAnimationSet:(UIViewAnimationOptions)animationSet {
    [UIView animateWithDuration:self.animationDuration delay:0 options:animationSet animations:^{
        CGFloat x = CGRectGetWidth(self.view.frame) - CGRectGetWidth(view.frame) / 2;
        CGFloat y = view.center.y;
        CGPoint moveToPoint = CGPointMake(x, y);
        view.center = moveToPoint;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)moveCornerViews {
    self.animationDuration = 1.f + arc4random_uniform(10000) / 10000;
    NSArray *arrayToMove = [self randomClockWiseCornerViewsMove];
    for (int i = 0; i < [self.cornerViews count]; i += 1) {
        [self moveCornerView:self.cornerViews[i] toPoint:CGPointFromString(arrayToMove[i])];
    }
}

- (void)moveCornerView:(UIView *)view toPoint:(CGPoint)point {
    NSLog(@"Move %@ to %@", NSStringFromCGPoint(view.center), NSStringFromCGPoint(point));
    __weak id weakSelf = self;
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.center = point;
    } completion:^(BOOL finished) {
        self.cornerAnimationCounter += 1;
        if (self.cornerAnimationCounter % 4 == 0) {
            NSLog(@"Corner counter = %ld",self.cornerAnimationCounter);
            [weakSelf viewsStartMove];
        }
    }];
}

#pragma mark - Additional
- (UIColor *)randomColor {
    CGFloat r = (CGFloat)arc4random_uniform(256) / 255.f;
    CGFloat g = (CGFloat)arc4random_uniform(256) / 255.f;
    CGFloat b = (CGFloat)arc4random_uniform(256) / 255.f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

- (UIViewAnimationOptions)leftSideViewsAnimationConfigure {
    NSUInteger animationSet = arc4random_uniform(4);
    animationSet = animationSet << 16;
    animationSet = animationSet | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse;
    return animationSet;
}

- (NSArray *)randomClockWiseCornerViewsMove {
    NSArray *directionToMove = nil;
    self.cornerViewDirection = arc4random() % 2;
    
    UIView *redView = self.cornerViewsAndKeys[CornerViewRed];
    UIView *yellowView = self.cornerViewsAndKeys[CornerViewYellow];
    UIView *blueView = self.cornerViewsAndKeys[CornerViewBlue];
    UIView *greenView = self.cornerViewsAndKeys[CornerViewGreen];
    
    NSString *redViewMoveTo = [self possiblePointsToMove:redView direction:self.cornerViewDirection];
    NSString *yellowViewMoveTo = [self possiblePointsToMove:yellowView direction:self.cornerViewDirection];
    NSString *blueViewMoveTo = [self possiblePointsToMove:blueView direction:self.cornerViewDirection];
    NSString *greenViewMoveTo = [self possiblePointsToMove:greenView direction:self.cornerViewDirection];
    
    directionToMove = @[redViewMoveTo, yellowViewMoveTo, blueViewMoveTo, greenViewMoveTo];
    return directionToMove;
}

- (NSString *)possiblePointsToMove:(UIView *)view direction:(CornerViewDirection)direction {
    //вычисление соседних точек от view
    //точки возможного движения при определенном direction
    //анимационно меняем цвет вью на цвет той что было в углу до него
    NSString *viewCenter = NSStringFromCGPoint(view.center);
    NSString *leftTop = self.cornerViewCoordinates[CornerViewRed];
    NSString *rightTop = self.cornerViewCoordinates[CornerViewYellow];
    NSString *rightBottom = self.cornerViewCoordinates[CornerViewBlue];
    NSString *leftBottom = self.cornerViewCoordinates[CornerViewGreen];
    
    if ([viewCenter isEqualToString:leftTop]) {
        if (direction == CornerViewDirectionClockWise) {
            [self animateChangeViewColor:view color:[UIColor yellowColor]];
            return rightTop;
        } else {
            [self animateChangeViewColor:view color:[UIColor greenColor]];
            return leftBottom;
        }
    } else if ([viewCenter isEqualToString:rightTop]) {
        if (direction == CornerViewDirectionClockWise) {
            [self animateChangeViewColor:view color:[UIColor blueColor]];
            return rightBottom;
        } else {
            [self animateChangeViewColor:view color:[UIColor redColor]];
            return leftTop;
        }
    } else if ([viewCenter isEqualToString:rightBottom]) {
        if (direction == CornerViewDirectionClockWise) {
            [self animateChangeViewColor:view color:[UIColor greenColor]];
            return leftBottom;
        } else {
            [self animateChangeViewColor:view color:[UIColor yellowColor]];
            return rightTop;
        }
    } else if ([viewCenter isEqualToString:leftBottom]) {
        if (direction == CornerViewDirectionClockWise) {
            [self animateChangeViewColor:view color:[UIColor redColor]];
            return leftTop;
        } else {
            [self animateChangeViewColor:view color:[UIColor blueColor]];
            return rightBottom;
        }
    }

    //null check
    NSParameterAssert(direction);
    NSLog(@"direction is null");
    abort();
    return nil;
}

- (void)animateChangeViewColor:(UIView *)view color:(UIColor *)color {
    [UIView animateWithDuration:self.animationDuration animations:^{
        view.backgroundColor = color;
    }];
}

#pragma mark - _UNUSED_
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
