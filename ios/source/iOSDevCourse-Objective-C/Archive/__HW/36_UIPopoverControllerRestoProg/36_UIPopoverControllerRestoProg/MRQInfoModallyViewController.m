//
//  MRQInfoPopoverViewController.m
//  36_UIPopoverControllerRestoProg
//
//  Created by Oleg Tverdokhleb on 20.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQInfoModallyViewController.h"

@interface MRQInfoModallyViewController ()

@end

@implementation MRQInfoModallyViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc {
    NSLog(@"MRQInfoModallyViewController deallocated");
}

#pragma mark - Initial

- (void) setup {
    
}

#pragma mark - Action

-(IBAction) actionBackBarButtonItemWasPressed:(UIBarButtonItem *)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
