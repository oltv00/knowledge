//
//  ViewController.m
//  24_DrawingsTest
//
//  Created by Oleg Tverdokhleb on 12.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "MRQDrawingView.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - General methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Orientation

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {

    [self.drawingView setNeedsDisplay]; //Метод говорит view что она должна быть перересованна
}

@end
