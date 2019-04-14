//
//  ViewController.m
//  17_ViewControllersTest
//
//  Created by Oleg Tverdokhleb on 26.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Loading

- (void) loadView {
    
    [super loadView];
    
    NSLog(@"loadView");
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad");
    
    self.view.backgroundColor = [UIColor redColor];

}

#pragma mark - Views

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    NSLog(@"viewWillAppear");
    
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    NSLog(@"viewDidAppear");

}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    NSLog(@"viewWillLayoutSubviews");
    
}

- (void)viewDidLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    NSLog(@"viewDidLayoutSubviews");
    
}

#pragma mark - Rotation

- (BOOL)shouldAutorotate {
    return YES;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskPortrait;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(@"willRotateToInterfaceOrientation fron %ld to %ld", toInterfaceOrientation, self.interfaceOrientation);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {

    NSLog(@"didRotateFromInterfaceOrientation from %ld to %ld", self.interfaceOrientation, fromInterfaceOrientation);
    
}


#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
