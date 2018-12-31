//
//  ViewController.m
//  20_OutletsTest
//
//  Created by Oleg Tverdokhleb on 10.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *leftView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor *)randomColor {
    CGFloat r = (CGFloat)arc4random_uniform(256) / 255;
    CGFloat g = (CGFloat)arc4random_uniform(256) / 255;
    CGFloat b = (CGFloat)arc4random_uniform(256) / 255;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    self.rightView.backgroundColor = [self randomColor];
    self.leftView.backgroundColor = [self randomColor];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

@end
