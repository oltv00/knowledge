//
//  MRQModallyViewController.m
//  36_UIPopoverController_PopoversTest
//
//  Created by Oleg Tverdokhleb on 20.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQModallyViewController.h"

@interface MRQModallyViewController ()

@end

@implementation MRQModallyViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc {
    NSLog(@"Modally controller was deallocated");
}
#pragma mark - Initial

- (void) setup {
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - Additional

#pragma mark - Touches

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
