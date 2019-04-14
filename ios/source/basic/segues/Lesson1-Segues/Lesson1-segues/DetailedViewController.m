//
//  DetailedViewController.m
//  Lesson1-segues
//
//  Created by Oleg Tverdokhleb on 12.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "DetailedViewController.h"

@interface DetailedViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.label.text = self.string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
