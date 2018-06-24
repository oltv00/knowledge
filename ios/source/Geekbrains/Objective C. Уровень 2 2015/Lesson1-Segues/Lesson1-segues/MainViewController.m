//
//  MainViewController.m
//  Lesson1-segues
//
//  Created by Oleg Tverdokhleb on 12.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MainViewController.h"
#import "ProcessingViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[ProcessingViewController class]]) {
        
        ProcessingViewController *vc = [segue destinationViewController];
        vc.string = self.textField.text;
    }
}

@end
