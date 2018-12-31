//
//  ViewController.m
//  24_DrawingHW
//
//  Created by Oleg Tverdokhleb on 18.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "DrawingView.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View cycles
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Orientation
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.drawingView setNeedsDisplay];
}

@end
