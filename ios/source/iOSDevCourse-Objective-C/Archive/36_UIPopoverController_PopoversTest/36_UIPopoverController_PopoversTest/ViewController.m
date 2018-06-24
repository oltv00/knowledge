//
//  ViewController.m
//  36_UIPopoverController_PopoversTest
//
//  Created by Oleg Tverdokhleb on 20.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "MRQModallyViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - LifeCycle

- (void) loadView {
    [super loadView];
    [self setup];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Initial

- (void) setup {
    [self createPopBarButtonItem];
}

#pragma mark - Additional

- (void) createPopBarButtonItem {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"info"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(actionInfoBarButtonWasPressed:)];
    [self.navigationItem setRightBarButtonItem:item];
}

#pragma mark - Action

- (void) actionInfoBarButtonWasPressed:(UIBarButtonItem *) sender {
    
    MRQModallyViewController *vc = [[MRQModallyViewController alloc] init];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

@end
