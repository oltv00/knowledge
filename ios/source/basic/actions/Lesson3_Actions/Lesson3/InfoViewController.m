//
//  InfoViewController.m
//  Lesson3
//
//  Created by Oleg Tverdokhleb on 03.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

- (IBAction)actionBackButton:(id)sender;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)actionBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
