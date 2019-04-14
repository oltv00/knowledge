//
//  InfoViewController.m
//  Lesson4HW
//
//  Created by Oleg Tverdokhleb on 06.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

- (IBAction)actionDismissButton:(id)sender;

@end

@implementation InfoViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"viewDidLoad %@", self);
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup {
    self.infoLabel.text = @"About this app";
}

#pragma mark - Action

- (IBAction)actionDismissButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
