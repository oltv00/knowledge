//
//  DummyTableViewController.m
//  iOSDev3301_FileManagerTest
//
//  Created by Oleg Tverdokhleb on 30.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "DummyTableViewController.h"

@interface DummyTableViewController ()

@end

@implementation DummyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Segue

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
  NSLog(@"shouldPerformSegueWithIdentifier: %@", identifier);
  return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSLog(@"prepareForSegue: %@", segue.identifier);
}

@end
