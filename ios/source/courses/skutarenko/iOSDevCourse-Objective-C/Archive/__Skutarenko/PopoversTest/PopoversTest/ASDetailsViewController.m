//
//  ASDetailsViewController.m
//  PopoversTest
//
//  Created by Oleksii Skutarenko on 06.01.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import "ASDetailsViewController.h"

@interface ASDetailsViewController ()

@end

@implementation ASDetailsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (self.bgColor) {
        self.view.backgroundColor = self.bgColor;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    NSLog(@"Details deallocated");
}

@end
