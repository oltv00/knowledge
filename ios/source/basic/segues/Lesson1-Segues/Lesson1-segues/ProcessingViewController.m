//
//  ProcessingViewController.m
//  Lesson1-segues
//
//  Created by Oleg Tverdokhleb on 12.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ProcessingViewController.h"
#import "DetailedViewController.h"

@interface ProcessingViewController ()

@end

@implementation ProcessingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[DetailedViewController class]]) {
        DetailedViewController *vc = [segue destinationViewController];
        vc.string = self.string;
    }
}

@end
