//
//  InfoViewController.m
//  iOSDev3601_UIPopover
//
//  Created by Oleg Tverdokhleb on 03.05.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *IBOtopDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *IBOcenterDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *IBOokButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *IBOnavigationBar;

@end

@implementation InfoViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setup];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  NSLog(@"%@ didReceiveMemoryWarning", self);
}

- (void)dealloc {
  NSLog(@"dealloc %@", self);
}

- (void)setup {
  
  self.IBOtopDescriptionLabel.text = self.topDescriptionLabel;
  self.IBOcenterDescriptionLabel.text = self.centerDescriptionLabel;
  self.IBOokButton.title = self.showOkButton ? @"OK" : @"";
  self.IBOnavigationBar.hidden = !self.showNavigationBar;
}

#pragma mark - Action

- (IBAction)actionOK:(UIButton *)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
