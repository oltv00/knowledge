//
//  ViewController.m
//  19_ViewsTest
//
//  Created by Oleg Tverdokhleb on 10.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self level1];
}

#pragma mark - Levels method

- (void)level1 {
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 150, 200, 50)];
    view1.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8f];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(80, 130, 50, 250)];
    view2.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.8f];
    view2.autoresizingMask =    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight |
                                UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:view2];
    [self.view bringSubviewToFront:view1];
}

#pragma mark - Orientation

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    NSLog(@"FROM %@", [self printOrientation:orientation]);
    NSLog(@"SIZE %@, FRAME %@, BOUNDS %@", NSStringFromCGSize(size), NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.view.bounds));
    NSLog(@"-------------------------------------------");
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        
        NSLog(@"TO %@", [self printOrientation:orientation]);
        NSLog(@"SIZE %@, FRAME %@, BOUNDS %@", NSStringFromCGSize(size), NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.view.bounds));
        CGPoint origin = CGPointZero;
        origin = [self.view convertPoint:origin toView:self.view.window];
        NSLog(@"ORIGIN %@", NSStringFromCGPoint(origin));
        NSLog(@"-------------------------------------------");
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        CGFloat width = 100;
        CGFloat height = 100;
        CGFloat x = CGRectGetMaxX(self.view.frame) - width;
        CGFloat y = 0;
        CGRect rect = CGRectMake(x, y, width, height);
        
        UIView *view = [[UIView alloc] initWithFrame:rect];
        view.backgroundColor = [UIColor blueColor];
        [self.view addSubview:view];
    }];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
- (NSString *)printOrientation:(UIInterfaceOrientation)orientation {
    switch (orientation) {
        case UIInterfaceOrientationUnknown:
            return @"UIInterfaceOrientationUnknown";
            break;
        case UIInterfaceOrientationPortrait:
            return @"UIInterfaceOrientationPortrait";
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            return @"UIInterfaceOrientationPortraitUpsideDown";
            break;
        case UIInterfaceOrientationLandscapeLeft:
            return @"UIInterfaceOrientationLandscapeLeft";
            break;
        case UIInterfaceOrientationLandscapeRight:
            return @"UIInterfaceOrientationLandscapeRight";
            break;
        default:
            break;
    return @"NULL";
    }
}

#pragma mark - __UNUSED__

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
