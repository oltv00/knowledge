//
//  RJInfoViewController.m
//  Lesson36Ex
//
//  Created by Hopreeeeenjust on 01.02.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "RJInfoViewController.h"
#import "ViewController.h"

@interface RJInfoViewController ()
@end

@implementation RJInfoViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.okButton setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)actionOkButtonPushed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
